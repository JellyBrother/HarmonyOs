@Entry
@Component
struct ImagePage {
  @State imageWidth: number = 200

  build(){
    Column(){
      Row() {
        Image($r('app.media.icon'))
          .width(this.imageWidth)
          .interpolation(ImageInterpolation.High)
      }
      .width('100%')
      .height(400)
      .justifyContent(FlexAlign.Center)

      Row(){
        Text($r('app.string.image_width_label'))
          .fontSize(25)
          .fontWeight(FontWeight.Bolder)
          .fontColor('#36D')

        TextInput({placeholder: '请输入图片宽度', text: this.imageWidth.toFixed(0)})
          .width(200)
          .backgroundColor("#FFF")
          .type(InputType.Number)
          .onChange((value:string) => {
            this.imageWidth = parseInt(value)
          })
      }
      .width('800%')
      .justifyContent(FlexAlign.Center)

      Divider()
        .width('90%')

      Row(){
        Button("缩小图片")
          .width(100)
          .fontSize(16)
          .onClick(() => {
            if (this.imageWidth >= 50) {
              this.imageWidth -= 10
            }
          })

        Button("放大图片")
          .width(100)
          .fontSize(16)
          .onClick(() => {
            if (this.imageWidth < 320) {
              this.imageWidth += 10
            }
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ top: 40, bottom: 40})


      Slider({
        min: 50,
        max: 320,
        value: this.imageWidth,
        step: 5,
        style: SliderStyle.InSet,
        direction: Axis.Horizontal
      })
        .width('80%')
        .trackThickness(20)
        .showTips(true)
        .onChange(value => {
          this.imageWidth = value
        })
    }
    .width('100%')
    .height('100%')
  }
}