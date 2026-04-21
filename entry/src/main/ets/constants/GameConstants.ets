// 游戏常量配置文件

// 棋盘尺寸常量
export const BOARD_COLS: number = 4;  // 棋盘列数
export const BOARD_ROWS: number = 5;  // 棋盘行数
export const CELL_SIZE: number = 80;  // 每个单元格的尺寸(像素)

// 移动方向枚举
export enum Direction {
  UP = 'UP',
  DOWN = 'DOWN',
  LEFT = 'LEFT',
  RIGHT = 'RIGHT'
}

// 棋子颜色配置
export class PieceColors {
  static readonly CAOCAO: string = '#FF6B6B';      // 曹操 - 红色
  static readonly GENERAL: string = '#4ECDC4';     // 武将 - 青色
  static readonly SOLDIER: string = '#95E1D3';     // 兵卒 - 浅绿色
  static readonly SELECTED_BORDER: string = '#FF9500';  // 选中边框 - 橙色
}

// 动画时长配置(毫秒)
export class AnimationDuration {
  static readonly PIECE_MOVE: number = 200;    // 棋子移动动画
  static readonly PIECE_SELECT: number = 150;   // 棋子选中动画
}

// 游戏文本
export class GameText {
  static readonly TITLE: string = '华容道';
  static readonly RESET: string = '重置';
  static readonly SELECT_LEVEL: string = '选关';
  static readonly WIN_MESSAGE: string = '恭喜通关！';
  static readonly MOVES: string = '步';
}
