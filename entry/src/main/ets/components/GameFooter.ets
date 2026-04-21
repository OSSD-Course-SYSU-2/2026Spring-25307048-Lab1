// 游戏按钮组件

import { GameText } from '../constants/GameConstants';

@Component
export struct GameFooter {
  // 重置回调
  onReset?: () => void;
  // 选关回调
  onSelectLevel?: () => void;
  
  build() {
    Row() {
      // 重置按钮
      Button(GameText.RESET)
        .fontSize(16)
        .fontColor(Color.White)
        .backgroundColor('#4ECDC4')
        .borderRadius(8)
        .width(100)
        .height(40)
        .onClick(() => {
          if (this.onReset) {
            this.onReset();
          }
        })
      
      Blank()
        .width(30)
      
      // 选关按钮
      Button(GameText.SELECT_LEVEL)
        .fontSize(16)
        .fontColor(Color.White)
        .backgroundColor('#95E1D3')
        .borderRadius(8)
        .width(100)
        .height(40)
        .onClick(() => {
          if (this.onSelectLevel) {
            this.onSelectLevel();
          }
        })
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .padding({ top: 15, bottom: 20 })
  }
}
