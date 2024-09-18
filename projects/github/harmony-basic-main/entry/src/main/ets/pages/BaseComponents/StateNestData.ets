@Entry
@Component
struct StateNestData {
  @State p: IPersonModel = new IPersonModel({
    name: '小张',
    age: 18,
    sex: '女',
    address: {
      province: '广东省',
      city: '广州市',
      area: '天河区',
    }
  })

  build() {
    Column({ space: 16 }) {
      Row({ space: 20 }) {
        Text('姓名:')
        TextInput({ text: this.p.name })
          .height(40)
          .layoutWeight(1)
      }
      Row({ space: 20 }) {
        Text('年龄:')
        TextInput({ text: this.p.age + '' })
          .height(40)
          .layoutWeight(1)
      }
      Row({ space: 20 }) {
        Text('性别:')
        Select([{ value: '男' }, { value: '女' }])
          .value(this.p.sex)
          .height(40)
          .border({
            width: 2,
            color: '#ccc',
          })
          .layoutWeight(1)
      }
      Row({ space: 20 }) {
        Text('性别:')
        Row({ space: 10 }) {
          TextInput({ text: this.p.address.province })
            .height(40)
            .layoutWeight(1)
          TextInput({ text: this.p.address.city })
            .height(40)
            .layoutWeight(1)
          TextInput({ text: this.p.address.area })
            .height(40)
            .layoutWeight(1)
        }
        .layoutWeight(1)
      }

      // 修改按钮
      Row({ space: 20 }) {
        Button('修改一第层数据')
          .onClick(() => {
            // 修改一第层数据，视图自动更新
            this.p.name += '1'
            this.p.age++
            this.p.sex = this.p.sex === '男' ? '女' : '男'
          })
        Button('修改二第层数据')
          .onClick(() => {
            // 修改二第层数据

            /** 方式1【不推荐】：直接更新第二层数据，数据已经更新，但视图不更新 */
            // this.p.address.area = '海珠区'

            /** 方式2【不推荐】：全量更新第一层数据，因为next版本不支持...语法，所以不变用更新的字段也需要书写 */
            // this.p.address = new IAddressModel({
            //   province: this.p.address.province,
            //   city: this.p.address.city,
            //   area: '海珠区'
            // })

            /** 方式3【推荐】：全量更新第一层数据，只修改变更的数据 */
            let area = this.p.address.area === '天河区' ? '海珠区' : '天河区'
            this.p.address.area = area
            this.p.address = new IAddressModel(this.p.address)
          })
      }
    }
    .width('100%')
    .height('100%')
    .padding({
      top: 30,
      right: 20,
      bottom: 30,
      left: 20,
    })
  }
}

/**
 * 根据 interface 生成 class
 *
 * $ npm i -g interface2class # 全局安装
 * $ i2c -V # 查版本
 * $ i2c ./StateNestData.ets # 生成 class
 * */

interface IAddress {
  province: string
  city: string
  area: string
}

interface IPerson {
  name: string
  age: number
  sex: '男' | '女'
  address: IAddress
}

export class IAddressModel implements IAddress {
  province: string = ''
  city: string = ''
  area: string = ''

  constructor(model: IAddress) {
    this.province = model.province
    this.city = model.city
    this.area = model.area
  }
}

export class IPersonModel implements IPerson {
  name: string = ''
  age: number = 0
  sex: '男' | '女' = '男'
  address: IAddress = new IAddressModel({} as IAddress)

  constructor(model: IPerson) {
    this.name = model.name
    this.age = model.age
    this.sex = model.sex
    this.address = model.address
  }
}
