import { promptAction, router } from '@kit.ArkUI'
import { UserInfoAppModel } from './models'

@Entry
@Component
struct AppStorageLogin {
  @State
  userName: string = 'hxl'
  @State
  password: string = '123123'

  login() {
    if (this.userName === 'hxl' && this.password === '123123') {
      AppStorage.setOrCreate<UserInfoAppModel>('userInfo', new UserInfoAppModel({
        userName: 'hxl',
        age: 18,
        avatar: 'http://gips2.baidu.com/it/u=195724436,3554684702&fm=3028&app=3028&f=JPEG&fmt=auto?w=1280&h=960'
      }))
      router.pushUrl({
        url: 'pages/ApplicationState/AppStorageMain'
      })
    }
  }

  build() {
    Column({ space: 20 }) {
      TextInput({
        placeholder: '请输入用户名',
        text: $$this.userName,
      })
      TextInput({
        placeholder: '请输入密码',
        text: $$this.password,
      })
        .type(InputType.Password)
      Button('登录')
        .onClick(() => {
          this.login()
        })
        .width('100%')
    }
    .height('100%')
    .width('100%')
    .padding(20)
    .justifyContent(FlexAlign.Center)
  }
}