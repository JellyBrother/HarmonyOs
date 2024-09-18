let nextId = 1;

@Observed export class Person {
  id: number;//编号
  name: string;//姓名
  phone: string;//手机号码
  isStar: boolean;//是否收藏

  constructor(name, phone) {
    this.id = nextId++;
    this.name = name;
    this.phone = phone;
    this.isStar = false;
  }
}