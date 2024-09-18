@Entry
@Component
struct AnimateToPage {
  @State
  imageWidth: number = 50

  build() {
    Row() {
      Column({ space: 10 }) {
        Image($r('app.media.ic_public_pb_login_logo'))
          .width(this.imageWidth)
          .aspectRatio(1)
          .borderRadius(10)

        Button('修改图片大小')
          .onClick(() => {
            animateTo({
              duration: 2000,
              iterations: -1,
              playMode: PlayMode.Alternate
            }, () => {
              this.imageWidth = 80
            })
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}