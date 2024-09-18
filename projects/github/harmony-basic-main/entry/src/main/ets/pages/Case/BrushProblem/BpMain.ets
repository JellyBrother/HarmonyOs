import { promptAction } from '@kit.ArkUI'

@Entry
@Component
struct BpMain {
  @Provide userInfo: IUserInfo = ({} as IUserInfo)

  aboutToAppear(): void {
    this.getUserInfo()
  }

  async getUserInfo() {
    try {
      this.userInfo = await getUserInfo()
    } catch (error) {
      promptAction.showToast({
        message: '获取用户信息失败'
      })
    }
  }

  build() {
    Tabs() {
      TabContent() {
        BpHome()
      }.tabBar('首页')

      TabContent() {
        BpExercise()
      }.tabBar('练习')

      TabContent() {
        BpMy()
      }.tabBar('我的')
    }
    .barPosition(BarPosition.End)
  }
}

@Component
struct BpHome {
  @Consume userInfo: IUserInfo

  build() {
    Column() {
      Text(this.userInfo.nickName)
    }
  }
}

@Component
struct BpExercise {
  @Consume userInfo: IUserInfo

  build() {
    Column() {
      Text(this.userInfo.phone.toString())
    }
  }
}

@Component
struct BpMy {
  @Consume userInfo: IUserInfo

  build() {
    Column() {
      Image(this.userInfo.avatar)
        .width(150)
        .aspectRatio(1)
        .borderRadius(75)
    }
  }
}

function getUserInfo() {
  return new Promise<IUserInfo>((resolve) => {
    setTimeout(() => {
      resolve({
        id: 1,
        nickName: '九级浪',
        phone: 13812341234,
        avatar: $rawfile('image/mouse.jpeg')
      })
    }, 1000)
  })
}

interface IUserInfo {
  id: number
  nickName: string
  phone: number
  avatar: ResourceStr
}

export class IUserInfoModel implements IUserInfo {
  id: number = 0
  nickName: string = ''
  phone: number = 0
  avatar: ResourceStr = ''

  constructor(model: IUserInfo) {
    this.id = model.id
    this.nickName = model.nickName
    this.phone = model.phone
    this.avatar = model.avatar
  }
}
