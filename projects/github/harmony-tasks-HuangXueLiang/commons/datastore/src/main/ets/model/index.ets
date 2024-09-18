export interface UserInfo {
  userName: string
  age: number
  avatar: string
}

export class UserInfoModel implements UserInfo {
  userName: string = ''
  age: number = 0
  avatar: string = ''

  constructor(model: UserInfo) {
    this.userName = model.userName
    this.age = model.age
    this.avatar = model.avatar
  }
}
