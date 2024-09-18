@Observed
class UserModel {
  user_id: number
  email: string
  password: string

  constructor(user_id: number, email: string, password: string) {
    this.user_id = user_id
    this.email = email
    this.password = password
  }
}

export default UserModel