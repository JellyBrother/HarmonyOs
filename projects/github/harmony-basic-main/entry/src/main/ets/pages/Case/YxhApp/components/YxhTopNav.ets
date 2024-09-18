@Component
export struct YxhTopNav {
  @Prop showTopNavBg: boolean = false

  build() {
    Row() {
      Row() {
        Image(this.showTopNavBg ? $r('app.media.ic_yxh_location_color') : $r('app.media.ic_yxh_location'))
          .width(24)
          .padding({ right: 3 })
        Text(`广州市 | `)
          .fontColor(this.showTopNavBg ? Color.Black : Color.White)
        Text(`请登录`)
          .fontColor(this.showTopNavBg ? Color.Black : Color.White)
      }

      Row({ space: 10 }) {
        Image(this.showTopNavBg ? $r('app.media.ic_yxh_service_color') : $r('app.media.ic_yxh_service'))
          .width(24)
        Image(this.showTopNavBg ? $r('app.media.ic_yxh_mess_color') : $r('app.media.ic_yxh_mess'))
          .width(24)
      }
    }
    .zIndex(10)
    .width('100%')
    .height(100)
    .padding({ left: 16, right: 16, bottom: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Bottom)
    .backgroundColor(this.showTopNavBg ? Color.White : Color.Transparent)
  }
}