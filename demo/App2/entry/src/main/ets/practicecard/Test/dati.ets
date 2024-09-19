@Entry
@Component
struct Index {
  @State p_begin:number = 0;
  @State p_end:number = 100;

  build() {
    Column({space:50}){
      Column({space:20}){
        Row(){
          Image($r('app.media.ic_accuracy'))
            .img_style()

          Text('准确率').fontSize(18).padding({left:15})

          Blank()

          Row(){
            Text('0%').fontSize(18)
          }
          .width(100)
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')

        Row(){
          Image($r('app.media.ic_progress'))
            .img_style()

          Text('进度').fontSize(18).padding({left:15})

          Blank()

          Progress({value:this.p_begin, total:this.p_end})
            .width(100)
        }
        .width('100%')

        Row(){
          Image($r('app.media.ic_count'))
            .img_style()

          Text('个数').fontSize(18).padding({left:15})

          Blank()

          Row(){
            Text('0').fontSize(18)
          }
            .width(100)
            .justifyContent(FlexAlign.Center)
            .borderRadius(20)
            .backgroundColor(Color.Gray)
        }
        .width('100%')

        Row(){
          Image($r('app.media.ic_timer'))
            .img_style()

          Text('用时').fontSize(18).padding({left:15})

          Blank()

          Row(){
            Text('00:00:00:00').fontSize(18)
          }
          .width(100)
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
      }
      .width('85%')

      Column({space:10}){
        Text('School')
          .fontSize(50)
          .fontWeight(FontWeight.Bolder)

        Text('School  School  School')
          .fontSize(20)
          .fontColor(Color.Green)
      }
        .width('85%')

      Column({space:20}){
        Button('第三人民医院',{type:ButtonType.Capsule})
          .but_sty()
        Button('厕所',{type:ButtonType.Capsule})
          .but_sty()
        Button('垃圾场',{type:ButtonType.Capsule})
          .but_sty()
        Button('学校',{type:ButtonType.Capsule})
          .but_sty()
      }

      Column({space:30}){
        Flex({
          direction: FlexDirection.Row,
          justifyContent: FlexAlign.SpaceAround})
        {
            Button('开始测试',{type:ButtonType.Capsule})
            .width(100)
            .fontColor(Color.Black)
            .backgroundColor(Color.White)
            .borderWidth(2)

            Button('结束测试',{type:ButtonType.Capsule})
              .width(100)
              .fontColor(Color.White)
              .backgroundColor(Color.Black)
              .borderWidth(2)
        }

      }
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundImage($r('app.media.splash_bg'))
  }
}

@Styles function img_style(){
  .width(20)
  .height(20)
}

@Extend(Button) function  but_sty(){
  .backgroundColor(Color.White)
  .fontColor(Color.Black)
  .fontSize(20)
  .width(200)
}

