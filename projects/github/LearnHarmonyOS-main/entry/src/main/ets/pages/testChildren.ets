@Component
export struct testChildren {
  @Prop message: string = '';
  build() {
    RelativeContainer() {
      Text(this.message)
        .id('TestChildrenHelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }
    .height('100%')
    .width('100%')
  }
}