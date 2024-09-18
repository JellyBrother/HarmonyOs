/**
 * 多种组件的对齐布局
 * Row、Column、Flex、Stack等多种布局组件，可按照RelativeContainer组件规则进行对其排布
 */
@Entry
@Component
struct RelativeComponent4 {
  @State value: number = 0

  build() {
    RelativeContainer() {
      Row()
        .width(100)
        .height(100)
        .backgroundColor('#ff33ffcc')
        .alignRules({
          top: { anchor: "__container__", align: VerticalAlign.Top },
          left: { anchor: "__container__", align: HorizontalAlign.Start }
        })
        .id("row1")

      Column()
        .width('50%')
        .height(30)
        .backgroundColor('#AFEEEE')
        .alignRules({
          top: { anchor: "__container__", align: VerticalAlign.Top },
          left: { anchor: "__container__", align: HorizontalAlign.Center }
        })
        .id("row2")

      Flex({ direction: FlexDirection.Row }) {
        Text('1').width('20%').height(50).backgroundColor(0xF5DEB3)
        Text('2').width('20%').height(50).backgroundColor(0xD2B48C)
        Text('3').width('20%').height(50).backgroundColor(0xF5DEB3)
        Text('4').width('20%').height(50).backgroundColor(0xD2B48C)
      }
      .padding(10)
      .backgroundColor('#ffedafaf')
      .alignRules({
        top: { anchor: "row2", align: VerticalAlign.Bottom },
        left: { anchor: "__container__", align: HorizontalAlign.Start },
        bottom: { anchor: "__container__", align: VerticalAlign.Center },
        right: { anchor: "row2", align: HorizontalAlign.Center }
      })
      .id("row3")

      Stack({ alignContent: Alignment.Bottom }) {
        Text('First child, show in bottom').width('90%').height('100%').backgroundColor(0xd2cab3).align(Alignment.Top)
        Text('Second child, show in top').width('70%').height('60%').backgroundColor(0xc1cbac).align(Alignment.Top)
      }
      .margin({ top: 5 })
      .alignRules({
        top: { anchor: "row3", align: VerticalAlign.Bottom },
        left: { anchor: "__container__", align: HorizontalAlign.Start },
        bottom: { anchor: "__container__", align: VerticalAlign.Bottom },
        right: { anchor: "row3", align: HorizontalAlign.End }
      })
      .id("row4")

    }
    .width(300).height(300)
    .margin({ left: 50, top: 50 })
    .border({ width: 2, color: "#6699FF" })
  }
}