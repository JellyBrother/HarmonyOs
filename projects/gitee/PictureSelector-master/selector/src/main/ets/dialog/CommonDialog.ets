import { SIZE_MATCH } from '../constants/Constants'
import { CommonDialogData } from '../model/CommonDialogData'
/**
 * 自定义弹窗
 * @Author sea
 * @Date 2024/7/8
 */
@CustomDialog
export struct CommonDialog {
  // 弹窗数据
  @Prop commonDialogData: CommonDialogData
  // 弹窗控制器
  controller?: CustomDialogController
  // 取消点击事件
  cancel: () => void = () => {
  }
  // 确认点击事件
  confirm: () => void = () => {
  }

  build() {
    Column() {
      Text(this.commonDialogData.title)
        .fontSize(17)
        .width(SIZE_MATCH)
        .textAlign(TextAlign.Center)
        .fontColor($r('app.color.212121'))
        .margin({ bottom: 12 })
      Text(this.commonDialogData.content)
        .fontSize(14)
        .width(SIZE_MATCH)
        .textAlign(TextAlign.Center)
        .fontColor($r('app.color.212121'))
      Divider()
        .strokeWidth(0.5)
        .color($r('app.color.e8e8e8'))
        .margin({top:24})
      Row() {
        Text(this.commonDialogData.cancelText)
          .onClick(() => {
            if (this.controller != undefined) {
              this.controller.close()
            }
            this.cancel()
          })
          .fontColor($r('app.color.414141'))
          .fontSize(15)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Divider()
          .vertical(true)
          .strokeWidth(0.5)
          .height(SIZE_MATCH)
          .color($r('app.color.e8e8e8'))
        Text(this.commonDialogData.confirmText)
          .onClick(() => {
            if (this.controller != undefined) {
              this.controller.close()
            }
            this.confirm()
          })
          .fontColor($r('app.color.ff4d00'))
          .fontSize(15)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }.justifyContent(FlexAlign.SpaceBetween)
      .width(SIZE_MATCH)
      .height(54)
      .alignItems(VerticalAlign.Center)
    }.padding({ top: 24 })
  }
}