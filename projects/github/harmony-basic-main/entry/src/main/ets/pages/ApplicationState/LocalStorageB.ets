import { UserInfoLocal, userLocal } from './storage/userLocalStorage'
import { router } from '@kit.ArkUI'

@Entry(userLocal)
@Component
struct LocalStorageB {
  @LocalStorageLink('user')
  user: UserInfoLocal = new UserInfoLocal()

  build() {
    Row() {
      Column({ space: 20 }) {
        Text(this.user.name)
        Button('修改')
          .onClick(() => {
            this.user.name += 2
          })
        Button('返回')
          .onClick(() => {
            router.back()
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}