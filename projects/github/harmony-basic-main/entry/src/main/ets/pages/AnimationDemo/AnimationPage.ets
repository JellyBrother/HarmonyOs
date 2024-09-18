@Entry
@Component
struct AnimationPage {
  @State
  imageWidth: number = 50

  build() {
    Row() {
      Column({ space: 10 }) {
        Image($rawfile('image/mouse.jpeg'))
          .width(this.imageWidth)
          .aspectRatio(1)
          .borderRadius(10)
          .animation({
            duration: 2000,
            iterations: -1,
            playMode: PlayMode.Alternate,
          })

        Button('修改图片大小')
          .onClick(() => {
            this.imageWidth = 80
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}