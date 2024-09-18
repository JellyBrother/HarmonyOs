@Entry
@Component
struct CaseDay01 {
  @State message: string = 'Hello World';
  title: string = '神领快递'
  build() {
    Column() {
      Row() {
        Text(this.title)
          .height(60)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
      }

      Row() {
        Text('手机号登录')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
        Row({ space: 4 }) {
          Text('账号登录')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#EF4F40')
          Image('images/caseday01/2/triangle.svg')
            .width(12)
            .fillColor('#EF4F40')
        }
      }
      .margin({
        top: 30
      })
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
        Column(){
          TextInput({ placeholder: '请输入手机号' })
            .height(60)
            .borderRadius(0)
            .borderWidth({ bottom: 1 })
            .borderColor('#F4F4F4')
            .backgroundColor(Color.White)
          Row() {
            TextInput({ placeholder: '请输入验证码' })
              .height(60)
              .borderRadius(0)
              .backgroundColor(Color.White)
              .layoutWeight(1)
            Text('获取验证码')
              .margin({ right: 20 })
              .padding({ left: 20 })
              .borderWidth({ left: 1 })
              .borderColor('#F4F4F4')
          }
          .borderWidth({ bottom: 1 })
          .borderColor('#F4F4F4')
        }
      }
      .margin({
        top: 40,
        bottom: 40
      })

      Row() {
        Column() {
          Button('登录')
            .width('100%')
            .height(50)
            .fontColor(Color.White)
            .backgroundColor('#FADCD9')
        }
      }
    }
    .padding(20)
    .height('100%')
    .width('100%')
  }
}