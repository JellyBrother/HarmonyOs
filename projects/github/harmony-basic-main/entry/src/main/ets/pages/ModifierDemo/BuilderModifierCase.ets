const DOOR_BAR_INDEX_2 = 2
const RADIAN_OFFSET_2 = 0.32
const IMAGE_BOX_WIDTH_2 = 50

@Entry
@Component
struct BuilderModifierCase {
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  )
  @State currentIndex: number = 0
  @State tabBarList: TabBarInterface[] = [{
    icon: $r("app.media.ic_public_home"),
    selectIcon: $r('app.media.ic_public_home_fill'),
    name: 'home',
    title: '首页',
  }, {
    icon: $r('app.media.ic_public_houses'),
    selectIcon: $r('app.media.ic_public_houses_fill'),
    name: 'houses',
    title: '新盘',
  }, {
    icon: $r('app.media.ic_public_key'),
    selectIcon: $r("app.media.ic_public_key_filled"),
    name: 'door',
    title: '一键开门',
  }, {
    icon: $r('app.media.ic_public_shop'),
    selectIcon: $r('app.media.ic_public_shop_fill'),
    name: 'shop',
    title: '商城',
  }, {
    icon: $r('app.media.ic_public_my'),
    selectIcon: $r('app.media.ic_public_my_fill'),
    name: 'my',
    title: '我的',
  }]
  @State doorBarItem: TabBarInterface = this.tabBarList[DOOR_BAR_INDEX_2]

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
              Text(index + '-' + this.currentIndex)
              Text()
              Text(item.title)
            }
          }.tabBar(this.getTabBarItem(item, index))
          .border({
            width: { bottom: 1 },
            color: $r('app.color.top_border_color')
          })
        })
      }

      Stack({ alignContent: Alignment.Top }) {
        Canvas(this.context)
          .height('80%')
          .backgroundColor(Color.White)
          .onReady(() => {
            const LINE_WIDTH = 1
            const LINE_OFFSET = 17.5
            this.context.strokeStyle = '#e4e4e4'
            this.context.lineWidth = LINE_WIDTH

            // 画圆弧
            this.context.beginPath();
            this.context.arc(
              IMAGE_BOX_WIDTH_2 / 2,
              IMAGE_BOX_WIDTH_2 / 2 + LINE_WIDTH,
              IMAGE_BOX_WIDTH_2 / 2,
              3.14 + RADIAN_OFFSET_2,
              6.28 - RADIAN_OFFSET_2
            );
            this.context.stroke();

            // 左边补短横线
            this.context.beginPath();
            this.context.moveTo(0, LINE_OFFSET);
            this.context.lineTo(1, LINE_OFFSET);
            this.context.stroke();

            // 右边补短横线
            this.context.beginPath();
            this.context.moveTo(IMAGE_BOX_WIDTH_2 - 1, LINE_OFFSET);
            this.context.lineTo(IMAGE_BOX_WIDTH_2, LINE_OFFSET);
            this.context.stroke();
          })
        Image(this.currentIndex === DOOR_BAR_INDEX_2 ? this.doorBarItem.selectIcon : this.doorBarItem.icon)
          .width(40)
          .aspectRatio(1)
          .backgroundColor(Color.Orange)
          .borderRadius(20)
          .padding(8)
          .margin({ top: 5 })
      }
      .width(IMAGE_BOX_WIDTH_2)
      .aspectRatio(1)
      .margin({ bottom: 24 })
      .onClick(() => {
        this.currentIndex = DOOR_BAR_INDEX_2
      })
    }
  }
}

interface TabBarInterface {
  icon: ResourceStr
  selectIcon: ResourceStr
  title: string
  name: string
}
