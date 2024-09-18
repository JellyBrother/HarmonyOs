import { ReplyItem, ReplyItemModel } from '../models'

@Component
struct ZhCommentItem {
  @ObjectLink
  item: ReplyItemModel
  onChangeLike: () => void = () => {
    this.item.likeFlag ? this.item.likeNum-- : this.item.likeNum++
    this.item.likeFlag = !this.item.likeFlag
  }

  build() {
    Row({ space: 16 }) {
      Image(this.item.avatar)
        .width(50)
        .aspectRatio(1)
        .borderRadius(25)

      Column({ space: 12 }) {
        Text(this.item.author)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        Text(this.item.content)
          .lineHeight(22)
          .maxLines(2)
          .width('100%')
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Row() {
          Text(`${this.item.time} .IP属性${this.item.area}`)
            .fontColor('#ccc')
          Row({ space: 5 }) {
            Image($r('app.media.ic_public_like'))
              .width(12)
              .fillColor(this.item.likeFlag ? Color.Red : '#ccc')
            Text(this.item.likeNum.toString())
              .fontColor(this.item.likeFlag ? Color.Red : '#ccc')
          }
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .onClick(() => this.onChangeLike())
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
    }
    .padding(20)
    .alignItems(VerticalAlign.Top)
  }
}

export {
  ZhCommentItem
}