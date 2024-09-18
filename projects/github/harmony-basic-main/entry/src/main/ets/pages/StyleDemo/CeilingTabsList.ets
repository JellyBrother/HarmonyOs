/**
 * Tabs + List 实现 Tabs 吸顶功能
 */

@Entry
@Component
struct StickyNestedScroll {
  @State message: string = 'Hello World'
  @State arr: number[] = []
  scroller = new Scroller()

  @Styles
  listCard() {
    .backgroundColor(Color.White)
    .height(72)
    .width("100%")
    .borderRadius(12)
  }

  build() {
    Scroll(this.scroller) {
      Column() {
        // 图片
        Stack({ alignContent: Alignment.Top }) {
          Column()
            .height(280)
            .width('100%')
            .backgroundImage($r('app.media.background'), ImageRepeat.XY)
        }

        // Tabs
        Tabs() {
          TabContent() {
            List({ space: 10 }) {
              ForEach(this.arr, (item: number) => {
                ListItem() {
                  Text("item" + item).fontSize(16)
                }.listCard()
              }, (item: string) => item)
            }
            .width("100%")
            .edgeEffect(EdgeEffect.Spring) // 边缘效应，设置为回弹
            // 调用来设置嵌套的滚动选项。
            .nestedScroll({
              scrollForward: NestedScrollMode.PARENT_FIRST, // 向前滚动时：父级可滚动组件优先级滚动响应
              scrollBackward: NestedScrollMode.SELF_FIRST // 向后滚动时：自已优先级滚动响应
            })
            .padding({ left: 10, right: 10 })
          }.tabBar("Tab1")

          TabContent() {
          }.tabBar("Tab2")

          TabContent() {
          }.tabBar("Tab3")
        }
        .vertical(false)
        .backgroundColor(Color.Pink)
        .height("100%") // 设置 Tabs 的高度为 100%
      }.width("100%")
    }
    .edgeEffect(EdgeEffect.Spring) // 边缘效应，设置为回弹
    .friction(0.6)
    .backgroundColor('#DCDCDC')
    .scrollBar(BarState.Off) // 关闭最外层滚动条
    .width('100%')
    .height('100%')
  }

  aboutToAppear() {
    for (let i = 0; i < 30; i++) {
      this.arr.push(i)
    }
  }

  @Builder
  testHead() {
    Text('吸顶').width('100%').height(40).backgroundColor(Color.Black).zIndex(999)
  }
}
