// 关卡数据模型

import { Piece } from './Piece';

// 关卡接口
export interface Level {
  id: number;           // 关卡ID
  name: string;         // 关卡名称
  difficulty: string;   // 难度等级
  pieces: Piece[];      // 棋子初始布局
}
