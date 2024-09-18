import { CommonConstants, MyBuilderFunction, ResManager } from '@sr/utils'

@Component
export struct SrTopNav {
  @State hasMsg: boolean = true
  @BuilderParam
  leftIconBuilder: () => void = MyBuilderFunction
  title: string = ''
  frontColor: Color | ResourceStr = ResManager.COLOR_DEFAULT

  build() {
    Row({ space: 20 }) {
      if (this.leftIconBuilder) {
        this.leftIconBuilder()
      }
      Text(this.title)
        .fontSize(ResManager.TOP_TAB_TEXT_SIZE)
        .fontColor(this.frontColor)
        .fontWeight(FontWeight.Medium)
      Blank()

      Stack({ alignContent: Alignment.TopEnd }) {
        Image($r('app.media.ic_message')).width(28).aspectRatio(1).fillColor(this.frontColor)
        Text()
          .width(6)
          .aspectRatio(1)
          .backgroundColor('#e34960')
          .borderRadius(3)
          .margin({ top: 3, right: 5 })
          .visibility(this.hasMsg ? Visibility.Visible : Visibility.None)
      }
      .onClick(() => {
        this.hasMsg = !this.hasMsg
      })


      Image($r('app.media.ic_rubbish'))
        .width(28).aspectRatio(1).fillColor(this.frontColor)
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(CommonConstants.TOP_BAR_HEIGHT)
  }
}