import TitleComponent from './TitleComponent';
import {
  ClassifyInterface,
  getMovie_test_data_CategoryComponent,
  MovieInterface,
  MyAwesomeData
} from '../constants/Constants';
import MovieListComponent from './MovieListComponent';
import HashMap from '@ohos.util.HashMap';
import { LogUtil } from '@ohos/lib_utils';

@Component
export default struct CategoryComponent {
  private TAG: string = 'CategoryComponent'
  @Prop classifyItemStr: string; // Prop不能传递object对象
  @State classifyItem: ClassifyInterface = null;
  @State movieList: Array<MovieInterface> = [];

  aboutToAppear() {
    // 把字符串转成对象
    this.classifyItem = JSON.parse(this.classifyItemStr) as ClassifyInterface;
    this.useCategoryList();
  }

  useCategoryList() {
    try {
      // let classifyItemJson: ClassifyInterface = JSON.parse(this.classifyItem.toString()) as ClassifyInterface
      let map: HashMap<string, string> = getMovie_test_data_CategoryComponent()
      // let testData: string = map.get(this.classifyItem.category)
      let testData: string = map.get(`最新上线`)
      let res: MyAwesomeData<Array<MovieInterface>> = JSON.parse(testData.toString()) as MyAwesomeData<Array<MovieInterface>>
      this.movieList = res.data;
      // getCategoryListService(this.classifyItem).then((res)=>{
      //   this.movieList = res.data;
      // })
    } catch (e) {
      LogUtil.error(this.TAG, `useCategoryList error ${e}`)
    }
  }

  build() {
    Column() {
      TitleComponent({ title: this.classifyItem.category, showMarginBottom: true })
      if (this.movieList.length > 0) { // 必须加判断，否则后更新的数据不会触发MovieListComponent组件重新渲染
        MovieListComponent({ gravity: 'horizontal', movieList: $movieList })
      }
    }
    .backgroundColor('#fff')
    .borderRadius(15)
    .padding(15)
    .width('100%')
    .margin({ top: 15 })
  }
}