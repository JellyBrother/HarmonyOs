class UserInfoLocal {
  name: string = '张三'
  age: number = 18
}

class AddressLocal {
  province: string = '广东省'
  city: string = '广东省'
  area: string = '天河区'
}

let obj: Record<string, UserInfoLocal | AddressLocal> = {
  'user': new UserInfoLocal(),
  'address': new AddressLocal(),
}

const userLocal = new LocalStorage(obj)

export { UserInfoLocal, AddressLocal, userLocal }