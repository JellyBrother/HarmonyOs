import router from '@ohos.router';

// 变量持久化
PersistentStorage.PersistProp('token','')
// 存储Tabs组件当前访问子页面的索引
AppStorage.SetOrCreate('currentTabIndex',0)

@Entry
@Component
export struct SplashPage {
  // 是否展示动画组件
  @State isShow:boolean = false;

  onPageShow(){
    animateTo({
      duration:1500,
      onFinish:()=>{
        setTimeout(()=>{
          router.replaceUrl({url:'pages/Index'})
        },200)
      }
    },
      ()=>{
        this.isShow = true
      })
  }

  build() {
    Column(){
      Image($r('app.media.icon'))
        .width(90)
        .height(90)
        .margin({top:100})
        .transition({type:TransitionType.Insert,opacity:0,translate:{x:-150}})

      Text('快速单词记忆神器')
        .fontSize(21)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bold)
        .margin({top:15})
        .transition({ type: TransitionType.Insert, opacity: 0, translate: { x: 150 } })

      Blank()

      Text('Welcome')
        .fontSize(12)
        .fontColor('#ffe5e3e3')
        .fontWeight(FontWeight.Bold)
        .margin({bottom:30})

    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.splash_bg'))
    .backgroundImageSize({width:'100%',height:'100%'})
  }
}