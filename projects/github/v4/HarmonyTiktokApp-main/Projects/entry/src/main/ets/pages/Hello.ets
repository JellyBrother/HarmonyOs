@Entry
@Component
struct Hello{
  @State myText:string='world'
  build(){
    Column(){
      Text(`hello ${this.myText}`)
        .fontSize(20)
      Button('click me').
      onClick(() => {
        this.myText='ArkUI'
      })
        .height(50)
        .width(100)
        .margin({top:20})
    }
  }
}