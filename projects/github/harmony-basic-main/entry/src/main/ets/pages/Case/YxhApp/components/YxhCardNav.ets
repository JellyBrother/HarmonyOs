@Component
export struct YxhCardNav {
  list: ICardNav[] = [{
    title: '会员福利',
    list: [
      { title: '签到', imgUrl: $r('app.media.ic_public_sign') },
      { title: '注册', imgUrl: $r('app.media.ic_public_reg') },
      { title: '阅读有礼', imgUrl: $r('app.media.ic_public_read') },
    ]
  }, {
    title: '新手攻略',
    list: [
      { title: '我要推荐', imgUrl: $r('app.media.ic_public_zhan') },
      { title: '新手攻略', imgUrl: $r('app.media.ic_public_list') },
      { title: '推荐说明', imgUrl: $r('app.media.ic_public_zhan_list') },
    ]
  }]

  build() {
    List({ space: 16 }) {
      ForEach(this.list, (item: ICardNav, index: number) => {
        ListItem() {
          Column() {
            Row({ space: 5 }) {
              Text(item.title)
                .fontColor('#ed612b')
                .fontWeight(500)
                .fontSize(20)
              Image($r('app.media.ic_public_card_nav'))
                .width(24)
                .height(24)
            }
            .padding({ left: 16 })
            .height(72)
            .width('100%')
            .alignItems(VerticalAlign.Center)
            .justifyContent(FlexAlign.Start)
            .border({ width: { bottom: 0.5 }, color: Color.Gray })

            Row() {
              ForEach(item.list, (it: ICardNavItem) => {
                Column({ space: 5 }) {
                  Image(it.imgUrl)
                    .width(20)
                    .aspectRatio(0.8)

                  Text(it.title)
                    .fontSize(14)
                }
                .layoutWeight(1)
              })
            }
            .width('100%')
            .height(72)
            .justifyContent(FlexAlign.SpaceEvenly)
          }
          .width(200)
          .shadow({ radius: 5, color: Color.Gray })
          .borderRadius(8)
          .backgroundColor(Color.White)
        }
        .padding({
          left: index === 0 ? 16 : 0,
          right: index === this.list.length - 1 ? 16 : 0,
          top: 10,
          bottom: 10,
        })
      })
    }
    .listDirection(Axis.Horizontal)
    .scrollBar(BarState.Off)
    .position({
      y: 300
    })
  }
}

interface ICardNav {
  title: string
  list: ICardNavItem[]
}

interface ICardNavItem {
  title: string
  imgUrl: ResourceStr
}