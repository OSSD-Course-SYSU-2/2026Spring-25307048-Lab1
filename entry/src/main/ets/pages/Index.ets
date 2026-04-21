// 华容道游戏主页面

import { Piece } from '../models/Piece';
import { Level } from '../models/Level';
import { Direction, GameText, AnimationDuration } from '../constants/GameConstants';
import { GameStateManager } from '../managers/GameStateManager';
import { LevelManager } from '../managers/LevelManager';
import { GameHeader } from '../components/GameHeader';
import { GameBoard } from '../components/GameBoard';
import { GameFooter } from '../components/GameFooter';
import { LevelSelector } from '../components/LevelSelector';

@Entry
@Component
struct Index {
  // 游戏状态管理器
  private gameManager: GameStateManager = new GameStateManager();
  
  // 响应式状态
  @State pieces: Piece[] = [];
  @State selectedPieceId: string | null = null;
  @State moveCount: number = 0;
  @State currentLevelId: number = 1;
  @State levelName: string = '';
  @State isWin: boolean = false;
  @State showLevelSelector: boolean = false;
  @State levels: Level[] = [];
  
  // 生命周期:页面即将显示
  aboutToAppear() {
    // 初始化关卡列表
    this.levels = LevelManager.getAllLevels();
    
    // 初始化游戏
    this.initGame(1);
  }
  
  // 初始化游戏
  private initGame(levelId: number) {
    this.gameManager.initGame(levelId);
    this.updateState();
  }
  
  // 更新UI状态
  private updateState() {
    const state = this.gameManager.getBoardState();
    // 创建新数组以触发UI更新
    const newPieces: Piece[] = [];
    for (let i = 0; i < state.pieces.length; i++) {
      newPieces.push(state.pieces[i]);
    }
    this.pieces = newPieces;
    this.selectedPieceId = state.selectedPieceId;
    this.moveCount = state.moveCount;
    this.currentLevelId = state.currentLevelId;
    this.isWin = state.isWin;
    this.levelName = this.gameManager.getCurrentLevelName();
  }
  
  // 处理棋子点击
  private handlePieceClick(pieceId: string) {
    if (this.selectedPieceId === pieceId) {
      // 取消选择
      this.gameManager.deselectPiece();
    } else {
      // 选择棋子
      this.gameManager.selectPiece(pieceId);
    }
    this.updateState();
  }
  
  // 处理棋子移动
  private handlePieceMove(pieceId: string, direction: Direction) {
    // 先选中棋子
    this.gameManager.selectPiece(pieceId);
    
    // 执行移动
    const success = this.gameManager.movePiece(pieceId, direction);
    if (success) {
      this.updateState();
      
      // 检查胜利
      if (this.isWin) {
        // 延迟显示胜利提示
        setTimeout(() => {
          this.showWinDialog();
        }, 300);
      }
    } else {
      // 移动失败也要更新状态(选中状态)
      this.updateState();
    }
  }
  
  // 处理重置
  private handleReset() {
    this.gameManager.resetGame();
    this.updateState();
  }
  
  // 显示关卡选择器
  private handleShowLevelSelector() {
    this.showLevelSelector = true;
  }
  
  // 关闭关卡选择器
  private handleCloseLevelSelector() {
    this.showLevelSelector = false;
  }
  
  // 处理关卡选择
  private handleLevelSelect(levelId: number) {
    this.showLevelSelector = false;
    this.initGame(levelId);
  }
  
  // 显示胜利对话框
  private showWinDialog() {
    AlertDialog.show({
      title: GameText.WIN_MESSAGE,
      message: `恭喜完成关卡: ${this.levelName}\n总共移动: ${this.moveCount} 步`,
      autoCancel: true,
      alignment: DialogAlignment.Center,
      primaryButton: {
        value: '确定',
        action: () => {
          // 可以选择重置或切换关卡
        }
      }
    });
  }
  
  build() {
    Column() {
      // 标题区域
      GameHeader({
        levelName: this.levelName,
        moveCount: this.moveCount
      })
      
      // 棋盘区域
      GameBoard({
        pieces: this.pieces,
        selectedPieceId: this.selectedPieceId,
        onPieceClick: (pieceId: string) => {
          this.handlePieceClick(pieceId);
        },
        onPieceMove: (pieceId: string, direction: Direction) => {
          this.handlePieceMove(pieceId, direction);
        }
      })
      
      // 按钮区域
      GameFooter({
        onReset: () => {
          this.handleReset();
        },
        onSelectLevel: () => {
          this.handleShowLevelSelector();
        }
      })
      
      // 关卡选择器
      LevelSelector({
        levels: this.levels,
        currentLevelId: this.currentLevelId,
        visible: this.showLevelSelector,
        onLevelSelect: (levelId: number) => {
          this.handleLevelSelect(levelId);
        },
        onClose: () => {
          this.handleCloseLevelSelector();
        }
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F0F0')
  }
}
