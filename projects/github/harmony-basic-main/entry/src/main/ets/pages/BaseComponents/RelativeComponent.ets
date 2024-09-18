/**
 * 使用 RelativeContainer 实现张三样式
 */

@Entry
@Component
struct RelativeComponent {
  build() {
    RelativeContainer() {
      Text('张')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .height(40)
        .width(40)
        .textAlign(TextAlign.Center)
        .clip(new Circle({ width: 40, height: 40 }))
        .backgroundColor(Color.Green)
        .alignRules({
          // center: { anchor: "__container__", align: VerticalAlign.Center },
          left: { anchor: "__container__", align: HorizontalAlign.Start, }
        })
        .id('head')
      Text('张三')
        .fontSize(16)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .fontColor('# ff182431')
        .maxLines(1)
        .fontWeight(FontWeight.Medium)
        .padding({ left: 12 })
        .height(22)
        .alignRules({
          top: { anchor: 'head', align: VerticalAlign.Top },
          left: { anchor: 'head', align: HorizontalAlign.End }
        })
        .id('name')
      Text('2分钟前')
        .fontColor('# 66182431')
        .fontSize(12)
        .maxLines(1)
        .height(22)
        .alignRules({
          top: { anchor: 'head', align: VerticalAlign.Top },
          right: { anchor: '__container__', align: HorizontalAlign.End }
        })
        .id("time")
      Text() {
        //Content Abbreviations for Latest News
        Span('Hello World'.replace(new RegExp("/[\r\n]/g"), " "))
          .fontSize(14)
          .fontColor('# 66182431')
      }
      .maxLines(1)
      .textOverflow({ overflow: TextOverflow.Ellipsis })
      .width('100%')
      .height(19)
      .margin({ top: 2 })
      .padding({ left: 12 })
      .alignRules({
        top: { anchor: 'name', align: VerticalAlign.Bottom },
        left: { anchor: 'head', align: HorizontalAlign.End }
      })
      .id('content')
    }
    // .width('100%')
    // .height('100%')
    .padding(10)
    .border({ width: 20, color: Color.Orange })
  }
}