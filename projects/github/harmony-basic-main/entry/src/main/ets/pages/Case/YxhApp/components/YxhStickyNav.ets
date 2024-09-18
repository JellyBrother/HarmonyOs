import { housesInfoList, HousesInfo } from '../mock'

const NAME_X = 16
const NAME_Y = 10
const CITY_HEIGHT = 10
const CITY_FONT_SIZE = 14

@Preview
@Component
export struct YxhStickyNav {
  @State currentIndex: number = 0
  @State arr: number[] = []
  @State showGoldExplain: boolean = false
  @State textGoldExplain: string = ''

  aboutToAppear() {
    for (let i = 0; i < 30; i++) {
      this.arr.push(i)
    }
  }

  @Builder
  getTabBarItem(title: string, index: number) {
    Text(title)
      .fontColor(this.currentIndex === index ? '#ed612b' : Color.Gray)
      .fontWeight(500)
      .fontSize(16)
  }

  @Builder
  getGoldExplainContext() {
    Row() {
      Column() {
        Text('推荐金说明')
          .height(60)
          .fontSize(20)
          .fontWeight(500)
        Text(this.textGoldExplain)
          .height(60)
          .padding({ left: 20, right: 20 })
        Text('知道了')
          .fontColor('#ed612b')
          .height(80)
          .onClick(() => {
            this.showGoldExplain = false
          })
      }
      .width('100%')
      .backgroundColor(Color.White)
      .borderRadius(8)
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('rgba(0, 0, 0, 0.3)')
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  getTabListItem(item: HousesInfo) {
    RelativeContainer() {
      // 图片
      Image(item.imgUrl)
        .width(140)
        .height(100)
        .borderRadius(6)
        .alignRules({
          top: { anchor: "__container__", align: VerticalAlign.Top },
          left: { anchor: "__container__", align: HorizontalAlign.Start }
        })
        .id("imgUrl")

      // 项目名
      Text(item.name)
        .fontSize(18)
        .fontWeight(500)
        .fontColor(Color.Black)
        .alignRules({
          top: { anchor: "__container__", align: VerticalAlign.Top },
          left: { anchor: "imgUrl", align: HorizontalAlign.End }
        })
        .offset({ x: NAME_X })
        .id('name')

      // 广州市
      Text(`${item.city} | ${item.area}`)
        .fontColor(Color.Gray)
        .fontSize(CITY_FONT_SIZE)
        .alignRules({
          top: { anchor: "name", align: VerticalAlign.Bottom },
          left: { anchor: "imgUrl", align: HorizontalAlign.End }
        })
        .offset({ x: NAME_X, y: NAME_Y })
        .id('city')

      // 地址
      Text(item.addr)
        .fontColor(Color.Gray)
        .fontSize(CITY_FONT_SIZE)
        .alignRules({
          top: { anchor: "city", align: VerticalAlign.Bottom },
          left: { anchor: "imgUrl", align: HorizontalAlign.End }
        })
        .offset({ x: NAME_X, y: NAME_Y + CITY_HEIGHT })
        .id('addr')

      // 标签列表
      List({ space: 5 }) {
        ForEach(item.labelList, (item: string) => {
          ListItem() {
            Text(item)
              .fontSize(CITY_FONT_SIZE)
              .padding({ left: 4, right: 4, top: 1, bottom: 1 })
              .fontColor(Color.Gray)
              .backgroundColor('#f5f5f5')
          }
        })
      }
      .listDirection(Axis.Horizontal)
      .alignRules({
        top: { anchor: "addr", align: VerticalAlign.Bottom },
        left: { anchor: "imgUrl", align: HorizontalAlign.End }
      })
      .offset({ x: NAME_X, y: NAME_Y + 2 * CITY_HEIGHT })
      .id('label')

      // 推荐金标准 和 按钮
      Row({ space: 10 }) {
        Text(item.goldStandard)
          .fontSize(CITY_FONT_SIZE)
          .borderRadius(6)
          .backgroundColor('#fef9f5')
          .fontColor('#f29b39')
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(2)
          .padding({ left: 16, right: 16, top: 12, bottom: 12 })
          .layoutWeight(1)
          .onClick(() => {
            this.showGoldExplain = true
            this.textGoldExplain = item.goldExplain
          })
        Button('去推荐')
          .backgroundColor('#f29a38')
          .fontSize(CITY_FONT_SIZE)
      }
      .alignRules({
        bottom: { anchor: "__container__", align: VerticalAlign.Bottom },
        left: { anchor: "__container__", align: HorizontalAlign.Start }
      })
      .id("goldStandard")
    }
    .width('100%')
    .height(176)
    .padding({ left: 16, right: 16 })
  }

  build() {

    // Tabs
    Tabs({ index: $$this.currentIndex }) {
      TabContent() {
        List({ space: 30 }) {
          ForEach(housesInfoList, (item: HousesInfo, index: number) => {
            ListItem() {
              this.getTabListItem(item)
            }
            .padding({ bottom: housesInfoList.length - 1 === index ? 20 : 0 })
          }, (item: HousesInfo) => item.name)
        }
        .width("100%")
        .divider({ strokeWidth: 1, color: '#eee' })
        .edgeEffect(EdgeEffect.Spring) // 边缘效应，设置为回弹
        // 调用来设置嵌套的滚动选项。
        .nestedScroll({
          scrollForward: NestedScrollMode.PARENT_FIRST, // 向前滚动时：父级可滚动组件优先级滚动响应
          scrollBackward: NestedScrollMode.SELF_FIRST // 向后滚动时：自已优先级滚动响应
        })
      }.tabBar(this.getTabBarItem('好房推介', 0))

      TabContent() {
      }.tabBar(this.getTabBarItem('商业地产', 1))

      TabContent() {
      }.tabBar(this.getTabBarItem('越秀星寓', 2))

      TabContent() {
      }.tabBar(this.getTabBarItem('越秀养老', 3))
    }
    .border({ width: { top: 12 }, color: '#ccc' })
    .margin({ top: 134 })
    .vertical(false)
    .backgroundColor(Color.White)
    .height("86%") // 设置 Tabs 的高度为 100%
    .bindContentCover($$this.showGoldExplain, this.getGoldExplainContext(), {
      modalTransition: ModalTransition.NONE
    })
  }
}
