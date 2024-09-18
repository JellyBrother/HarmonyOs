@Entry({ routeName: 'pay_page' })
@Component
export struct PayNamePage {
  @State message: string = '支付页面';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}