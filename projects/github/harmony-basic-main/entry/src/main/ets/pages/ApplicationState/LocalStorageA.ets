import { AddressLocal, UserInfoLocal, userLocal } from './storage/userLocalStorage'
import { router } from '@kit.ArkUI'

@Entry(userLocal)
@Component
struct LocalStorageA {
  @LocalStorageProp('user')
  user: UserInfoLocal = new UserInfoLocal()
  @LocalStorageProp('address')
  address: AddressLocal = new AddressLocal()

  build() {
    Row() {
      Column({ space: 20 }) {
        Text(this.user.name)
        Button('修改')
          .onClick(() => {
            this.user.name += 1
          })
        Button('点击')
          .onClick(() => {
            router.pushUrl({
              url: 'pages/ApplicationState/LocalStorageB'
            })
          })
        Text(this.address.area)
      }
      .width('100%')
    }
    .height('100%')
  }
}