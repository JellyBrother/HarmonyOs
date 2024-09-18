@Component
export default struct Navbar {
  @Prop title: string | undefined | null = ''
  @Prop showBackIcon: boolean
  @Prop showMoreIcon: boolean
  @Prop bgColor: string | ResourceColor = 'rgba(72,195,255, 1)'
  @Prop showOpacity: boolean
  @Prop fontColor: string

  build() {
    Row() {
      Flex({
        justifyContent: FlexAlign.SpaceBetween,
        alignItems: ItemAlign.Center
      }) {
        Image($r('app.media.return_left'))
          .width(9)
          .height(17)
          .visibility(this.showBackIcon ? Visibility.Visible : Visibility.Hidden)
        Text(this.title).fontFamily('PingFangSC, PingFang SC').fontSize(17).fontWeight(500).fontColor(this.fontColor)
        Image($r('app.media.more_white'))
          .width(18)
          .height(4)
          .visibility(this.showMoreIcon ? Visibility.Visible : Visibility.Hidden)
      }.margin({ bottom: 10 })
    }
    .padding({ left: 16, right: 16 })
    .height(80)
    .backgroundColor(this.showOpacity ? 'rgba(0,0,0,0)' : this.bgColor)
    .alignItems(VerticalAlign.Bottom)
    .position({ x: 0, y: 0 })
  }
}