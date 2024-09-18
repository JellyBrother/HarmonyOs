@Entry
@Component
struct PokeListPage {
  @State message: string = 'PokeListPage';

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('PokeListPage')
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