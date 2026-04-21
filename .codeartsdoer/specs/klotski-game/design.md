# 华容道游戏技术设计文档

## 1. 架构概述

### 1.1 系统架构图

```
┌─────────────────────────────────────────────────────────────┐
│                      Index.ets (入口页面)                      │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────┐  │
│  │  GameHeader     │  │  GameBoard      │  │ GameFooter  │  │
│  │  (标题区域)      │  │  (棋盘区域)      │  │ (按钮区域)   │  │
│  └─────────────────┘  └─────────────────┘  └─────────────┘  │
├─────────────────────────────────────────────────────────────┤
│                    GameStateManager                          │
│                  (游戏状态管理器)                              │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────┐  │
│  │  LevelManager   │  │  MoveValidator  │  │ WinChecker  │  │
│  │  (关卡管理器)    │  │  (移动验证器)    │  │(胜利检测器)  │  │
│  └─────────────────┘  └─────────────────┘  └─────────────┘  │
├─────────────────────────────────────────────────────────────┤
│                      Data Models                             │
│  (Piece, Position, Level, BoardState)                        │
└─────────────────────────────────────────────────────────────┘
```

### 1.2 技术栈选型

| 技术项 | 选型 | 说明 |
|-------|------|------|
| 开发框架 | HarmonyOS ArkTS | 基于ArkUI声明式开发范式 |
| UI组件 | @Component装饰器 | 自定义组件化开发 |
| 状态管理 | @State/@Prop装饰器 | 响应式状态管理 |
| 布局容器 | Column/Row/Stack | 弹性布局适配多屏幕 |
| 动画 | animateTo | 属性动画实现移动效果 |
| 开发环境 | DevEco Studio | HarmonyOS官方IDE |

---

## 2. 数据模型设计

### 2.1 核心类型定义

```typescript
// 棋子类型枚举
enum PieceType {
  CAOCAO = 'caocao',      // 曹操 (2×2)
  GENERAL = 'general',    // 武将 (2×1 竖向)
  SOLDIER = 'soldier'     // 兵卒 (1×1)
}

// 位置坐标
interface Position {
  row: number;    // 行号 (0-4)
  col: number;    // 列号 (0-3)
}

// 棋子尺寸
interface Size {
  width: number;   // 宽度（占几列）
  height: number;  // 高度（占几行）
}

// 棋子数据模型
interface Piece {
  id: string;           // 唯一标识
  name: string;         // 显示名称
  type: PieceType;      // 棋子类型
  position: Position;   // 当前位置
  size: Size;           // 尺寸
  color: string;        // 颜色
}

// 关卡数据模型
interface Level {
  id: number;           // 关卡ID
  name: string;         // 关卡名称
  difficulty: string;   // 难度等级
  pieces: Piece[];      // 初始棋子布局
}

// 棋盘状态
interface BoardState {
  pieces: Piece[];      // 当前所有棋子
  selectedPieceId: string | null;  // 选中的棋子ID
  moveCount: number;    // 移动步数
  currentLevelId: number;  // 当前关卡ID
  isWin: boolean;       // 是否胜利
}
```

### 2.2 棋子尺寸映射

```typescript
const PIECE_SIZE_MAP: Map<PieceType, Size> = {
  [PieceType.CAOCAO]: { width: 2, height: 2 },
  [PieceType.GENERAL]: { width: 1, height: 2 },
  [PieceType.SOLDIER]: { width: 1, height: 1 }
};
```

### 2.3 棋子颜色配置

```typescript
const PIECE_COLORS = {
  caocao: '#E74C3C',      // 红色 - 曹操
  general: '#3498DB',     // 蓝色 - 武将
  soldier: '#2ECC71',     // 绿色 - 兵卒
  selected: '#F39C12',    // 橙色 - 选中状态边框
  board: '#ECF0F1',       // 浅灰 - 棋盘背景
  border: '#2C3E50'       // 深灰 - 边框
};
```

---

## 3. 组件设计

### 3.1 组件层次结构

```
Index (主页面)
├── GameHeader (游戏标题区)
│   ├── Text (游戏标题)
│   ├── Text (关卡名称)
│   └── Text (步数显示)
├── GameBoard (游戏棋盘区)
│   ├── BoardGrid (棋盘网格)
│   │   └── PieceBlock[] (棋子组件数组)
│   └── ExitIndicator (出口标识)
├── GameFooter (操作按钮区)
│   ├── Button (重置按钮)
│   └── Button (选关按钮)
└── LevelSelector (关卡选择弹窗)
    └── LevelItem[] (关卡选项列表)
```

### 3.2 主页面组件 (Index.ets)

**职责**：应用入口，管理全局游戏状态

**状态定义**：
```typescript
@State boardState: BoardState;        // 棋盘状态
@State showLevelSelector: boolean;    // 显示关卡选择器
@State levels: Level[];               // 关卡列表
```

**主要方法**：
```typescript
// 初始化游戏
initGame(): void

// 处理棋子点击
handlePieceClick(pieceId: string): void

// 处理棋子移动
handlePieceMove(pieceId: string, direction: Direction): void

// 重置游戏
resetGame(): void

// 切换关卡
switchLevel(levelId: number): void

// 检查胜利
checkWin(): boolean
```

### 3.3 棋子组件 (PieceBlock.ets)

**职责**：渲染单个棋子，处理交互

**属性定义**：
```typescript
@Prop piece: Piece;           // 棋子数据
@Prop isSelected: boolean;    // 是否选中
@Prop cellSize: number;       // 单元格尺寸
```

**样式计算**：
```typescript
// 计算棋子位置和尺寸
getPieceStyle(): Style {
  return {
    left: this.piece.position.col * this.cellSize,
    top: this.piece.position.row * this.cellSize,
    width: this.piece.size.width * this.cellSize,
    height: this.piece.size.height * this.cellSize
  };
}
```

### 3.4 棋盘组件 (GameBoard.ets)

**职责**：渲染棋盘网格，管理棋子布局

**属性定义**：
```typescript
@Prop pieces: Piece[];              // 棋子数组
@Prop selectedPieceId: string;      // 选中棋子ID
@Link boardState: BoardState;       // 棋盘状态（双向绑定）
```

**常量定义**：
```typescript
const BOARD_COLS = 4;    // 棋盘列数
const BOARD_ROWS = 5;    // 棋盘行数
const CELL_SIZE = 80;    // 单元格尺寸（vp）
```

---

## 4. 核心算法设计

### 4.1 移动验证算法

```
算法: validateMove(piece, direction, boardState)
输入: piece-待移动棋子, direction-移动方向, boardState-当前状态
输出: boolean-是否可移动

步骤:
1. 计算目标位置 targetPos = piece.position + direction偏移
2. 检查边界条件:
   - 若 targetPos.row < 0 或 targetPos.row + piece.height > 5，返回 false
   - 若 targetPos.col < 0 或 targetPos.col + piece.width > 4，返回 false
3. 检查碰撞条件:
   - 遍历所有其他棋子 otherPiece
   - 若 otherPiece 与 piece 在目标位置重叠，返回 false
4. 返回 true
```

### 4.2 碰撞检测算法

```
算法: checkCollision(piece1, piece2)
输入: piece1, piece2 - 两个棋子
输出: boolean-是否碰撞

步骤:
1. 获取 piece1 的边界: [r1, r1+h1) × [c1, c1+w1)
2. 获取 piece2 的边界: [r2, r2+h2) × [c2, c2+w2)
3. 若 r1 >= r2+h2 或 r2 >= r1+h1，返回 false (行不重叠)
4. 若 c1 >= c2+w2 或 c2 >= c1+w1，返回 false (列不重叠)
5. 返回 true (存在重叠)
```

### 4.3 胜利检测算法

```
算法: checkWin(pieces)
输入: pieces-当前所有棋子
输出: boolean-是否胜利

步骤:
1. 查找曹操棋子 caocao = pieces.find(p => p.type === 'caocao')
2. 检查曹操位置:
   - 若 caocao.position.row === 3 且 caocao.position.col === 1，返回 true
3. 返回 false
```

### 4.4 移动方向判定算法（支持滑动操作）

```
算法: detectDirection(startPos, endPos)
输入: startPos-起始坐标, endPos-结束坐标
输出: Direction-移动方向

步骤:
1. 计算 dx = endPos.x - startPos.x
2. 计算 dy = endPos.y - startPos.y
3. 若 |dx| > |dy|:
   - 若 dx > threshold，返回 RIGHT
   - 若 dx < -threshold，返回 LEFT
4. 否则:
   - 若 dy > threshold，返回 DOWN
   - 若 dy < -threshold，返回 UP
5. 返回 NONE (移动距离不足)
```

---

## 5. 关卡数据设计

### 5.1 关卡数据结构

```typescript
const LEVELS: Level[] = [
  {
    id: 1,
    name: '横刀立马',
    difficulty: '简单',
    pieces: [
      { id: 'caocao', name: '曹操', type: PieceType.CAOCAO,
        position: { row: 0, col: 1 }, size: { width: 2, height: 2 },
        color: '#E74C3C' },
      { id: 'g1', name: '关羽', type: PieceType.GENERAL,
        position: { row: 0, col: 0 }, size: { width: 1, height: 2 },
        color: '#3498DB' },
      { id: 'g2', name: '张飞', type: PieceType.GENERAL,
        position: { row: 0, col: 3 }, size: { width: 1, height: 2 },
        color: '#3498DB' },
      { id: 'g3', name: '赵云', type: PieceType.GENERAL,
        position: { row: 2, col: 0 }, size: { width: 1, height: 2 },
        color: '#3498DB' },
      { id: 'g4', name: '马超', type: PieceType.GENERAL,
        position: { row: 2, col: 3 }, size: { width: 1, height: 2 },
        color: '#3498DB' },
      { id: 's1', name: '兵', type: PieceType.SOLDIER,
        position: { row: 2, col: 1 }, size: { width: 1, height: 1 },
        color: '#2ECC71' },
      { id: 's2', name: '兵', type: PieceType.SOLDIER,
        position: { row: 2, col: 2 }, size: { width: 1, height: 1 },
        color: '#2ECC71' },
      { id: 's3', name: '兵', type: PieceType.SOLDIER,
        position: { row: 3, col: 1 }, size: { width: 1, height: 1 },
        color: '#2ECC71' },
      { id: 's4', name: '兵', type: PieceType.SOLDIER,
        position: { row: 3, col: 2 }, size: { width: 1, height: 1 },
        color: '#2ECC71' }
    ]
  },
  // 关卡2、3数据类似结构...
];
```

### 5.2 关卡布局示意图

**关卡1 - 横刀立马（初始布局）**:
```
┌──┬────┬──┐
│关│    │张│
│羽│曹操│飞│
├──┤    ├──┤
│赵│兵兵│马│
│云│    │超│
├──┼──┬──┼──┤
│  │兵│兵│  │
├──┼──┴──┼──┤
│  │ 出口 │  │
└──┴─────┴──┘
```

---

## 6. 界面交互设计

### 6.1 棋子选择交互

```
用户操作流程:
1. 用户点击棋子
2. 系统判断:
   - 若该棋子已选中 → 取消选中，清除高亮
   - 若其他棋子已选中 → 取消原选中，选中新棋子
   - 若无棋子选中 → 选中该棋子，显示高亮边框
3. 更新 boardState.selectedPieceId
4. 触发UI重渲染
```

### 6.2 棋子移动交互（点击方式）

```
用户操作流程:
1. 用户选中棋子后，点击相邻空格
2. 系统判断点击位置相对棋子的方向
3. 调用 validateMove() 验证移动合法性
4. 若合法:
   - 更新棋子位置
   - 步数 +1
   - 播放移动动画
   - 检查胜利条件
5. 若非法:
   - 显示震动或闪烁反馈
```

### 6.3 棋子移动交互（滑动方式）

```
用户操作流程:
1. 用户在棋子上按下并滑动
2. 系统记录起始位置，监听移动事件
3. 用户释放时，计算滑动方向
4. 调用 validateMove() 验证移动合法性
5. 若合法且滑动距离超过阈值:
   - 执行移动逻辑
6. 若非法或距离不足:
   - 棋子回弹到原位置
```

---

## 7. 动画设计

### 7.1 棋子移动动画

```typescript
// 使用 animateTo 实现平滑移动
animateTo({
  duration: 200,          // 动画时长 200ms
  curve: Curve.EaseOut,   // 缓动曲线
  onFinish: () => {
    // 动画完成后检查胜利
    this.checkWin();
  }
}, () => {
  // 更新棋子位置状态
  piece.position = targetPosition;
});
```

### 7.2 选中高亮动画

```typescript
// 选中状态边框闪烁效果
@State selectedBorderWidth: number = 2;

// 在定时器中循环改变边框宽度
setInterval(() => {
  this.selectedBorderWidth = this.selectedBorderWidth === 2 ? 4 : 2;
}, 500);
```

---

## 8. 文件结构设计

```
entry/src/main/ets/
├── pages/
│   └── Index.ets              # 主页面（入口）
├── components/
│   ├── GameHeader.ets         # 游戏标题组件
│   ├── GameBoard.ets          # 游戏棋盘组件
│   ├── PieceBlock.ets         # 棋子组件
│   ├── GameFooter.ets         # 操作按钮组件
│   └── LevelSelector.ets      # 关卡选择器组件
├── models/
│   ├── Piece.ets              # 棋子数据模型
│   ├── Position.ets           # 位置模型
│   ├── Level.ets              # 关卡模型
│   └── BoardState.ets         # 棋盘状态模型
├── managers/
│   ├── GameStateManager.ets   # 游戏状态管理器
│   ├── LevelManager.ets       # 关卡管理器
│   ├── MoveValidator.ets      # 移动验证器
│   └── WinChecker.ets         # 胜利检测器
├── data/
│   └── LevelData.ets          # 关卡数据配置
└── constants/
    └── GameConstants.ets      # 游戏常量配置
```

---

## 9. 接口设计

### 9.1 GameStateManager 接口

```typescript
class GameStateManager {
  // 获取当前棋盘状态
  getBoardState(): BoardState;

  // 初始化游戏
  initGame(levelId: number): void;

  // 选择棋子
  selectPiece(pieceId: string): void;

  // 移动棋子
  movePiece(pieceId: string, direction: Direction): boolean;

  // 重置游戏
  resetGame(): void;

  // 切换关卡
  switchLevel(levelId: number): void;

  // 检查胜利
  checkWin(): boolean;
}
```

### 9.2 MoveValidator 接口

```typescript
class MoveValidator {
  // 验证移动是否合法
  validate(piece: Piece, direction: Direction, pieces: Piece[]): boolean;

  // 检测两个棋子是否碰撞
  checkCollision(piece1: Piece, piece2: Piece): boolean;

  // 获取可移动方向列表
  getValidDirections(piece: Piece, pieces: Piece[]): Direction[];
}
```

### 9.3 LevelManager 接口

```typescript
class LevelManager {
  // 获取所有关卡
  getAllLevels(): Level[];

  // 获取指定关卡
  getLevel(levelId: number): Level;

  // 获取关卡数量
  getLevelCount(): number;
}
```

---

## 10. 错误处理设计

### 10.1 异常场景处理

| 异常场景 | 处理方式 |
|---------|---------|
| 关卡数据加载失败 | 显示错误提示，使用默认关卡 |
| 棋子移动越界 | 阻止移动，无操作反馈 |
| 碰撞检测异常 | 阻止移动，记录日志 |
| 状态更新失败 | 回滚状态，显示错误提示 |

### 10.2 边界条件处理

- 棋盘边界：row ∈ [0, 4], col ∈ [0, 3]
- 棋子ID唯一性校验
- 空指针检查（selectedPieceId为null时）

---

## 11. 性能优化设计

### 11.1 渲染优化

- 使用 `@Prop` 传递只读数据，减少不必要的状态更新
- 棋子组件使用 `shouldUpdate` 生命周期控制更新
- 避免在 `build()` 方法中进行复杂计算

### 11.2 算法优化

- 碰撞检测使用空间换时间，预计算占用格子集合
- 移动验证时只检查相邻格子，不遍历整个棋盘

---

## 12. 测试策略

### 12.1 单元测试范围

- MoveValidator 的移动验证逻辑
- WinChecker 的胜利检测逻辑
- 碰撞检测算法

### 12.2 集成测试范围

- 完整游戏流程：选择关卡 → 移动棋子 → 胜利判定
- 关卡切换流程
- 游戏重置流程

### 12.3 UI测试范围

- 棋子点击响应
- 滑动手势识别
- 界面布局适配
