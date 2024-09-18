import { promptAction } from '@kit.ArkUI'

@Entry
@Component
struct EventBinding {
  @State userName: string = ''
  @State password: string = ''

  login() {
    // AlertDialog.show({ message: '登录成功' })
    if(this.userName.trim() === 'admin' && this.password === '123456') {
      promptAction.showToast({ message: '登录成功' })
      return
    }
    promptAction.showToast({ message: '用户名或密码错误' })
  }

  getLoginBtnEnabled() {
    return !!this.userName.trim() && !!this.password
  }

  build() {
    Row() {
      Column({ space: 12 }) {
        TextInput({
          placeholder: '请输入用户名',
          text: $$this.userName
        })
          .height(40)
          .onChange((value) => console.log(value))
        TextInput({
          placeholder: '请输入密码',
          text: $$this.password
        })
          .height(40)
          .type(InputType.Password)
          .onSubmit(() => this.login())
        Button('登录')
          .width('100%')
          .enabled(this.getLoginBtnEnabled())
          .onClick(() => this.login())
      }
      .width('100%')
      .padding(20)
    }
    .height('100%')
  }
}