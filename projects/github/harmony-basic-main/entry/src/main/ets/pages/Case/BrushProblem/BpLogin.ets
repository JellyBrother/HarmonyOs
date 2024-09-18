import { promptAction, router } from '@kit.ArkUI'

@Entry
@Component
struct BpLogin {
  @State phone: string = ''
  @State code: string = ''
  @State agree: boolean = false

  getLoginBtnEnabled() {
    return !!(this.phone && this.code && this.agree)
  }

  goLogin() {
    if (this.phone === '13812341234' && this.code === '123123') {
      router.pushUrl({
        url: 'pages/Case/BrushProblem/BpMain',
      })
    } else {
      promptAction.showToast({
        message: '手机号或验证码错误',
      })
    }
  }

  build() {
    Column() {
      Column({ space: 24 }) {
        Image($r('app.media.ic_public_pb_login_logo'))
          .width(90)
          .aspectRatio(1)
        Text('欢迎使用鸿盟刷题')
        TextInput({
          text: $$this.phone,
          placeholder: '请输入手机号',
        })
          .height(48)

        TextInput({
          text: $$this.code,
          placeholder: '请输入验证码',
        })
          .height(48)
        Button('登录')
          .width('100%')
          .height(48)
          .enabled(this.getLoginBtnEnabled())
          .onClick(() => {
            this.goLogin()
          })
      }
      .layoutWeight(1)
      .margin({
        top: 138,
      })

      Row() {
        Checkbox()
          .select($$this.agree)
          .width(12)
          .aspectRatio(1)
        Text('登录即同意《用户使用协议》和《隐私政策》')
          .fontSize(12)
          .fontColor('#979797')
      }
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({
      right: 40,
      left: 40,
      bottom: 20,
    })

  }
}