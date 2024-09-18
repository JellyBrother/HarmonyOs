import { UserInfo, UserInfoModel } from './PersistentStorageLogin'
import { TokenManager } from './utils/token'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct PersistentStorageMain {
  @StorageLink('token')
  token: string = ''
  @StorageLink('userInfo')
  userInfo: UserInfo = new UserInfoModel({} as UserInfo)

  build() {
    Column({ space: 20 }) {
      Text('PersistentStorage Main')
      Text(this.token)
      Button('登出')
        .width('100%')
        .onClick(() => {
          this.token = ''
          TokenManager.setToken('')
          this.userInfo = new UserInfoModel({} as UserInfo)
          router.back()
        })
    }
    .height('100%')
    .width('100%')
    .padding(20)
    .justifyContent(FlexAlign.Center)
  }
}