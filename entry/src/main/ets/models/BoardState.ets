// 棋盘状态模型

import { Piece } from './Piece';

// 棋盘状态接口
export interface BoardState {
  pieces: Piece[];           // 当前所有棋子
  selectedPieceId: string | null;  // 当前选中的棋子ID
  moveCount: number;         // 移动步数
  currentLevelId: number;    // 当前关卡ID
  isWin: boolean;            // 是否胜利
}
