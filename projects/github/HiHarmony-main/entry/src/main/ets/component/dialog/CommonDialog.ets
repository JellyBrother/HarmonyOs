import { faceDetector } from '@kit.CoreVisionKit';

@CustomDialog
export struct CommonDialog {
  cancel?: () => void
  confirm?: () => void
  controller: CustomDialogController

  build() {
    Column() {
      Text('请确认是否需要？')
        .fontSize(20)
        .margin({ top: 10, bottom: 10 })
      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('取消')
          .width(100)
          .onClick(() => {
            this.controller.close();
            if (this.cancel) {
              this.cancel();
            }
          })
          .backgroundColor(Color.White).fontColor(Color.Black)
        Button('确认')
          .width(100)
          .onClick(() => {
            this.controller.close();
            if (this.confirm) {
              this.confirm()
            }
          }).linearGradient({
          angle: -90,
          colors: [['#FFDD19', 0.5], ['#FFE74D', 1]]
        }).fontColor(Color.White)
      }.margin({ bottom: 10 })
    }

  }
}