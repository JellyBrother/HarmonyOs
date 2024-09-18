import { FoodItem } from '../models'
import MTAddCut from './MTAddCut'

@Preview
@Component
struct MTCartItem {
  item: FoodItem = new FoodItem()

  build() {
    Row({ space: 10 }) {
      Image(this.item.picture)
        .width(80)
        .aspectRatio(1)
        .borderRadius(8)
      Column({ space: 10 }) {
        Text(this.item.name)
          .maxLines(2)
          .fontSize(18)
          .width('100%')
          .textOverflow({
            overflow: TextOverflow.Ellipsis,
          })
        Row() {
          Text() {
            Span('￥')
              .fontSize(12)
            Span(this.item.price.toString())
              .fontSize(24)
          }
          .fontColor($r('app.color.font_main_color'))
          .fontWeight(FontWeight.Bold)

          MTAddCut({ item: this.item })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .height(80)
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width('100%')
  }
}

export default MTCartItem