@Entry
@Component
struct Index {
  @State message: string = 'Hello World 1000';

  build() {
    RelativeContainer() {
        Row(){
          Text(this.message)
            .id('hello1')
            .fontSize(50)
            .fontColor('red')
            .fontWeight(FontWeight.Bold)
            .alignRules({
              center: { anchor: '__container__', align: VerticalAlign.Center },
              middle: { anchor: '__container__', align: HorizontalAlign.Center }
            }).onClick(()=> {
            this.message = 'Yes I do'
          })
        }
        Row(){
          Button('click me').fontSize(24)
        }.width('100%').justifyContent(FlexAlign.Center)
        Row() {
          // Image('https://assets.wangxiao.net/images/customer/customer.png').width(100).height(100)
          Image($r("app.media.startIcon")).width(350)
            .interpolation(ImageInterpolation.High)
        }

    }
    .height('100%')
    .width('100%').backgroundColor('#afeafe')
  }

}