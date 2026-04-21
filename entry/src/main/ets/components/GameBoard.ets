// 棋盘组件

import { Piece } from '../models/Piece';
import { Direction, BOARD_COLS, BOARD_ROWS, CELL_SIZE } from '../constants/GameConstants';
import { PieceBlock } from './PieceBlock';

@Component
export struct GameBoard {
  // 棋子数组
  @Prop pieces: Piece[];
  // 选中的棋子ID
  @Prop selectedPieceId: string | null = null;
  // 点击回调
  onPieceClick?: (pieceId: string) => void;
  // 移动回调
  onPieceMove?: (pieceId: string, direction: Direction) => void;
  
  build() {
    Column() {
      Stack() {
        // 棋盘背景
        Column() {
          // 绘制网格线
          ForEach([0, 1, 2, 3, 4], (row: number) => {
            Row() {
              ForEach([0, 1, 2, 3], (col: number) => {
                Column()
                  .width(CELL_SIZE)
                  .height(CELL_SIZE)
                  .backgroundColor('#F5F5F5')
                  .border({ width: 1, color: '#E0E0E0' })
              }, (col: number) => col.toString())
            }
          }, (row: number) => row.toString())
        }
        .width(BOARD_COLS * CELL_SIZE)
        .height(BOARD_ROWS * CELL_SIZE)
        .backgroundColor('#FAFAFA')
        .border({ width: 2, color: '#BDBDBD', radius: 8 })
        
        // 出口标识
        Row() {
          Text('出口')
            .fontSize(14)
            .fontColor('#FF6B6B')
            .fontWeight(FontWeight.Bold)
        }
        .width(CELL_SIZE * 2)
        .height(30)
        .backgroundColor('#FFE5E5')
        .borderRadius(4)
        .justifyContent(FlexAlign.Center)
        .position({
          x: CELL_SIZE,
          y: BOARD_ROWS * CELL_SIZE + 5
        })
        
        // 渲染所有棋子
        ForEach(this.pieces, (piece: Piece, index: number) => {
          PieceBlock({
            piece: piece,
            isSelected: piece.id === this.selectedPieceId,
            cellSize: CELL_SIZE,
            onPieceClick: this.onPieceClick,
            onPieceMove: this.onPieceMove
          })
        }, (piece: Piece, index: number) => {
          // 使用id和位置作为key,确保位置变化时重新渲染
          return `${piece.id}_${piece.position.row}_${piece.position.col}`;
        })
      }
      .width(BOARD_COLS * CELL_SIZE)
      .height(BOARD_ROWS * CELL_SIZE + 40)
      
      // 方向控制按钮(仅当有选中棋子时显示)
      if (this.selectedPieceId !== null) {
        Row() {
          Button('↑')
            .width(50)
            .height(50)
            .fontSize(24)
            .onClick(() => {
              if (this.onPieceMove && this.selectedPieceId) {
                this.onPieceMove(this.selectedPieceId, Direction.UP);
              }
            })
          
          Column() {
            Row() {
              Button('←')
                .width(50)
                .height(50)
                .fontSize(24)
                .onClick(() => {
                  if (this.onPieceMove && this.selectedPieceId) {
                    this.onPieceMove(this.selectedPieceId, Direction.LEFT);
                  }
                })
              
              Button('→')
                .width(50)
                .height(50)
                .fontSize(24)
                .onClick(() => {
                  if (this.onPieceMove && this.selectedPieceId) {
                    this.onPieceMove(this.selectedPieceId, Direction.RIGHT);
                  }
                })
            }
            .justifyContent(FlexAlign.SpaceBetween)
            .width(120)
          }
          .margin({ left: 10, right: 10 })
          
          Button('↓')
            .width(50)
            .height(50)
            .fontSize(24)
            .onClick(() => {
              if (this.onPieceMove && this.selectedPieceId) {
                this.onPieceMove(this.selectedPieceId, Direction.DOWN);
              }
            })
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
        .margin({ top: 10 })
      }
    }
  }
}
