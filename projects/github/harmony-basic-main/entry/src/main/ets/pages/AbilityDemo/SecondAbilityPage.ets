@Entry
@Component
struct SecondAbilityPage {
  @State message: string = 'Second Ability Page';

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('SecondAbilityPageHelloWorld')
        .fontSize(30)
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