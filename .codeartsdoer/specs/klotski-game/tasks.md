# 华容道游戏编码任务清单

## 任务概述

本文档将技术设计转化为具体的编码实现任务，按照依赖关系和优先级排序，确保开发过程有序进行。

---

## 任务 1：项目基础结构搭建

### 任务描述
创建项目所需的目录结构和基础配置文件，为后续开发奠定基础。

### 输入
- 技术设计文档中的文件结构设计

### 输出
- 完整的项目目录结构
- 游戏常量配置文件

### 验收标准
- 所有目录创建成功：components、models、managers、data、constants
- GameConstants.ets 文件包含所有游戏常量定义
- 项目编译无错误

### 子任务

#### 1.1 创建目录结构
在 `entry/src/main/ets/` 下创建以下目录：
- components/
- models/
- managers/
- data/
- constants/

#### 1.2 创建游戏常量配置文件
创建 `constants/GameConstants.ets`，包含：
- 棋盘尺寸常量（BOARD_COLS=4, BOARD_ROWS=5, CELL_SIZE=80）
- 棋子颜色配置
- 移动方向枚举
- 动画时长配置

### 代码生成提示
```
创建 GameConstants.ets 文件，定义棋盘尺寸、颜色、方向枚举等常量。
使用 export 导出常量和枚举，便于其他模块引用。
```

---

## 任务 2：数据模型定义

### 任务描述
定义游戏中所有核心数据类型和接口，确保类型安全。

### 输入
- 技术设计文档中的数据模型设计

### 输出
- 完整的数据模型文件

### 验收标准
- 所有接口和类型定义完整
- 类型定义符合ArkTS语法规范
- 导出正确，可被其他模块引用

### 子任务

#### 2.1 创建棋子类型枚举和基础模型
创建 `models/Piece.ets`，定义：
- PieceType 枚举（CAOCAO, GENERAL, SOLDIER）
- Position 接口（row, col）
- Size 接口（width, height）
- Piece 接口（id, name, type, position, size, color）

#### 2.2 创建关卡模型
创建 `models/Level.ets`，定义：
- Level 接口（id, name, difficulty, pieces）

#### 2.3 创建棋盘状态模型
创建 `models/BoardState.ets`，定义：
- BoardState 接口（pieces, selectedPieceId, moveCount, currentLevelId, isWin）

### 代码生成提示
```
使用 ArkTS 的 interface 和 enum 语法定义数据模型。
所有模型使用 export 导出，确保类型安全。
Position 的 row 范围 0-4，col 范围 0-3。
```

---

## 任务 3：关卡数据配置

### 任务描述
创建游戏关卡数据，包含至少3个不同难度的关卡布局。

### 输入
- 技术设计文档中的关卡数据设计
- 数据模型定义

### 输出
- LevelData.ets 文件，包含完整的关卡数据

### 验收标准
- 至少包含3个关卡数据
- 每个关卡的棋子布局正确（1个曹操、4个武将、4个兵卒）
- 关卡布局确保有解

### 子任务

#### 3.1 创建关卡数据文件
创建 `data/LevelData.ets`，包含：
- LEVELS 数组，存储所有关卡
- 每个关卡包含完整的棋子初始位置信息
- 关卡名称和难度等级

#### 3.2 验证关卡数据正确性
确保每个关卡：
- 棋子数量正确（共9个棋子）
- 棋子位置不重叠
- 棋子不超出棋盘边界

### 代码生成提示
```
定义 LEVELS 常量数组，每个元素是一个 Level 对象。
关卡1：横刀立马（简单）- 曹操在顶部中央
关卡2：指挥若定（中等）- 不同的初始布局
关卡3：兵分三路（困难）- 更复杂的布局
确保每个棋子的 position 和 size 正确设置。
```

---

## 任务 4：核心算法实现

### 任务描述
实现游戏核心算法，包括移动验证、碰撞检测、胜利判定。

### 输入
- 技术设计文档中的算法设计
- 数据模型定义

### 输出
- MoveValidator.ets - 移动验证器
- WinChecker.ets - 胜利检测器

### 验收标准
- 移动验证算法正确判断边界和碰撞
- 碰撞检测算法准确识别棋子重叠
- 胜利判定算法正确识别曹操到达出口

### 子任务

#### 4.1 实现碰撞检测算法
创建 `managers/MoveValidator.ets`，实现：
- checkCollision(piece1, piece2) 方法
- 判断两个棋子是否在位置上重叠

#### 4.2 实现移动验证算法
在 MoveValidator.ets 中添加：
- validateMove(piece, direction, pieces) 方法
- 检查边界条件和碰撞条件
- 返回是否可移动

#### 4.3 实现胜利检测算法
创建 `managers/WinChecker.ets`，实现：
- checkWin(pieces) 方法
- 判断曹操是否在出口位置（row=3, col=1）

### 代码生成提示
```
碰撞检测：检查两个棋子的边界矩形是否重叠。
移动验证：先计算目标位置，再检查边界和碰撞。
胜利检测：查找曹操棋子，检查其位置是否为 (3, 1)。
使用纯函数实现，便于测试。
```

---

## 任务 5：游戏状态管理器实现

### 任务描述
实现游戏状态管理器，统一管理游戏状态和业务逻辑。

### 输入
- 数据模型定义
- 核心算法实现

### 输出
- GameStateManager.ets - 游戏状态管理器
- LevelManager.ets - 关卡管理器

### 验收标准
- 游戏初始化正确加载关卡数据
- 棋子选择和移动逻辑正确
- 游戏重置功能正常

### 子任务

#### 5.1 实现关卡管理器
创建 `managers/LevelManager.ets`，实现：
- getAllLevels() - 获取所有关卡
- getLevel(levelId) - 获取指定关卡
- getLevelCount() - 获取关卡数量

#### 5.2 实现游戏状态管理器
创建 `managers/GameStateManager.ets`，实现：
- 状态管理属性（pieces, selectedPieceId, moveCount等）
- initGame(levelId) - 初始化游戏
- selectPiece(pieceId) - 选择棋子
- movePiece(pieceId, direction) - 移动棋子
- resetGame() - 重置游戏
- checkWin() - 检查胜利

### 代码生成提示
```
GameStateManager 使用类实现，内部维护游戏状态。
initGame 从 LevelManager 获取关卡数据，深拷贝棋子数组。
movePiece 调用 MoveValidator 验证，更新位置和步数。
resetGame 重新加载当前关卡，步数归零。
```

---

## 任务 6：UI组件实现 - 棋子组件

### 任务描述
实现棋子渲染组件，支持不同类型棋子的显示和交互。

### 输入
- 数据模型定义
- 游戏常量配置

### 输出
- PieceBlock.ets - 棋子组件

### 验收标准
- 正确渲染不同类型和尺寸的棋子
- 选中状态显示高亮边框
- 支持点击和滑动手势

### 子任务

#### 6.1 创建棋子组件基础结构
创建 `components/PieceBlock.ets`，包含：
- @Component 装饰器
- @Prop 属性：piece, isSelected, cellSize
- 基础 build() 方法

#### 6.2 实现棋子样式计算
实现棋子位置和尺寸的动态计算：
- 根据 piece.position 计算位置
- 根据 piece.size 计算尺寸
- 根据 piece.color 设置背景色

#### 6.3 实现选中状态样式
添加选中状态的高亮效果：
- 选中时显示橙色边框
- 边框宽度动态变化

#### 6.4 实现手势交互
添加手势处理：
- onClick 事件处理
- PanGesture 滑动手势处理
- 回调函数传递给父组件

### 代码生成提示
```
使用 @Component 和 @Prop 定义组件。
使用 Stack 或 Column 作为根容器。
使用绝对定位（position属性）设置棋子位置。
使用 border 属性实现选中高亮。
使用 gesture 绑定 PanGesture 手势。
```

---

## 任务 7：UI组件实现 - 棋盘组件

### 任务描述
实现游戏棋盘组件，管理棋子布局和渲染。

### 输入
- PieceBlock 组件
- 游戏常量配置

### 输出
- GameBoard.ets - 棋盘组件

### 验收标准
- 正确渲染4×5的棋盘网格
- 正确渲染所有棋子
- 底部显示出口标识

### 子任务

#### 7.1 创建棋盘组件基础结构
创建 `components/GameBoard.ets`，包含：
- @Component 装饰器
- @Prop 属性：pieces, selectedPieceId
- @Link 属性：boardState
- build() 方法

#### 7.2 实现棋盘网格渲染
使用 Stack 容器：
- 设置棋盘背景色和边框
- 尺寸为 4×CELL_SIZE × 5×CELL_SIZE

#### 7.3 实现棋子列表渲染
使用 ForEach 遍历 pieces：
- 为每个棋子创建 PieceBlock 组件
- 传递 piece 数据和选中状态
- 绑定点击和移动回调

#### 7.4 实现出口标识
在棋盘底部中央添加出口标识：
- 使用 Text 或 Image 组件
- 位置在 (row=4, col=1-2)

### 代码生成提示
```
使用 Stack 作为棋盘容器，便于绝对定位棋子。
使用 ForEach(pieces, ...) 渲染棋子列表。
棋盘尺寸：width = 4 * CELL_SIZE, height = 5 * CELL_SIZE。
出口标识使用半透明背景或特殊边框样式。
```

---

## 任务 8：UI组件实现 - 标题和按钮组件

### 任务描述
实现游戏标题区域和操作按钮区域组件。

### 输入
- 游戏常量配置

### 输出
- GameHeader.ets - 标题组件
- GameFooter.ets - 按钮组件

### 验收标准
- 标题区域显示游戏名称、关卡信息、步数
- 按钮区域包含重置和选关按钮
- 按钮有点击效果

### 子任务

#### 8.1 创建标题组件
创建 `components/GameHeader.ets`，包含：
- 游戏标题文本
- 当前关卡名称
- 移动步数显示
- 使用 Row 水平布局

#### 8.2 创建按钮组件
创建 `components/GameFooter.ets`，包含：
- 重置按钮
- 选关按钮
- 按钮点击回调
- 使用 Row 水平布局

### 代码生成提示
```
GameHeader 使用 Row 布局，space 设置间距。
GameFooter 使用 Row 布局，按钮使用 Button 组件。
按钮 onClick 绑定回调函数，传递给父组件。
```

---

## 任务 9：UI组件实现 - 关卡选择器

### 任务描述
实现关卡选择弹窗组件，支持关卡切换。

### 输入
- 关卡数据
- Level 模型

### 输出
- LevelSelector.ets - 关卡选择器组件

### 验收标准
- 显示所有关卡列表
- 每个关卡显示名称和难度
- 点击关卡可切换

### 子任务

#### 9.1 创建关卡选择器组件
创建 `components/LevelSelector.ets`，包含：
- @Component 装饰器
- @Prop 属性：levels, currentLevelId, visible
- 弹窗容器（使用 Column）

#### 9.2 实现关卡列表渲染
使用 ForEach 遍历关卡：
- 显示关卡名称和难度
- 当前关卡高亮显示
- 点击触发切换回调

#### 9.3 实现弹窗显示/隐藏
使用条件渲染：
- visible 为 true 时显示
- 点击背景关闭弹窗

### 代码生成提示
```
使用 if (this.visible) 控制弹窗显示。
使用 Column 和遮罩层实现弹窗效果。
ForEach 遍历 levels，每个关卡使用 Row 布局。
点击关卡项时调用 onLevelSelect 回调。
```

---

## 任务 10：主页面集成

### 任务描述
将所有组件集成到主页面，实现完整的游戏功能。

### 输入
- 所有子组件
- GameStateManager

### 输出
- Index.ets - 主页面（完整实现）

### 验收标准
- 游戏启动正常显示
- 所有交互功能正常
- 胜利检测和提示正常
- 在DevEco Studio模拟器运行无错误

### 子任务

#### 10.1 创建主页面结构
修改 `pages/Index.ets`：
- 导入所有子组件
- 定义 @State 状态属性
- 创建 GameStateManager 实例

#### 10.2 实现游戏初始化
在 aboutToAppear() 生命周期中：
- 初始化 GameStateManager
- 加载默认关卡
- 设置初始状态

#### 10.3 实现组件布局
在 build() 方法中：
- 使用 Column 垂直布局
- 依次添加 GameHeader、GameBoard、GameFooter
- 条件渲染 LevelSelector

#### 10.4 实现交互逻辑
实现回调方法：
- handlePieceClick() - 处理棋子点击
- handlePieceMove() - 处理棋子移动
- handleReset() - 处理重置
- handleShowLevelSelector() - 显示关卡选择器
- handleLevelSelect() - 切换关卡

#### 10.5 实现胜利提示
添加胜利检测和提示：
- 每次移动后检查胜利
- 胜利时显示 AlertDialog
- 提示包含完成步数

#### 10.6 实现移动动画
使用 animateTo 实现棋子移动动画：
- 移动时播放平滑动画
- 动画时长 200ms
- 使用 EaseOut 缓动曲线

### 代码生成提示
```
使用 Column 作为主容器，height 和 width 设置为 100%。
导入 GameStateManager，在 aboutToAppear 中初始化。
使用 @State 管理响应式状态，触发UI更新。
handlePieceMove 中使用 animateTo 包裹状态更新。
胜利时使用 AlertDialog.show() 显示提示。
```

---

## 任务 11：测试和调试

### 任务描述
在DevEco Studio模拟器上测试游戏，修复问题确保稳定运行。

### 输入
- 完整的游戏代码

### 输出
- 可正常运行的游戏应用

### 验收标准
- 应用启动无错误
- 所有功能正常工作
- 无内存泄漏
- 界面流畅无卡顿

### 子任务

#### 11.1 编译项目
在DevEco Studio中：
- 清理项目（Clean Project）
- 重新编译（Rebuild Project）
- 检查编译错误并修复

#### 11.2 运行测试
在模拟器上运行：
- 启动应用
- 测试棋子选择和移动
- 测试关卡切换
- 测试重置功能
- 测试胜利检测

#### 11.3 修复问题
根据测试结果：
- 修复运行时错误
- 修复UI显示问题
- 修复交互逻辑问题
- 优化性能

### 代码生成提示
```
检查控制台日志，定位错误原因。
常见问题：类型不匹配、空指针、数组越界。
使用 HiLog 输出调试信息。
确保所有 @State 变量正确初始化。
```

---

## 任务依赖关系图

```
任务1 (基础结构)
  ↓
任务2 (数据模型)
  ↓
任务3 (关卡数据) ←──┐
  ↓                 │
任务4 (核心算法)     │
  ↓                 │
任务5 (状态管理)     │
  ↓                 │
任务6 (棋子组件)     │
  ↓                 │
任务7 (棋盘组件)     │
  ↓                 │
任务8 (标题按钮)     │
  ↓                 │
任务9 (关卡选择器) ──┘
  ↓
任务10 (主页面集成)
  ↓
任务11 (测试调试)
```

---

## 任务优先级说明

| 优先级 | 任务编号 | 说明 |
|-------|---------|------|
| P0 | 1, 2, 3 | 基础设施，必须最先完成 |
| P0 | 4, 5 | 核心逻辑，游戏运行基础 |
| P1 | 6, 7, 8, 9 | UI组件，用户界面 |
| P1 | 10 | 集成，功能完整 |
| P2 | 11 | 测试，质量保证 |

---

## 需求覆盖矩阵

| 需求编号 | 需求名称 | 覆盖任务 |
|---------|---------|---------|
| 2.1.1 | 游戏棋盘显示 | 任务7 |
| 2.1.2 | 棋子显示 | 任务6 |
| 2.1.3 | 界面布局 | 任务8, 任务10 |
| 2.2.1 | 棋子选择 | 任务6, 任务10 |
| 2.2.2 | 棋子移动 | 任务4, 任务5, 任务10 |
| 2.2.3 | 移动步数统计 | 任务5, 任务8 |
| 2.3.1 | 游戏初始化 | 任务5, 任务10 |
| 2.3.2 | 游戏胜利判定 | 任务4, 任务10 |
| 2.3.3 | 游戏重置 | 任务5, 任务8, 任务10 |
| 2.4.1 | 关卡选择 | 任务9, 任务10 |
| 2.4.2 | 关卡数据 | 任务3 |
| 2.5.1 | 操作反馈 | 任务6, 任务10 |
| 2.5.2 | 界面响应性 | 任务10, 任务11 |

**所有需求均已覆盖！**
