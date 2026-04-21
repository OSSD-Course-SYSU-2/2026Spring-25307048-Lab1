// 游戏状态管理器

import { Piece, Position, Size } from '../models/Piece';
import { BoardState } from '../models/BoardState';
import { Direction } from '../constants/GameConstants';
import { LevelManager } from './LevelManager';
import { MoveValidator } from './MoveValidator';
import { WinChecker } from './WinChecker';

// 游戏状态管理器类
export class GameStateManager {
  // 游戏状态
  private pieces: Piece[] = [];
  private selectedPieceId: string | null = null;
  private moveCount: number = 0;
  private currentLevelId: number = 1;
  private isWin: boolean = false;
  
  // 初始化游戏
  initGame(levelId: number): void {
    const level = LevelManager.getLevel(levelId);
    if (!level) {
      console.error(`Level ${levelId} not found`);
      return;
    }
    
    this.currentLevelId = levelId;
    this.moveCount = 0;
    this.selectedPieceId = null;
    this.isWin = false;
    
    // 深拷贝棋子数组
    this.pieces = level.pieces.map(piece => {
      const pos: Position = { row: piece.position.row, col: piece.position.col };
      const sz: Size = { width: piece.size.width, height: piece.size.height };
      const newPiece: Piece = {
        id: piece.id,
        name: piece.name,
        type: piece.type,
        position: pos,
        size: sz,
        color: piece.color
      };
      return newPiece;
    });
  }
  
  // 获取当前游戏状态
  getBoardState(): BoardState {
    return {
      pieces: this.pieces,
      selectedPieceId: this.selectedPieceId,
      moveCount: this.moveCount,
      currentLevelId: this.currentLevelId,
      isWin: this.isWin
    };
  }
  
  // 选择棋子
  selectPiece(pieceId: string): void {
    const piece = this.pieces.find(p => p.id === pieceId);
    if (piece) {
      this.selectedPieceId = pieceId;
    }
  }
  
  // 取消选择
  deselectPiece(): void {
    this.selectedPieceId = null;
  }
  
  // 移动棋子
  movePiece(pieceId: string, direction: Direction): boolean {
    const pieceIndex = this.pieces.findIndex(p => p.id === pieceId);
    if (pieceIndex === -1) {
      return false;
    }
    
    const piece = this.pieces[pieceIndex];
    
    // 验证移动是否合法
    if (!MoveValidator.validateMove(piece, direction, this.pieces)) {
      return false;
    }
    
    // 计算新位置
    let newRow = piece.position.row;
    let newCol = piece.position.col;
    
    switch (direction) {
      case Direction.UP:
        newRow -= 1;
        break;
      case Direction.DOWN:
        newRow += 1;
        break;
      case Direction.LEFT:
        newCol -= 1;
        break;
      case Direction.RIGHT:
        newCol += 1;
        break;
    }
    
    // 创建新的位置对象
    const newPosition: Position = { row: newRow, col: newCol };
    
    // 更新棋子(创建新对象)
    this.pieces[pieceIndex] = {
      id: piece.id,
      name: piece.name,
      type: piece.type,
      position: newPosition,
      size: piece.size,
      color: piece.color
    };
    
    // 增加步数
    this.moveCount++;
    
    // 检查胜利
    this.isWin = WinChecker.checkWin(this.pieces);
    
    return true;
  }
  
  // 重置游戏
  resetGame(): void {
    this.initGame(this.currentLevelId);
  }
  
  // 检查是否胜利
  checkWin(): boolean {
    return this.isWin;
  }
  
  // 获取当前关卡ID
  getCurrentLevelId(): number {
    return this.currentLevelId;
  }
  
  // 获取当前关卡名称
  getCurrentLevelName(): string {
    const level = LevelManager.getLevel(this.currentLevelId);
    return level ? level.name : '';
  }
  
  // 获取移动步数
  getMoveCount(): number {
    return this.moveCount;
  }
  
  // 获取选中的棋子ID
  getSelectedPieceId(): string | null {
    return this.selectedPieceId;
  }
  
  // 获取所有棋子
  getPieces(): Piece[] {
    return this.pieces;
  }
}
