@Entry
@Component
struct ZHCase {
  build() {
    Column() {
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

        Text('评论回复')
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

      Row({ space: 16 }) {
        Image($rawfile('image/mouse.jpeg'))
          .width(50)
          .aspectRatio(1)
          .borderRadius(25)

        Column({ space: 12 }) {
          Text('周天王')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          Text('要打开收到了砍，大煞风景的反抗精神，收到了房间，算了房间爱上的房间，收到放辣椒，舒服舒服的风。')
            .lineHeight(22)
            .maxLines(2)
            .width('100%')
            .textOverflow({ overflow: TextOverflow.Ellipsis })
          Row() {
            Text('10-21.IP属性广州')
              .fontColor('#ccc')
            Row({ space: 5 }) {
              Image($r('app.media.ic_public_like'))
                .width(12)
                .fillColor('#ccc')
              Text('100')
                .fontColor('#ccc')
            }
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
      }
      .padding(20)
      .alignItems(VerticalAlign.Top)
    }
  }
}