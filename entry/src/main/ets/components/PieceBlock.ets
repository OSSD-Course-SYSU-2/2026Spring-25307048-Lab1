// 棋子组件

import { Piece } from '../models/Piece';
import { Direction, PieceColors } from '../constants/GameConstants';

@Component
export struct PieceBlock {
  // 棋子数据 - 使用@Prop确保响应式更新
  @Prop piece: Piece;
  // 是否选中
  @Prop isSelected: boolean = false;
  // 单元格尺寸
  @Prop cellSize: number = 80;
  // 点击回调
  onPieceClick?: (pieceId: string) => void;
  // 移动回调
  onPieceMove?: (pieceId: string, direction: Direction) => void;
  
  build() {
    Stack() {
      // 棋子主体
      Column() {
        Text(this.piece.name)
          .fontSize(this.piece.type === 'CAOCAO' ? 20 : 16)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
      }
      .width(this.piece.size.width * this.cellSize - 4)
      .height(this.piece.size.height * this.cellSize - 4)
      .backgroundColor(this.piece.color)
      .borderRadius(8)
      .justifyContent(FlexAlign.Center)
      .border({
        width: this.isSelected ? 3 : 1,
        color: this.isSelected ? PieceColors.SELECTED_BORDER : Color.White,
        radius: 8
      })
      .shadow({
        radius: this.isSelected ? 12 : 6,
        color: '#40000000',
        offsetX: 2,
        offsetY: 2
      })
    }
    // 使用计算属性确保位置更新
    .position({
      x: this.getPositionX(),
      y: this.getPositionY()
    })
    .onClick(() => {
      if (this.onPieceClick) {
        this.onPieceClick(this.piece.id);
      }
    })
    .gesture(
      PanGesture({ direction: PanDirection.All })
        .onActionEnd((event: GestureEvent) => {
          if (!this.onPieceMove) {
            return;
          }
          
          const offsetX = event.offsetX;
          const offsetY = event.offsetY;
          const threshold = 10; // 降低移动阈值,更容易触发
          
          // 判断移动方向
          if (Math.abs(offsetX) > Math.abs(offsetY)) {
            // 水平移动
            if (offsetX > threshold) {
              this.onPieceMove(this.piece.id, Direction.RIGHT);
            } else if (offsetX < -threshold) {
              this.onPieceMove(this.piece.id, Direction.LEFT);
            }
          } else {
            // 垂直移动
            if (offsetY > threshold) {
              this.onPieceMove(this.piece.id, Direction.DOWN);
            } else if (offsetY < -threshold) {
              this.onPieceMove(this.piece.id, Direction.UP);
            }
          }
        })
    )
  }
  
  // 计算X位置
  private getPositionX(): number {
    return this.piece.position.col * this.cellSize + 2;
  }
  
  // 计算Y位置
  private getPositionY(): number {
    return this.piece.position.row * this.cellSize + 2;
  }
}
