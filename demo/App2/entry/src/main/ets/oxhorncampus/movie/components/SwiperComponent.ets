import {
  ClassifyInterface,
  getMovie_test_data_CategoryComponent,
  HOST,
  MovieInterface,
  MyAwesomeData
} from '../constants/Constants';
import HashMap from '@ohos.util.HashMap';
import { LogUtil } from '@ohos/lib_utils';

@Component
export default struct SwiperComponent {
  private TAG: string = 'SwiperComponent'
  @Prop classify: string;
  @State movieList: Array<MovieInterface> = []
  private swiperController: SwiperController = new SwiperController()

  aboutToAppear() {
    this.useCategoryList()
  }

  useCategoryList() {
    try {
      let map: HashMap<string, string> = getMovie_test_data_CategoryComponent()
      let testData: string = map.get('轮播')
      let res: MyAwesomeData<Array<MovieInterface>> = JSON.parse(testData.toString()) as MyAwesomeData<Array<MovieInterface>>
      this.movieList = res.data.slice(0, 5);

      // getCategoryListService({ classify: this.classify, category: '轮播' }).then((res) => {
      //   this.movieList = res.data.slice(0, 5);
      // })
    } catch (e) {
      LogUtil.error(this.TAG, `useCategoryList error ${e}`)
    }
  }

  build() {
    if (this.movieList.length > 0) {
      Swiper(this.swiperController) {
        ForEach(this.movieList, (movieItem: MovieInterface) => {
          Image(movieItem.img)
            .height(180)
            .width('100%')
            .borderRadius(15)
        })
      }
      .loop(true)
      .autoPlay(true)
      .interval(5000)
    }

  }
}