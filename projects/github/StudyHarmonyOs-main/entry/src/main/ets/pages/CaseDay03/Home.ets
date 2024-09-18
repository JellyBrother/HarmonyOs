import NavBar from './components/NavBar'

@Preview
@Entry
@Component
struct Home {
  @State list: Array<Charging> = Array(12).fill({
    id: 0,
    name: '白云科技充电站',
    distance: '560m',
    price: 1.5,
    address: '朝阳区金台路道家园1号',
    img: '/pages/CaseDay03/images/charging.png'
  })

  build() {
    Column() {
      NavBar({ title: '充电站列表' })

      List() {
        ForEach(this.list, (item: Charging, index: number) => {
          ListItem() {
            Flex({ justifyContent: FlexAlign.SpaceBetween }) {
              Image('/pages/CaseDay03/images/charging.png')
                .height(60)

              Column() {
                Row({ space: 10 }) {
                  Text(item.name)
                    .fontSize(15)
                    .fontColor('#63665D')
                  Row() {
                    Image('/images/caseday02/1/map.svg')
                      .width(10)
                      .fillColor('#ff5d5d5d')
                    Text(item.distance)
                      .fontSize(12)
                      .fontColor('#CECECE')
                  }
                }
                Text(item.address)
                  .fontSize(12)
                  .fontColor('#CECECE')
              }
              .height(60)
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(HorizontalAlign.Start)

              Column() {
                Text(`¥${item.price}`)
                  .fontColor('#abd43f')
                Button('删除')
                  .height(20)
                  .type(ButtonType.Normal)
                  .backgroundColor('#f78989')
                  .fontSize(12)
                  .onClick(() => {
                    AlertDialog.show(
                      {
                        title: '提示',
                        message: '是否删除',
                        primaryButton: {
                          value: '删除',
                          fontColor: Color.Red,
                          action: () => {
                            this.list.splice(index, 1)
                          }
                        },
                        secondaryButton: {
                          value: '取消',
                          action: () => {}
                        },
                      }
                    )

                  })
              }
              .height(60)
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(HorizontalAlign.End)
            }
          }
          .padding(20)
        })
      }
      .width('100%')
      .height('100%')
      .layoutWeight(1)
    }
    .height('100%')
    .width('100%')
  }
}

interface Charging {
  id: number
  // 名称
  name: string
  // 距离
  distance: string
  // 价格
  price: number
  // 地址
  address: string
  // 图片
  img: string
}