import App from '@system.app';
import http from '@ohos.net.http';

import { PreferencesUtil, StrUtil, ToastUtil } from '@pura/harmony-utils';


import router from '@ohos.router';

class RouterInfo{
  url: string
  title:string

  constructor(url:string,title:string) {
    this.url = url;
    this.title = title;
  }

}






@Entry
@Component
struct Index {
  @State message: string = '页面列表';
  @State time:number = 0
  @State imagewidth:number = 250;


  private  routers:RouterInfo[] = [
    new RouterInfo('pages/shoplist','商品列表'),
    new RouterInfo('pages/ImagePage','图片放大缩小案例'),
    new RouterInfo('pages/PropPage','任务列表案例'),
    new RouterInfo('pages/StatePage','Jack和女友的案例'),
    new RouterInfo('pages/testFather','组件生命周期'),
    new RouterInfo('pages/ShopPage','查询商铺案例'),
  ]


aboutToAppear(): void {




  }



  build() {
      Column(){

        Text(this.message)
          .fontSize(50)
          .height(80)
          .fontWeight(FontWeight.Bold)

        List({space:5}){
          ForEach(
            this.routers,
            (router:RouterInfo,Index) =>{
              ListItem(){
                this.RouterItem(router,Index+1)
              }
            }
          )
        }
        .layoutWeight(1)
        .alignListItem(ListItemAlign.Center)
        .width('100%')
      }
      .layoutWeight(1)
      .width('100%')
      .height('100%')
  }


  @Builder
  RouterItem(r:RouterInfo,i:number){
    Row(){
      Text(i + '.')
        .fontSize(20)
        .fontColor(Color.White)
      Blank()
      Text(r.title)
        .fontSize(20)
        .fontColor(Color.White)
    }
    .width('90%')
    .padding(12)
    .backgroundColor('#38f')
    .borderRadius(20)
    .shadow({radius:6,color:'#4F0000',offsetX:2,offsetY:2})
    .onClick(()=>{
      //router 跳转  push
      router.pushUrl(
        {
        url:r.url,
        params:{id:i}
        },
         router.RouterMode.Single,
        err =>{
          if(err){
            console.log(`路由失败, errCode: ${err.code} errMSg:${err.message}`)
          }
        }
      )
    })
  }




}