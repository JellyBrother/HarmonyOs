import { ClassifyInterface, movie_test_data_HomeComponent, MyAwesomeData } from '../constants/Constants';
import SwiperComponent from './SwiperComponent';
import CategoryComponent from './CategoryComponent';
import SearchComponent from './SearchComponent';
import { LogUtil } from '@ohos/lib_utils';

@Entry
@Component
export default struct HomeComponent {
  private TAG: string = 'HomeComponent'
  @State allCategoryList: Array<ClassifyInterface> = [];
  @State currentCategoryList: Array<ClassifyInterface> = [];
  @State isScrollEnd: boolean = false;
  private scroller: Scroller = new Scroller()

  @Styles
  blockStyle(){
    .backgroundColor('#ffffff')
    .borderRadius(15)
    .padding(15)
    .width('100%')
    .margin({ top: 15 })
  }

  @Styles
  classifyItemStyle(){
    .width(40)
    .height(40)
    .margin({ bottom: 10 })
  }

  aboutToAppear() {
    this.useAllCategoryListByPageName()
  }

  useAllCategoryListByPageName() {
    try {
      let result: MyAwesomeData<Array<ClassifyInterface>> = JSON.parse(movie_test_data_HomeComponent.toString()) as MyAwesomeData<Array<ClassifyInterface>>
      this.allCategoryList = result.data;
      this.currentCategoryList = this.allCategoryList.slice(0, 2)

      // getAllCategoryListByPageNameService('首页').then((res) => {
      //   this.allCategoryList = res.data;
      //   this.currentCategoryList = this.allCategoryList.slice(0, 2)
      // })
    } catch (e) {
      LogUtil.error(this.TAG, `useAllCategoryListByPageName error ${e}`)
    }

    // getAllCategoryListByPageNameService('首页').then((res) => {
    //   this.allCategoryList = res.data;
    //   this.currentCategoryList = this.allCategoryList.slice(0, 2)
    // })
  }

  build() {
    Column() {
      SearchComponent({ classify: '电影' })
      Scroll(this.scroller) {
        Column() {
          SwiperComponent({ classify: '电影' }).margin({ top: 15 })
          Row() {
            Column() {
              Image($r('app.media.icon_hot')).classifyItemStyle()
              Text('热门').fontSize(15)
            }
            .flexGrow(1)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)

            Column() {
              Image($r('app.media.icon_play')).classifyItemStyle()
              Text('预告').fontSize(15)
            }
            .flexGrow(1)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)

            Column() {
              Image($r('app.media.icon_top')).classifyItemStyle()
              Text('最新').fontSize(15)
            }
            .flexGrow(1)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)

            Column() {
              Image($r('app.media.icon_classify')).classifyItemStyle()
              Text('分类').fontSize(15)
            }
            .flexGrow(1)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
          }.blockStyle()

          ForEach(this.currentCategoryList, (item: ClassifyInterface) => {
            CategoryComponent({ classifyItemStr: JSON.stringify(item) })
          })
          Row() {
            Text(this.isScrollEnd ? '已经到底了...' : '正在加载更多...')
          }.padding({ top: 15, bottom: 15 })
        }
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
      .onScrollEdge((side: Edge) => {
        if (!this.isScrollEnd) {
          const length: number = this.currentCategoryList.length
          this.currentCategoryList.push(...this.allCategoryList.slice(length, length + 2))
          if (this.currentCategoryList.length === this.allCategoryList.length) {
            this.isScrollEnd = true
          }
        }
      }) // 滚动方向纵向
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#efefef')
    .padding({ left: 15, right: 15, top: $r('app.float.top_bar_height') })
  }
}