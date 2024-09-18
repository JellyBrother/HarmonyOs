@Entry
@Component
struct ObservedObjectLinkModifier {
  @State
  commentList: DyCommentModel[] = [
    new DyCommentModel({
      content: '我知道了',
      like_count: 10,
      author: '小宝宝'
    }),
    new DyCommentModel({
      content: '快点长大吧',
      like_count: 7,
      author: '大白'
    }),
  ]

  build() {
    List({ space: 20 }) {
      ForEach(this.commentList, (item: DyCommentModel) => {
        ListItem() {
          DyCommentItem({ item: item })
        }
        .onClick(() => {
          // 可以直接更新第二层数据，同时实现视图更新
          item.like_count++
        })
      })
    }
    .width('100%')
    .height('100%')
    .padding(20)
  }
}

@Component
struct DyCommentItem {
  @ObjectLink
  item: DyCommentModel

  build() {
    Row() {
      Text(this.item.author)
      Text(this.item.content)
      Text(this.item.like_count.toString())
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
  }
}

interface DyComment {
  content: string
  like_count: number
  author: string
}

@Observed
export class DyCommentModel implements DyComment {
  content: string = ''
  like_count: number = 0
  author: string = ''

  constructor(model: DyComment) {
    this.content = model.content
    this.like_count = model.like_count
    this.author = model.author
  }
}
