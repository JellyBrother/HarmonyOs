import { it } from '@ohos/hypium'
//自定义组件
import {Header} from '../../Component/CommonCOmponent'

//全局公共样式   组件内使用去掉function即可
@Styles function  fillScreen(){
  .width('100%')
  .height('100%')
  .backgroundColor('#EFEFEF')
  .padding(20)

}

//继承模式  只能全局模式
@Extend(Text) function  priceText(){
  .fontColor('#F36')
  .fontSize(18)

}




//全局自定义组件函数 可以直接调用   一个页面有多个 Component
// @Builder function  ItemCard(item: Item){
//
//   Row({space:10}){
//     Image(item.image)
//       .width(100)
//     Column({space:4}){
//       if(item.discount){
//         Text(item.name)
//           .fontSize(20)
//           .fontWeight(FontWeight.Bold)
//         Text('💰原价' + item.price)
//           .fontColor('#CCC')
//           .fontSize(14)
//           .decoration({type : TextDecorationType.LineThrough})
//
//         Text('💰折扣价' + (item.price-item.discount))
//           .fontColor('#F36')
//           .fontSize(18)
//         Text('💰折补贴' + item.discount)
//           .fontColor('#F36')
//           .fontSize(18)
//
//       }else {
//         Text(item.name)
//           .fontSize(20)
//           .fontWeight(FontWeight.Bold)
//         Text('💰' + item.price)
//           .fontColor('#F36')
//           .fontSize(18)
//       }
//
//     }
//     .alignItems(HorizontalAlign.Start)
//   }
//   .width('100%')
//   .backgroundColor('#FFF')
//   .borderRadius(20)
//   .height(120)
//   .padding(10)
// }



class Item{
  name:string
  image:ResourceStr
  price:number
  discount:number

  constructor(name:string,image:ResourceStr,price:number,discount:number = 0) {
    this.name = name
    this.image = image
    this.price = price
    this.discount = discount
  }
}




@Entry
@Component
struct Shoplist {

  private  items :Array<Item> = [
    new Item('华为Mate60',$r('app.media.startIcon'),69999,500),
    new Item('华为Mate70',$r('app.media.app_icon'),79999,888),
    new Item('华为Mate80',$r('app.media.startIcon'),89999),
    new Item('华为Mate90',$r('app.media.startIcon'),99999,1278),
    new Item('华为Mate100',$r('app.media.startIcon'),59999),
    new Item('华为Mate110',$r('app.media.startIcon'),59999),
    new Item('华为Mate120',$r('app.media.startIcon'),59999),
    new Item('华为Mate60',$r('app.media.startIcon'),69999,500),
    new Item('华为Mate70',$r('app.media.app_icon'),79999,888),
    new Item('华为Mate80',$r('app.media.startIcon'),89999),
    new Item('华为Mate90',$r('app.media.startIcon'),99999,1278),
    new Item('华为Mate100',$r('app.media.startIcon'),59999),
    new Item('华为Mate110',$r('app.media.startIcon'),59999),
    new Item('华为Mate120',$r('app.media.startIcon'),59999),
  ];

  build() {

    Column({space:8}) {

      Header({title:'商品列表'})
        .margin(20)
      List({space:8}){

        ForEach(
          this.items,
          (item:Item) => {
            ListItem(){
              this.ItemCard(item)
            }
          }
        )


      }
      .width('100%')
      .height('100%')
      .layoutWeight(1)

    }
    .fillScreen()
  }


  //局部组件   调用this.调用
  @Builder  ItemCard(item: Item){

  Row({space:10}){
    Image(item.image)
      .width(100)
    Column({space:4}){
      if(item.discount){
        Text(item.name)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        Text('💰原价' + item.price)
          .fontColor('#CCC')
          .fontSize(14)
          .decoration({type : TextDecorationType.LineThrough})

        Text('💰折扣价' + (item.price-item.discount))
          .priceText()
        Text('💰折补贴' + item.discount)
          .priceText()

      }else {
        Text(item.name)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        Text('💰' + item.price)
          .priceText()
      }

    }
    .alignItems(HorizontalAlign.Start)
  }
  .width('100%')
  .backgroundColor('#FFF')
  .borderRadius(20)
  .height(120)
  .padding(10)
}


}