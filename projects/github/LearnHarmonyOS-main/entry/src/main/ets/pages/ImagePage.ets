import App from '@system.app';
import router from '@ohos.router';
import {Header} from '../../Component/CommonCOmponent'

class RouterInfo{
  url: string
  title:string

  constructor(url:string,title:string) {
    this.url = url;
    this.title = title;
  }

}






@Entry
@Component
struct ImagePage {

  @State message: string = '页面列表';
  @State time:number = 0
  @State imagewidth:number = 250;


  build() {
    Column(){

      Header({title:'图片放大缩小案例'})
        .margin(20)

      Row(){
        Image($r('app.media.app_icon'))
          .width(this.imagewidth)
          .interpolation(ImageInterpolation.High)
      }
      .width('100%')
      .height(400)
      .justifyContent(FlexAlign.Center)


      Row(){
        Text($r('app.string.width_label'))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)

        TextInput({placeholder:'请输入图片宽度',text:this.imagewidth.toFixed(0)})
          .width(250)
            // .backgroundColor('#36D')
          .type(InputType.Number)
          .onChange( (value:string) => {
            //输入框默认返回字符串  需要转换成数字类型
            this.imagewidth = parseInt(value)

          } )
      }
      .width('100%')
      .padding({left:20,right:20})
      .justifyContent(FlexAlign.SpaceBetween)

      //分割线
      Divider()
        .width('90%')


      Row(){
        Button('缩小')
          .width(80)
          .fontSize(20)
          .onClick(() =>{
            if(this.imagewidth >=10){
              this.imagewidth -= 10
            }
          })
        Button('放大')
          .width(80)
          .fontSize(20)
          .onClick(() =>{
            if(this.imagewidth < 500){
              this.imagewidth += 10
            }
          })
      }
      .width('100%')
      .margin({top:20,bottom:35})
      .justifyContent(FlexAlign.SpaceEvenly)

      Slider({
        min:100,
        max:400,
        value:this.imagewidth,
        step:10,
        style:SliderStyle.OutSet,
        direction:Axis.Horizontal,
        reverse:false,
      })
        .blockColor('#36d')
        .width('90%')
        .trackThickness(8)
        .showTips(true)
        .onChange((value) => {
          this.imagewidth = value
        })

    }
    .width('100%')
    .height('100%')



  }
}