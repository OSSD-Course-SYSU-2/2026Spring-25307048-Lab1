// 胜利检测器

import { Piece, PieceType } from '../models/Piece';

// 胜利检测器类
export class WinChecker {
  // 检查是否胜利(曹操到达出口位置)
  static checkWin(pieces: Piece[]): boolean {
    // 查找曹操棋子
    const caocao = pieces.find(piece => piece.type === PieceType.CAOCAO);
    
    if (!caocao) {
      return false;
    }
    
    // 曹操胜利位置: row=3, col=1 (出口位置)
    // 曹操是2x2的棋子,所以左上角在(3,1)时,正好占据出口
    if (caocao.position.row === 3 && caocao.position.col === 1) {
      return true;
    }
    
    return false;
  }
}
