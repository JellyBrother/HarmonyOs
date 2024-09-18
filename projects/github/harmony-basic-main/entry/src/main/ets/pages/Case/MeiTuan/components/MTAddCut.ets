import { FoodItem } from '../models'
import { AddCutEnum, CartStore } from '../utils'

@Extend(Text)
function textStyle() {
  .width(20)
  .aspectRatio(1)
  .textAlign(TextAlign.Center)
  .border({
    width: 0.67,
    color: $r('app.color.main_color')
  })
  .borderRadius(2)
}

@Component
struct MTAddCut {
  @Consume
  userCart: FoodItem[]
  item: FoodItem = new FoodItem()

  @Styles
  imageStyle() {
    .width(10)
    .aspectRatio(1)
  }

  getCount() {
    return this.userCart.find(item => item.id === this.item.id)?.count || 0
  }

  build() {
    Row() {
      Text() {
        ImageSpan($r('app.media.ic_screenshot_line'))
          .imageStyle()
      }
      .textStyle()
      .visibility(this.getCount() ? Visibility.Visible : Visibility.Hidden)
      .onClick(() => {
        CartStore.addCutFood(AddCutEnum.CUT, this.item)
      })

      Text(this.getCount().toString())
        .width(28)
        .textAlign(TextAlign.Center)
        .visibility(this.getCount() ? Visibility.Visible : Visibility.Hidden)

      Text() {
        ImageSpan($r('app.media.ic_public_add_filled'))
          .imageStyle()
      }
      .textStyle()
      .backgroundColor($r('app.color.main_color'))
      .onClick(() => {
        CartStore.addCutFood(AddCutEnum.ADD, this.item)
      })
    }
  }
}

export default MTAddCut