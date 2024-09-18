import { UserInfoApp, UserInfoAppModel } from './models'

@Entry
@Component
struct AppStorageMain {
  @StorageLink('userInfo')
  user: UserInfoAppModel = new UserInfoAppModel({} as UserInfoApp)

  build() {
    Column({ space: 20 }) {
      Image(this.user.avatar)
        .width(120)
        .aspectRatio(1)
        .borderRadius(60)
      Text(this.user.userName)
      Text(this.user.age.toString())
    }
    .height('100%')
    .width('100%')
    .padding(20)
  }
}