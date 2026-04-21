// 棋子数据模型

// 棋子类型枚举
export enum PieceType {
  CAOCAO = 'CAOCAO',     // 曹操(2x2)
  GENERAL = 'GENERAL',   // 武将(1x2或2x1)
  SOLDIER = 'SOLDIER'    // 兵卒(1x1)
}

// 位置接口
export interface Position {
  row: number;  // 行位置(0-4)
  col: number;  // 列位置(0-3)
}

// 尺寸接口
export interface Size {
  width: number;   // 宽度(占几列)
  height: number;  // 高度(占几行)
}

// 棋子接口
export interface Piece {
  id: string;           // 棋子唯一标识
  name: string;         // 棋子名称
  type: PieceType;      // 棋子类型
  position: Position;   // 当前位置
  size: Size;           // 棋子尺寸
  color: string;        // 棋子颜色
}
