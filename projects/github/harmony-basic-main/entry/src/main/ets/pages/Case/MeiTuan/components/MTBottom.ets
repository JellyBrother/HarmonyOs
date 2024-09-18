import { FoodItem } from '../models'

@Component
struct MTBottom {
  @Consume
  showCart: boolean
  @Consume
  userCart: FoodItem[]

  getTotalCount() {
    return this.userCart.reduce((sum: number, item: FoodItem) => sum + item.count, 0)
  }

  getTotalPrice() {
    return this.userCart.reduce((sum: number, item: FoodItem) => sum + item.count * item.price, 0).toFixed(2)
  }

  build() {
    Row() {
      Row() {
        Badge({
          value: this.getTotalCount().toString(),
          position: BadgePosition.Right,
          style: { badgeSize: 22, badgeColor: '#FA2A2D' }
        }) {
          Image($r('app.media.ic_public_cart'))
            .width(50)
            .height(70)
            .position({
              y: -20,
              x: -4,
            })
        }
        .margin({
          left: 25,
          right: 10,
        })
        .onClick(() => {
          this.showCart = !this.showCart
        })

        Column() {
          Text() {
            Span('￥')
              .fontSize(12)
            Span(this.getTotalPrice().toString())
              .fontSize(24)
          }
          .fontWeight(FontWeight.Medium)
          .fontColor($r('app.color.white'))

          Text('预估另需配送费￥5')
            .fontColor($r('app.color.search_font_color'))
            .fontSize(12)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Button('去结算')
          .backgroundColor($r('app.color.main_color'))
          .fontColor($r('app.color.food_item_second_color'))
          .height(50)
          .width(80)
          .type(ButtonType.Normal)
          .borderRadius({
            topRight: 25,
            bottomRight: 25,
          })
      }
      .width('100%')
      .height(50)
      .backgroundColor($r('app.color.bottom_back'))
      .borderRadius(25)
    }
    .width('100%')
    .padding({
      right: 20,
      bottom: 20,
      left: 20,
    })
  }
}

export default MTBottom