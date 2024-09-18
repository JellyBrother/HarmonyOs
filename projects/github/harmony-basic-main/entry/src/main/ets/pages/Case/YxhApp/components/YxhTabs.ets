import { DOOR_BAR_INDEX, RADIAN_OFFSET, IMAGE_BOX_WIDTH } from '../constants'

@Component
export struct YxhTabs {
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  )
  @Prop tabBarList: TabBarInterface[] = []
  @Link currentIndex: number
  @BuilderParam YxhTabContent: () => void
  @State doorBarItem: TabBarInterface = this.tabBarList[DOOR_BAR_INDEX]

  @Builder
  getTabBarItem(item: TabBarInterface, index: number) {
    Column({ space: 4 }) {
      if (item.name === 'door') {
        Row()
          .width(20)
          .aspectRatio(1)
      } else {
        Image(this.currentIndex === index ? item.selectIcon : item.icon)
          .width(20)
          .aspectRatio(1)
      }
      Text(item.title)
        .fontColor(this.currentIndex === index ? Color.Orange : Color.Gray)
        .zIndex(10)
    }
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Tabs({ barPosition: BarPosition.End, index: $$this.currentIndex }) {
        ForEach(this.tabBarList, (item: TabBarInterface, index) => {
          TabContent() {
            Column() {
              this.YxhTabContent()
            }
            .height('100%')
          }
          .tabBar(this.getTabBarItem(item, index))
          .border({
            width: { bottom: 1 },
            color: $r('app.color.top_border_color')
          })
        })
      }.scrollable(false)

      Stack({ alignContent: Alignment.Top }) {
        Canvas(this.context)
          .height('80%')
          .backgroundColor(Color.Transparent)
          .onReady(() => {
            const LINE_WIDTH = 1
            const LINE_OFFSET = 17.5
            this.context.strokeStyle = '#e4e4e4'
            this.context.lineWidth = LINE_WIDTH

            // 画圆弧
            this.context.beginPath();
            this.context.arc(
              IMAGE_BOX_WIDTH / 2,
              IMAGE_BOX_WIDTH / 2 + LINE_WIDTH,
              IMAGE_BOX_WIDTH / 2,
              3.14 + RADIAN_OFFSET,
              6.28 - RADIAN_OFFSET
            );
            this.context.stroke();

            // 左边补短横线
            this.context.beginPath();
            this.context.moveTo(0, LINE_OFFSET);
            this.context.lineTo(1, LINE_OFFSET);
            this.context.stroke();

            // 右边补短横线
            this.context.beginPath();
            this.context.moveTo(IMAGE_BOX_WIDTH - 1, LINE_OFFSET);
            this.context.lineTo(IMAGE_BOX_WIDTH, LINE_OFFSET);
            this.context.stroke();
          })
        Image(this.currentIndex === DOOR_BAR_INDEX ? this.doorBarItem.selectIcon : this.doorBarItem.icon)
          .width(40)
          .aspectRatio(1)
          .backgroundColor(Color.Orange)
          .borderRadius(20)
          .padding(8)
          .margin({ top: 5 })
      }
      .width(IMAGE_BOX_WIDTH)
      .aspectRatio(1)
      .margin({ bottom: 24 })
      .onClick(() => {
        this.currentIndex = DOOR_BAR_INDEX
      })
    }
  }
}

export interface TabBarInterface {
  icon: ResourceStr
  selectIcon: ResourceStr
  title: string
  name: string
}