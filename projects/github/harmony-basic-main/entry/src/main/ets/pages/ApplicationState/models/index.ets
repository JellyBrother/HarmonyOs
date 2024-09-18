export interface UserInfoApp {
  userName: string
  age: number
  avatar: string
}

export class UserInfoAppModel implements UserInfoApp {
  userName: string = ''
  age: number = 0
  avatar: string = ''

  constructor(model: UserInfoApp) {
    this.userName = model.userName
    this.age = model.age
    this.avatar = model.avatar
  }
}
