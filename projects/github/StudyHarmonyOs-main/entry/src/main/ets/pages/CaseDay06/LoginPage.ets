import { promptAction, router } from '@kit.ArkUI'

@Entry
@Component
struct LoginPage {
  title: string = '神领快递'
  @State username: string = ''
  @State password: string = ''

  toPage() {
    router.pushUrl({
      url: 'pages/CaseDay06/HomePage'
    })
  }
  checkForm(): boolean {
    if (!this.username || this.username !== 'admin') {
      promptAction.showToast({ message: '请填写正确的账号' })
      return false
    }
    if (!this.password || this.password !== '123456') {
      promptAction.showToast({ message: '请填写正确的验证码' })
      return false
    }
    return true
  }
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
          TextInput({ text: $$this.username, placeholder: '请输入手机号' })
            .height(60)
            .borderRadius(0)
            .borderWidth({ bottom: 1 })
            .borderColor('#F4F4F4')
            .backgroundColor(Color.White)
          Row() {
            TextInput({ text: $$this.password, placeholder: '请输入验证码' })
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
            .backgroundColor('#EF4F3F')
            .onClick(() => {
              const isCheckForm = this.checkForm()
              if (!isCheckForm) return
              AppStorage.setOrCreate('token', this.password)
              this.toPage()
            })
        }
      }
    }
    .padding(20)
    .height('100%')
    .width('100%')
  }
}