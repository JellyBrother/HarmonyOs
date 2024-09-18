import { router } from '@kit.ArkUI'
import { TokenManager } from './utils/token'

PersistentStorage.persistProp('token', '123')
PersistentStorage.persistProp('userInfo', {})

@Entry
@Component
struct PersistentStorageLogin {
  @StorageLink('token')
  token: string = '1'
  @StorageLink('userInfo')
  userInfo: UserInfo = new UserInfoModel({} as UserInfo)

  build() {
    Column({ space: 20 }) {
      Text(this.token)
      Text(JSON.stringify(this.userInfo) + ' - ' + this.userInfo.name)
      Button('登录')
        .width('100%')
        .onClick(() => {
          this.token = new Date().valueOf().toString()
          TokenManager.setToken(this.token)
          this.userInfo = new UserInfoModel({
            name: 'hxl',
            age: 18,
          })
          router.pushUrl({
            url: 'pages/ApplicationState/PersistentStorageMain'
          })
        })
    }
    .height('100%')
    .width('100%')
    .padding(20)
    .justifyContent(FlexAlign.Center)
  }
}

export interface UserInfo {
  name: string
  age: number
}

export class UserInfoModel implements UserInfo {
  name: string = ''
  age: number = 0

  constructor(model: UserInfo) {
    this.name = model.name
    this.age = model.age
  }
}
