import { ReplyItem, ReplyItemModel } from '../models'

@Preview
@Component
export default struct CommentItem {
  @Prop
  item: ReplyItemModel = new ReplyItemModel({} as ReplyItem)
  like: () => void = () => {}
  build() {
    Row({ space: 20 }) {
      Column() {
        Image(this.item.avatar)
          .width(40)
          .aspectRatio(1)
          .borderRadius(20)
            // 性能优化：同步加载适用于较小图片资源
          .syncLoad(true)
      }

      Column({ space: 10 }) {
        Text(this.item.author)
          .fontSize(18)
          .fontColor('#2b3037')
          .fontWeight(FontWeight.Bold)
        Text(this.item.content)
          .fontSize(16)
          .fontColor('#404546')
        Row() {
          Row({ space: 5 }) {
            Text(this.item.time)
              .fontSize(14)
              .fontColor('#d5d5d5')
            Text(`.IP 属地${this.item.area}`)
              .fontSize(14)
              .fontColor('#d5d5d5')
          }
          Row() {
            Image('/pages/CaseDay04/CaseDay04_1/images/like.svg')
              .width(16)
              .fillColor(this.item.likeFlag ? Color.Red : '#CCC')
            Text(this.item.likeNum.toFixed(0))
              .fontSize(14)
              .fontColor('#d5d5d5')
          }
          .onClick(() => {
            this.like()
          })
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .alignItems(VerticalAlign.Top)
    .width('100%')
  }
}