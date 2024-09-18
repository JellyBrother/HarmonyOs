import { FoodItem } from '../models'
import { CartStore } from '../utils'
import MTCartItem from './MTCartItem'

@Component
struct MTCart {
  @Consume
  showCart: boolean
  @Consume
  userCart: FoodItem[]

  build() {
    Column() {
      Column() {
        Row() {
          Text('购物车')
            .fontWeight(FontWeight.Medium)
          Text('清空购物车')
            .fontColor($r('app.color.search_font_color'))
            .onClick(() => {
              CartStore.clearCart()
            })
        }
        .width('100%')
        .height(50)
        .justifyContent(FlexAlign.SpaceBetween)

        List({ space: 25 }) {
          ForEach(this.userCart, (item: FoodItem) => {
            ListItem() {
              MTCartItem({ item })
            }
          }, (item: FoodItem) => item.id.toString())
        }
        .height(this.userCart.length > 4 ? '60%' : 'auto')
      }
      .padding({
        left: 12,
        right: 12,
        bottom: 90,
      })
      .backgroundColor(Color.White)
      .borderRadius({
        topLeft: 10,
        topRight: 10,
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('rgba(0, 0, 0, 0.7)')
    .justifyContent(FlexAlign.End)
  }
}

export default MTCart