@Entry
@Component
struct LinkModifierCase {
  @State list: CardItem[] = [
    {
      id: 1,
      goods_name: '酸菜鱼',
      goods_price: 99.9,
      goods_count: 0,
    },
    {
      id: 2,
      goods_name: '麻辣烫',
      goods_price: 29.9,
      goods_count: 0,
    },
    {
      id: 1,
      goods_name: '红烧肉',
      goods_price: 50,
      goods_count: 0,
    },
  ]

  build() {
    Column() {
      HmCard({
        list: this.list,
      })
    }
  }
}

@Component
struct HmCard {
  @Link list: CardItem[]

  changeGoodsCount(type: 'add' | 'cut', item: CardItem) {
    if (type === 'add') {
      item.goods_count++
    } else {
      item.goods_count && item.goods_count--
    }
    const index = this.list.findIndex(obj => obj.id === item.id)
    this.list.splice(index, 1, item)
  }

  build() {
    Column() {
      List({ space: 20 }) {
        ForEach(this.list, (item: CardItem) => {
          ListItem() {
            HmCardItem({
              item,
              changeGoodsCount: (type: 'add' | 'cut') => {
                this.changeGoodsCount(type, item)
              }
            })
          }
        })
      }
    }
    .padding(20)
  }
}

@Component
struct HmCardItem {
  @Prop item: CardItem
  changeGoodsCount: (type: 'add' | 'cut') => void = () => {
  }

  build() {
    Row() {
      Column({ space: 10 }) {
        Text(this.item.goods_name)
          .fontSize(30)
        Text(this.item.goods_price.toString())
          .fontSize(16)
          .fontColor(Color.Red)
      }

      ChangeCount({
        count: this.item.goods_count,
        addOrCut: (type: 'add' | 'cut') => {
          this.changeGoodsCount(type)
        },
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct ChangeCount {
  @Prop count: number
  addOrCut: (type: 'add' | 'cut') => void = () => {
  }

  build() {
    Row({ space: 5 }) {
      Text('-')
        .getChangeCountTextStyle()
        .onClick(() => {
          this.addOrCut('cut')
        })
      Text(this.count.toString())
        .fontSize(30)
        .width(40)
        .textAlign(TextAlign.Center)
      Text('+')
        .getChangeCountTextStyle()
        .onClick(() => {
          this.addOrCut('add')
        })
    }
  }
}

@Extend(Text)
function getChangeCountTextStyle() {
  .width(36)
  .aspectRatio(1)
  .lineHeight(36)
  .border({
    width: 1,
    color: Color.Gray
  })
  .borderRadius(20)
  .fontSize(40)
  .textAlign(TextAlign.Center)
}

interface CardItem {
  id: number,
  goods_name: string,
  goods_price: number,
  goods_count: number,
}