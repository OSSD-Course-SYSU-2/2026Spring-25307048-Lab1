// 游戏标题组件

import { GameText } from '../constants/GameConstants';

@Component
export struct GameHeader {
  // 关卡名称
  @Prop levelName: string = '';
  // 移动步数
  @Prop moveCount: number = 0;
  
  build() {
    Column() {
      // 游戏标题
      Text(GameText.TITLE)
        .fontSize(28)
        .fontColor('#333333')
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 10 })
      
      // 关卡和步数信息
      Row() {
        Text(`关卡: ${this.levelName}`)
          .fontSize(16)
          .fontColor('#666666')
        
        Blank()
          .width(20)
        
        Text(`步数: ${this.moveCount}`)
          .fontSize(16)
          .fontColor('#666666')
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding({ top: 20, bottom: 15 })
  }
}
