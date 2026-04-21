// 关卡选择器组件

import { Level } from '../models/Level';

@Component
export struct LevelSelector {
  // 关卡列表
  @Prop levels: Level[] = [];
  // 当前关卡ID
  @Prop currentLevelId: number = 1;
  // 是否显示
  @Prop visible: boolean = false;
  // 关卡选择回调
  onLevelSelect?: (levelId: number) => void;
  // 关闭回调
  onClose?: () => void;
  
  build() {
    if (this.visible) {
      // 遮罩层
      Stack() {
        // 半透明背景
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor('#80000000')
          .onClick(() => {
            if (this.onClose) {
              this.onClose();
            }
          })
        
        // 弹窗内容
        Column() {
          // 标题
          Text('选择关卡')
            .fontSize(20)
            .fontColor('#333333')
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 20 })
          
          // 关卡列表
          Column() {
            ForEach(this.levels, (level: Level) => {
              Row() {
                Text(level.name)
                  .fontSize(16)
                  .fontColor(level.id === this.currentLevelId ? '#FF6B6B' : '#333333')
                  .fontWeight(level.id === this.currentLevelId ? FontWeight.Bold : FontWeight.Normal)
                
                Blank()
                  .width(20)
                
                Text(level.difficulty)
                  .fontSize(14)
                  .fontColor('#999999')
              }
              .width('100%')
              .height(50)
              .padding({ left: 20, right: 20 })
              .backgroundColor(level.id === this.currentLevelId ? '#FFE5E5' : '#FFFFFF')
              .borderRadius(8)
              .margin({ bottom: 10 })
              .onClick(() => {
                if (this.onLevelSelect) {
                  this.onLevelSelect(level.id);
                }
              })
            }, (level: Level) => level.id.toString())
          }
          .width('80%')
        }
        .width('90%')
        .backgroundColor(Color.White)
        .borderRadius(12)
        .padding(20)
      }
      .width('100%')
      .height('100%')
    }
  }
}
