import router from '@ohos.router'
@Entry
@Component
struct NewPage {
  @State message: string = 'I’m newPage'

  build() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)

        Blank()

        Row({space:50}){
          Button('push')
            .onClick(()=>{
              router.pushUrl({
                url:'pages/Index',
                params:{
                  id:'001',
                  name:'张三',
                  age:18
                }
              })
            })

          Button('replaceUrl')
            .onClick(()=>{
              router.replaceUrl({
                url:'pages/Index',
                params:{
                  id:'001',
                  name:'张三',
                  age:'18'
                }
              })
            })
        }
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .padding({top:200,bottom:200})
  }
  onPageShow() {
    console.log('PageB onPageShow')
  }

  onPageHide() {
    console.log('PageB onPageHide')
  }

  onBackPress() {
    console.log('PageB onBackPress')
  }

  aboutToDisappear() {
    console.log('PageB aboutToDisappear')
  }

  aboutToAppear() {
    console.log('PageB aboutToAppear')
  }
}