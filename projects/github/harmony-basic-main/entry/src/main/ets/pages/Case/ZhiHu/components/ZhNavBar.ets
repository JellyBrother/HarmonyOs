@Component
struct ZhNavBar {
  title: string = '标题'

  build() {
    Row() {
      Row() {
        Image($r('app.media.ic_public_left_arrow'))
          .width(16)
      }
      .width(30)
      .padding({ left: 5 })
      .aspectRatio(1)
      .backgroundColor('#f4f4f4')
      .borderRadius(15)

      Text(this.title)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
        .margin({ right: 50 })
        .fontSize(18)
    }
    .padding({ left: 20 })
    .height(50)
    .border({
      width: { bottom: 1 },
      color: '#f8f8f8'
    })
  }
}

export {
  ZhNavBar
}