@Preview
@Component
export default struct NavBar {
  @Prop
  name: string = ''
  title: string = ''
  messageCont: number = 0
  searchText: string = ''
  isSearchShow: boolean = ['wechat', 'connect'].includes(this.name)
  build() {
    Column() {
      Row() {
        Text(this.title)
          .height(40)
          .textAlign(TextAlign.Center)
        Text(` (${this.messageCont})`)
          .height(40)
          .textAlign(TextAlign.Center)
          .visibility(this.messageCont ? Visibility.Visible : Visibility.None)
      }

      Row({ space: 10 }) {
        Image('/pages/CaseDay04/CaseDay04_2/images/search.svg')
          .width(14)
          .fillColor('#ff929292')
        Text('搜索')
          .fontSize(16)
          .fontColor('#ff929292')
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .height(40)
      .backgroundColor(Color.White)
      .borderRadius(5)
      .visibility(this.isSearchShow ? Visibility.Visible : Visibility.None)
    }
    .padding(5)
    .width('100%')
  }
}