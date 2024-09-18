
import Home from '../pages/Home/index'
import PassCard from '../pages/PassCard'
@Component
export default struct Tabbar {
  private tabsController: TabsController = new TabsController()
  @State currentIndex: number = 0

  @Builder
  TabBuilder(title: string, number: number, selectedImg: Resource, defaultImg: Resource) {
    Column() {
      Image(this.currentIndex === number ? selectedImg : defaultImg).width(24).height(24).margin({ top: 11, bottom: 5 })
      Text(title)
        .fontFamily('PingFangSC, PingFang SC')
        .fontSize(12)
        .fontColor(this.currentIndex === number? '#fff' : '#0165D4')
        .fontWeight(300)
        .width(61)
        .height(17)
        .textAlign(TextAlign.Center)
    }.width('100%').height(61).onClick(() => {
      this.currentIndex = number
      // 切换新的tabs
      this.tabsController.changeIndex(this.currentIndex)
    })
  }

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.tabsController }) {
      TabContent() {
        Home().width('100%').height('100%')

        // PassCard()
      }
      .tabBar(this.TabBuilder('首页', 0, $r('app.media.home_default'), $r('app.media.home_select')))

      TabContent() {
        Column().width('100%').height('100%').backgroundColor('#e5e5e5')
      }.tabBar(this.TabBuilder('指南', 1, $r('app.media.finger_default'), $r('app.media.finger_select')))

      TabContent() {
        PassCard()
      }.tabBar(this.TabBuilder('CLUB', 2, $r('app.media.club_default'), $r('app.media.club_select')))

      TabContent() {
        Column().width('100%').height('100%').backgroundColor('#e5e5e5')
      }.tabBar(this.TabBuilder('PAPER', 3, $r('app.media.paper_default'), $r('app.media.paper_select')))

      TabContent() {
        Column().width('100%').height('100%').backgroundColor('#e5e5e5')
      }.tabBar(this.TabBuilder('我的', 4, $r('app.media.mine_default'), $r('app.media.mine_select')))
    }.barBackgroundColor('#0092FF').barWidth('100%').barHeight(61)
  }
}