// 移动验证器

import { Piece, Position, Size } from '../models/Piece';
import { Direction, BOARD_COLS, BOARD_ROWS } from '../constants/GameConstants';

// 移动验证器类
export class MoveValidator {
  // 检查两个棋子是否碰撞(重叠)
  static checkCollision(piece1: Piece, piece2: Piece): boolean {
    // 检查两个矩形是否重叠
    const left1 = piece1.position.col;
    const right1 = piece1.position.col + piece1.size.width;
    const top1 = piece1.position.row;
    const bottom1 = piece1.position.row + piece1.size.height;
    
    const left2 = piece2.position.col;
    const right2 = piece2.position.col + piece2.size.width;
    const top2 = piece2.position.row;
    const bottom2 = piece2.position.row + piece2.size.height;
    
    // 如果一个矩形在另一个矩形的左边、右边、上边或下边,则不重叠
    if (right1 <= left2 || right2 <= left1 || bottom1 <= top2 || bottom2 <= top1) {
      return false;
    }
    
    return true;
  }
  
  // 验证棋子是否可以移动到指定方向
  static validateMove(piece: Piece, direction: Direction, pieces: Piece[]): boolean {
    // 计算目标位置
    let targetRow = piece.position.row;
    let targetCol = piece.position.col;
    
    switch (direction) {
      case Direction.UP:
        targetRow -= 1;
        break;
      case Direction.DOWN:
        targetRow += 1;
        break;
      case Direction.LEFT:
        targetCol -= 1;
        break;
      case Direction.RIGHT:
        targetCol += 1;
        break;
    }
    
    // 检查边界条件
    if (targetRow < 0 || targetCol < 0) {
      return false;
    }
    
    if (targetRow + piece.size.height > BOARD_ROWS) {
      return false;
    }
    
    if (targetCol + piece.size.width > BOARD_COLS) {
      return false;
    }
    
    // 创建临时棋子用于碰撞检测
    const tempPos: Position = { row: targetRow, col: targetCol };
    const tempSize: Size = { width: piece.size.width, height: piece.size.height };
    const tempPiece: Piece = {
      id: piece.id,
      name: piece.name,
      type: piece.type,
      position: tempPos,
      size: tempSize,
      color: piece.color
    };
    
    // 检查是否与其他棋子碰撞
    for (const otherPiece of pieces) {
      // 跳过自己
      if (otherPiece.id === piece.id) {
        continue;
      }
      
      if (MoveValidator.checkCollision(tempPiece, otherPiece)) {
        return false;
      }
    }
    
    return true;
  }
  
  // 获取棋子可移动的方向列表
  static getValidDirections(piece: Piece, pieces: Piece[]): Direction[] {
    const validDirections: Direction[] = [];
    
    if (MoveValidator.validateMove(piece, Direction.UP, pieces)) {
      validDirections.push(Direction.UP);
    }
    if (MoveValidator.validateMove(piece, Direction.DOWN, pieces)) {
      validDirections.push(Direction.DOWN);
    }
    if (MoveValidator.validateMove(piece, Direction.LEFT, pieces)) {
      validDirections.push(Direction.LEFT);
    }
    if (MoveValidator.validateMove(piece, Direction.RIGHT, pieces)) {
      validDirections.push(Direction.RIGHT);
    }
    
    return validDirections;
  }
}
