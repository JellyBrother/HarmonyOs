import {PracticePage} from './PracticePage'
import Self from './components/Self/Self'
import {CirclePage} from './CirclePage'
@Entry
@Component
struct Index {
  //用于存储当前访问标签页的索引
  @StorageLink('currentTabIndex') currentTabIndex:number = 0

  build(){
    Tabs({index:this.currentTabIndex}){
      // 答题
      TabContent(){
        PracticePage()
      }.tabBar(this.tabBuilder(0,'答题',$r('app.media.ic_star_red'),$r('app.media.ic_star_red')))

      // 圈子
      TabContent(){
        CirclePage()
      }.tabBar(this.tabBuilder(1,'圈子',$r('app.media.ic_star_red'),$r('app.media.ic_star_red')))

      // 我的
      TabContent(){
        Self()
      }.tabBar(this.tabBuilder(2,'我的',$r('app.media.ic_star_red'),$r('app.media.ic_star_red')))
    }
    .width('100%')
    .height('100%')
    .vertical(false)
    .barPosition(BarPosition.End)
    .onChange((index)=>{
      this.currentTabIndex = index
    })
  }

  @Builder tabBuilder(tab_index:number,tab_title:string,tab_icon:Resource,tab_selected_icon:Resource){
    Column({space:5}){
      Image(this.currentTabIndex === tab_index ? tab_selected_icon : tab_icon)
        .width(25).height(25)
      Text(tab_title)
        .fontSize(16).fontWeight(FontWeight.Medium)
        .fontColor(this.currentTabIndex === tab_index ? '#ffaec6a2' : '#ff6b6767')
    }
    .width('100%')
    .backgroundColor('#fff')
  }
}

