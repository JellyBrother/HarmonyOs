@Entry
@Component
struct Index {
  @State message1: string = '欢迎来到'
  @State message2: string = 'PET-CT医学图像分析平台'
  @State message3: string = '请选择功能'

  build() {
    Row() {
      Column() {
        Text(this.message1)
          .fontSize(35)
          .fontWeight(FontWeight.Bold)
        Text("\n")
        Text(this.message2)
          .fontSize(25)
          .fontColor('#36D')
        Text("\n\n")
        Text(this.message3)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}