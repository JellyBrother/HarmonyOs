@Component
export default struct MyHeader {
  build() {
    Row() {
      Button() {
        Row() {
          Image('images/caseday02/1/map.svg')
            .width(12)
          Text('西安市')
            .fontSize(12)
            .fontColor('#333333')
        }
      }
      .padding(6)
      .backgroundColor(Color.White)

      Row() {
        Text('发现')
          .padding({
            top: 6,
            bottom: 6,
          })
          .borderWidth({
            bottom: 2
          })
          .borderColor('#936ef1')
          .fontSize(20)
          .fontColor('#333333')
        Text('附近')
          .margin({
            left: 20,
          })
          .padding({
            top: 6,
            bottom: 6,
          })
          .fontSize(18)
          .fontColor('#333333')
      }

      Image('images/caseday02/1/list.svg')
        .width(16)
        .fillColor('#333333')
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
  }
}
