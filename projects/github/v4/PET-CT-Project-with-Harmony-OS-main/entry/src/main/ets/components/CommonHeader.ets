import router from '@ohos.router'
@Component
export struct CommonHeader {
  build() {
    Row({space:5}) {
      Image($r('app.media.back'))
        .width(30)
        .onClick(() =>(
          router.back()
        ))
      Blank()
      Image($r('app.media.refresh'))
        .width(30)
    }
    .width('98%')
    .height(30)
  }
}