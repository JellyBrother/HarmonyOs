import { router } from '@kit.ArkUI'

@Entry
@Component
struct CaseDay03 {
  @Styles LogoInputStyle() {
    .height(56)
    .backgroundColor(Color.White)
    .border({
      width: 1,
      color: '#adb3ba',
      radius: 10
    })
  }
  @Styles OtherIconStyle() {
    .width(56)
    .height(56)
    .backgroundColor('#e3e5e8')
    .borderRadius(10)
  }

  @State username: string = ''
  @State password: string = ''

  build() {
    Column() {
      Column({ space: 30 }) {
        Row() {
          Image('pages/CaseDay03/images/logo.svg')
            .width(25)
            .fillColor(Color.White)
        }
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#a7d640')
        .width(60)
        .height(60)
        .borderRadius(30)

        Text('闪充')
          .fontSize(24)
          .fontColor('#161A1D')
          .fontWeight(650)

        Text('行驶保驾护航，充电轻松安心')
          .fontSize(14)
          .fontColor('#606771')
      }
      .margin({
        // top: 20
      })

      Column({ space: 10 }) {
        TextInput({ text: $$this.username, placeholder: '请输入用户名' })
          .LogoInputStyle()
        if (this.username && this.username !== 'admin') {
          Text('用户名错误')
            .width('100%')
            .fontSize(12)
            .fontColor('#f56c6c')
            .textAlign(TextAlign.End)
        }
        TextInput({ text: $$this.password, placeholder: '请输入密码' })
          .type(InputType.NEW_PASSWORD)
          .LogoInputStyle()
        if (this.password && this.password !== '123456') {
          Text('密码错误')
            .width('100%')
            .fontSize(12)
            .fontColor('#f56c6c')
            .textAlign(TextAlign.End)
        }
        Row() {
          Text('忘记密码')
            .fontSize(14)
            .fontColor(Color.Black)
            .fontWeight(700)
        }
        .justifyContent(FlexAlign.End)
        .margin({
          top: 10,
          bottom: 10
        })
        .width('100%')
      }
      .margin({
        top: 60
      })

      Row() {
        Button('登录',
          {
            type: ButtonType.Normal,
            stateEffect: this.username === 'admin' && this.password === '123456'
          }
        ).opacity(this.username === 'admin' && this.password === '123456' ? 1 : 0.4)
          .fontSize(16)
          .fontWeight(650)
          .type(ButtonType.Normal)
          .width('100%')
          .height(48)
          .backgroundColor('#a7d640')
          .borderRadius(10)
          .onClick(() => {
            if (this.username === 'admin' && this.password === '123456') {
              router.pushUrl({
                url: 'pages/CaseDay03/Home'
              })
            }
          })
      }
      .margin({
        top: 10
      })

      Column() {
        Text('-第三方账号登录-')
          .fontSize(12)
          .fontColor('#939AA3')
      }
      .margin({
        top: 40
      })

      Row({ space: 20 }) {
        Row() {
          Image('/pages/CaseDay03/images/qq.svg')
            .width(25)
        }
        .justifyContent(FlexAlign.Center)
        .OtherIconStyle()

        Row() {
          Image('/pages/CaseDay03/images/wexin.svg')
            .width(25)
        }
        .justifyContent(FlexAlign.Center)
        .OtherIconStyle()

        Row() {
          Image('/pages/CaseDay03/images/weibo.svg')
            .width(25)
        }
        .justifyContent(FlexAlign.Center)
        .OtherIconStyle()
      }
      .margin({
        top: 20
      })

      Row() {
        Text('没有账户？')
          .fontSize(14)
          .fontColor('#606771')
        Text('注册')
          .fontColor(Color.Black)
          .fontWeight(650)
      }
      .margin({
        top: 70
      })
    }
    .padding(20)
    .height('100%')
    .width('100%')
  }
}