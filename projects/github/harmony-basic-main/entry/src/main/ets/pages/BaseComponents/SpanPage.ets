@Entry
@Component
struct SpanPage {
  @State message: string = 'Hello World';

  build() {
    Column() {
      Text(this.message) {
        Span('Span文本')
          .decoration({
            // 文本装饰线样式和颜色
            type: TextDecorationType.Underline,
            color: Color.Red
          })
          .fontSize(40)
      }

      Text('1')
      Text('2')

    }
    .height('100%')
    .width('100%')
  }
}