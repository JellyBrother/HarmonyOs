
@Preview
@Component
export struct MessagePage{

  build() {
    Column(){
      Text('消息')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .height('100%')
    .padding({ top: $r('app.float.top_bar_height') })
  }
}