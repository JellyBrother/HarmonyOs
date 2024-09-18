import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct DblClickTabBar {
  controller: TabsController = new TabsController()
  @State currentIndex: number = 0
  @State message: string = 'Hello World';
  lastTime: number = 0

  @Builder
  tabBuilder(title: string, targetIndex: number) {
    Column() {
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? '#1698CE' : '#6B6B6B')
        .onClick(() => {
          this.currentIndex = targetIndex
          this.controller.changeIndex(targetIndex)
          this.dblClick()
        })
    }
  }

  dblClick() {
    const current = Date.now()
    if (current - this.lastTime < 300) {
      promptAction.showToast({ message: '双击' })
    }
    this.lastTime = current
  }

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.controller }) {
      TabContent() {
        Text('main')
      }.tabBar(this.tabBuilder('首页', 0))

      TabContent() {
        Text('list')
      }.tabBar(this.tabBuilder('列表', 1))

      TabContent() {
        Text('my')
      }.tabBar(this.tabBuilder('列我的表', 2))
    }
    .onChange((index: number) => {
      this.currentIndex = index
    })
  }
}