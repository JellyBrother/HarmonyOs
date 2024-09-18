//自定义组件
import { router } from '@kit.ArkUI'
import { JSON } from '@kit.ArkTS'

@Component
export  struct  Header {
  private title: ResourceStr = ''
@State parms:object =   router.getParams()


  build() {

    Row(){

      Text('<')
        .fontSize(25)
        .width(60)
        .fontColor('#F255')
        .onClick(()=>{

          //返回前警告提示
          router.showAlertBeforeBackPage({
            message:'来都来了,这就想走?'
          })

          router.back()
        })

      if(this.parms && this.title){
        //[''] 获取没有的数学  会undefind
        // Text( this.parms['id'] + '.' + this.parms['adddd'] + '.'+ this.title)
        Text(`${this.parms['id']} . ${this.title}`)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor('#F36')
      }



      Blank()
      // Text('O')
      //   .fontSize(30)
      //   .fontColor('#F36')

    }
    .width('100%')
    .height(30)
  }
}
