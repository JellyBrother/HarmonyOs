import { Header } from "../components/Header"

interface IItem {
  name: string, image: string, price: number, discount: number
}

class Item {
  name: string;
  image: string;
  price: number;
  discount: number;

  constructor(name: string, image: string, price: number, discount: number) {
    this.name = name;
    this.image = image;
    this.price = price;
    this.discount = discount;
  }
}

// 全局函数
/*
@Builder function ItemCard (item: IItem) {
  Row() {
    Row({ space: 20}) {
      Column() {
        Image('https://assets.wangxiao.net/images/customer/customer.png').width(100).height(100)
      }.height(100).justifyContent(FlexAlign.Center)
      Column({space: 15}) {
        Text(item.name)
        Text(item.price.toFixed(0))
        if(item.discount) {
          Text(`折扣：${item.discount}`)
        } else {
          Text(`无折扣`)
        }

      }.justifyContent(FlexAlign.Center).width(200).alignItems(HorizontalAlign.Start)
    }.width('90%').backgroundColor('green').alignItems(VerticalAlign.Center).height(120).justifyContent(FlexAlign.Center)
  }.width('100%').justifyContent(FlexAlign.Center)
}
*/

// // 全局样式
// @Styles function CommonStyle() {
//   .width('100%').backgroundColor('#a34343')
// }

@Extend(Text) function CommonText() {
  .fontSize(40).fontColor('#679809')
}

class Person {
  public  name: string;
  public age: number;
  hobbies: Array<string>;

  constructor(name: string, age: number, hobbies: Array<string>) {
    this.name = name;
    this.age = age;
    this.hobbies = hobbies;
  }
}

@Component
struct Index {
  @State message: string = 'Hello World 1000';
  @State ImageWidth: number = 100;

  private items: Array<Item> = [
    new Item('华为mate60-1',  'https://assets.wangxiao.net/images/customer/customer.png', 100, 0),
    new Item('华为mate60-2',  'https://assets.wangxiao.net/images/customer/customer.png', 200, 0.3),
    new Item('华为mate60-3',  'https://assets.wangxiao.net/images/customer/customer.png', 300, 0.6),
    new Item('华为mate60-3',  'https://assets.wangxiao.net/images/customer/customer.png', 300, 0.6),
    new Item('华为mate60-3',  'https://assets.wangxiao.net/images/customer/customer.png', 300, 0.6),
    new Item('华为mate60-3',  'https://assets.wangxiao.net/images/customer/customer.png', 300, 0.6),
    new Item('华为mate60-3',  'https://assets.wangxiao.net/images/customer/customer.png', 300, 0.6),
    new Item('华为mate60-3',  'https://assets.wangxiao.net/images/customer/customer.png', 300, 0.6),
    new Item('华为mate60-3',  'https://assets.wangxiao.net/images/customer/customer.png', 300, 0.6),
  ];

  @State person: Person = new Person('Alan', 21, ['a', 'b', 'c']);


  // 全局样式
  @Styles CommonSomeStyle() {
    .width('100%').backgroundColor('#123456')
  }
  build() {
    Text(`${this.person.name}: ${this.person.age} - ${this.person.hobbies.join(',')}`).onClick(()=> {
      console.log('---111');
      // this.person.age++;
      const temp = this.person.hobbies;
      this.person.hobbies = [...temp, 'd'];
    })
    /*
    RelativeContainer() {
      Column({space: 20}) {
        Header({ title: '商品列表-212'})
        Text('测试extend').CommonText();
        List({space: 10}) {
          ForEach(this.items, (item: IItem) => {
            ListItem() {
              this.ItemCard2(item)
            }
          })
        }.listDirection(Axis.Vertical)
      }.justifyContent(FlexAlign.Center).width('100%')
    }.CommonSomeStyle()
    */


      // Column({space: 10}){
      //   Text('item1');
      //   Text('item2');
      //   Text('item3');
      //   Text('item4');
      //   Text('item5');
      // }.justifyContent(FlexAlign.Center).height('100%')
      // .alignItems(HorizontalAlign.Center).width('100%')
      // Row() {
      //   Column() {
      //     Image('https://assets.wangxiao.net/images/customer/customer.png').width(this.ImageWidth)
      //
      //     Button('放大').onClick(()=> {
      //       this.ImageWidth += 10;
      //     })
      //     Button('缩小').onClick(()=> {
      //       this.ImageWidth -=10;
      //     })
      //     Slider({
      //       min: 0,
      //       max: 100,
      //       value: 20,
      //       step: 10,
      //       style: SliderStyle.OutSet,
      //       direction: Axis.Horizontal,
      //       reverse: false,
      //
      //     }).showTips(true)
      //     // TextInput({
      //     //   placeholder: '请输入手机号',
      //     // }).onChange((val)=> {
      //     //   console.log('val---', val);
      //     //   this.ImageWidth = parseInt(val);
      //     // }).type(InputType.Number)
      //   }
      // }.height('100%')

        // Row(){
        //   Text(this.message)
        //     .id('hello1')
        //     .fontSize(50)
        //     .fontColor('red')
        //     .fontWeight(FontWeight.Bold)
        //     .alignRules({
        //       center: { anchor: '__container__', align: VerticalAlign.Center },
        //       middle: { anchor: '__container__', align: HorizontalAlign.Center }
        //     }).onClick(()=> {
        //     this.message = 'Yes I do'
        //   })
        // }
        // Row(){
        //   Button('click me').fontSize(24)
        // }.width('100%').justifyContent(FlexAlign.Center)
        // Row() {
        //   // Image('https://assets.wangxiao.net/images/customer/customer.png').width(100).height(100)
        //   Image($r("app.media.startIcon")).width(50)
        //     .interpolation(ImageInterpolation.High)
        //
        //   Text($r('app.string.image_width'))
        // }

    // }
    // .height('100%')
    // .width('100%').backgroundColor('#fff')
  }

  // 局部函数
  @Builder ItemCard2(item: IItem) {
    Row() {
      Row({ space: 20}) {
        Column() {
          Image('https://assets.wangxiao.net/images/customer/customer.png').width(100).height(100)
        }.height(100).justifyContent(FlexAlign.Center)
        Column({space: 15}) {
          Text(item.name)
          Text(item.price.toFixed(0))
          if(item.discount) {
            Text(`折扣：${item.discount}`)
          } else {
            Text(`无折扣`)
          }

        }.justifyContent(FlexAlign.Center).width(200).alignItems(HorizontalAlign.Start)
      }.width('90%').backgroundColor('green').alignItems(VerticalAlign.Center).height(120).justifyContent(FlexAlign.Center)
    }.width('100%').justifyContent(FlexAlign.Center)
  }
}