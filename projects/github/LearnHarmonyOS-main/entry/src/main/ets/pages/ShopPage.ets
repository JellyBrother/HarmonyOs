import {Header} from '../../Component/CommonCOmponent'
import ShopInfo from '../viewmodel/ShopInfo'
import  ShopItem from '../views/ShopItem'
import shopModel from '../model/ShopModel'
@Entry
@Component
struct ShopPage {

  @State shops: ShopInfo[] = []

  isLoading: boolean = false

  isMore: boolean = true

  aboutToAppear(): void {
    this.loadShopInfos()
  }


  build() {
    Column() {
      Header({title:'商铺列表'})
        .margin(20)

      List({space:10}){
        ForEach(this.shops, (shop:ShopInfo) => {
          ListItem(){
            ShopItem({shop:shop})
          }
        })
      }
      .width('100%')
      .height('80%')
      .layoutWeight(1)
      .onReachEnd(()=>{
        console.log('触底了')

        if(!this.isLoading && this.isMore){
          this.isLoading = true
          console.log('加载数据')
          shopModel.pageNo ++
          this.loadShopInfos()
        }

      })
      .onReachStart(()=>{
        shopModel.pageNo = 1;
        this.loadShopInfos()
      })


    }
    .height('100%')
    .width('100%')
    .padding(10)
  }

  //加载数据
  loadShopInfos(){

    //请求接口如果没反应 需要在终端里面进入shopServer 文件夹  npm install   npm start
    //原生http请求
    // shopModel.getShopList()
    //axios 请求方式
    shopModel.getShopListWithAXiOS()
      .then((shops)=>{
        console.log('返回的数组个数啊',shops.length)

        shops.forEach( s =>{
          s.images.forEach((src:string,i:number)=>{
            ////这里的ip  替换成自己的电脑ip
            s.images[i] = 'http://10.1.7.104:3000' + src
          })
        })

        if(!shops || shops.length === 0){
          this.isMore = false
        }

        //下拉刷新第一页
        if(shopModel.pageNo === 1){
          this.shops = shops
        }

        //拼接上去后面的数据
        this.shops = this.shops.concat(shops);

        this.isLoading = false

        console.log('全部数组的个数啊',this.shops.length)

      })
      .catch(()=>{

      })



  }




}