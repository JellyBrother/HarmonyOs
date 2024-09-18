@Entry
@Component
struct BaiDuCase {

  build() {
    Column({ space: 20 }) {
      Image('https://www.baidu.com/img/flexible/logo/plus_logo_web_2.png')
        .width(179)
        .height(57)
      Row() {
        TextInput()
          .height(40)
          .layoutWeight(1)
          .border({
            width: {
              top:2,
              bottom:2,
              left: 2
            },
            color: '#5272ea'
          })
          .borderRadius({
            topLeft: 8,
            bottomLeft: 8
          })
        Button('百度一下')
          .type(ButtonType.Normal)
          .fontWeight(FontWeight.Bold)
          .backgroundColor('#5272ea')
          .borderRadius({
            topRight: 8,
            bottomRight: 8,
          })
          .padding({
            top: 6,
            bottom: 6,
            left: 10,
            right: 10
          })
      }
      .padding({
        left: 20,
        right: 20
      })
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
  }
}