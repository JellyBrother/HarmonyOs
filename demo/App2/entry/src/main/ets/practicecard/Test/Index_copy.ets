@Entry
@Component
struct Index {
  @State begin:number = 30;
  @State end:number = 100;

  build() {
    Column({ space: 20 }) {
      Row({space:20}) {
        Text('鸡你太美')
          .fontSize(40)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Red)
      }

      Row({ space: 20 }) {
        Column() {
          Image($r('app.media.icon'))
            .width('450px')
            .height('450px')
            .borderWidth(1)
            .objectFit(ImageFit.Fill)
          Text('宽高:450px Fill')
        }

        Column() {
          Image($r('app.media.icon'))
            .width('150vp')
            .height('150vp')
            .borderWidth(1)
            .objectFit(ImageFit.Cover)
          Text('宽高:150vp Cover')
        }
      }

      Row({space:20}){
        Button('按钮', { type: ButtonType.Normal, stateEffect: true })
          .borderRadius(10)
          .fontSize(20)
          .width(100)
          .height(30)
          .backgroundColor(Color.Orange)
          .onClick(() => {
            console.log('OMG')
          })
      }

      Column({space:20}){
        Row(){
          Progress({ value: this.begin, total: this.end, type: ProgressType.Ring })
            .width(50)
            .height(100)
        }

        Row({space:20}){
          Button('+', { type: ButtonType.Normal, stateEffect: true })
            .borderRadius(20)
            .fontSize(18)
            .width(80)
            .height(30)
            .backgroundColor(Color.Black)
            .onClick(()=>{
              this.begin += 10
              if(this.begin == 100) {
                this.begin = 0
              }
            })

          Button('-', { type: ButtonType.Normal, stateEffect: true })
            .borderRadius(20)
            .borderColor(Color.Black)
            .fontSize(18)
            .fontColor(Color.White)
            .width(80)
            .height(30)
            .backgroundColor(Color.Black)
            .onClick(()=>{
              this.begin -= 10
              if(this.begin < 0) {
                this.begin = 0
              }
            })
        }
      }
    }.width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)

  }
}

function infiniteLoop(): void {
  while (true) {
    if(this.begin < 100){
      this.begin--
    }else if(this.begin == 100){
      this.begin = 0
    }
  }
}
