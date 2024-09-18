@Entry
@Component
struct TrackModifier {
  @State
  user: UserInfoModel = new UserInfoModel({
    id_card: 440,
    name: '大白',
    age: 18,
    sex: '男',
  })
  @State
  isShow: boolean = false

  @Builder
  popUI() {
    Column() {
      Row() {
        Text('user.id_card不能助于UI')
        Text('但可以用于ArkTs')
        // Text(this.user.id_card.toString()) // Error: Illegal usage of not @Track'ed property 'id_card' on UI!
      }
    }
  }

  build() {
    Row() {
      Column({ space: 20 }) {
        Row() {
          Text('身份证：')
          // Text(this.user.id_card.toString()) // Error: Illegal usage of not @Track'ed property 'id_card' on UI!
        }
        .bindSheet($$this.isShow, this.popUI, {
          height: '50%',
          maskColor: Color.Gray
        })
        .onClick(() => {
          this.user.id_card++
          console.log('x_log', this.user.id_card)
          this.isShow = true
        })

        Row() {
          Text('姓名：')
          Text(this.user.name)
        }
        .onClick(() => {
          this.user.name += '1'
        })

        Row() {
          Text('年龄：')
          // Text(this.user.age.toString())
        }
        .onClick(() => {
          // this.user.age += 1
        })

        Row() {
          Text('性别：')
          Text(this.user.sex)
        }
        .onClick(() => {
          this.user.sex = this.user.sex === '男' ? '女' : '男'
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}

interface UserInfo {
  id_card: number
  name: string
  age: number
  sex: '男' | '女'
}

export class UserInfoModel implements UserInfo {
  id_card: number = 0
  @Track
  name: string = ''
  age: number = 0
  @Track
  sex: '男' | '女' = '男'

  constructor(model: UserInfo) {
    this.id_card = model.id_card
    this.name = model.name
    this.age = model.age
    this.sex = model.sex
  }
}
