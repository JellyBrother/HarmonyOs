import router from '@ohos.router';
import { LogUtil } from '@ohos/lib_utils';
import { MovieInterface, movie_test_data_SearchComponent, MyAwesomeData } from '../constants/Constants';
import AvaterComponent from './AvaterComponent';

@Component
export default struct SearchComponent{
  private TAG: string = 'SearchComponent'

  @Styles blockStyle(){
    .backgroundColor('#ffffff')
    .borderRadius(15)
    .padding(15)
    .width('100%')
    .margin({top:15})
  }

  @State movieItem:MovieInterface = null
  @Prop classify:string;
  @State dimensions:number = 40;// 导入的值不能直接传给组件

  aboutToAppear(){
    this.useSearchKeyWord()
  }

  useSearchKeyWord(){
    try {
      let result: MyAwesomeData<MovieInterface> = JSON.parse(movie_test_data_SearchComponent.toString()) as MyAwesomeData<MovieInterface>
      this.movieItem = result.data;

      // getSearchKeyWordService(this.classify).then((res)=>{
      //   this.movieItem = res.data;
      // })
    } catch (e) {
      LogUtil.error(this.TAG, `useAllCategoryListByPageName error ${e}`)
    }
  }

  build(){
    Row(){
      AvaterComponent({dimensions:this.dimensions})
      Row(){
        Text(this.movieItem?.movieName)
          .fontSize(15)
          .fontColor('#999999')
      }
      .height(40)
      .borderRadius(40)
      .backgroundColor('#efefef')
      .margin({left: 15})
      .padding({left: 15})
      .flexGrow(1)
      .onClick(()=>{
        router.pushUrl({
          url: 'moviemusic/movie/pages/MovieSearchPage', // 目标url
          params: {
            classify:this.classify,
            movieItem: this.movieItem
          }
        }, router.RouterMode.Standard, (err) => {
          if(err){
            console.error(`Invoke showAlertBeforeBackPage failed, code is ${err.code}, message is ${err.message}`);
          }
        });
      })
    }.blockStyle()
  }
}