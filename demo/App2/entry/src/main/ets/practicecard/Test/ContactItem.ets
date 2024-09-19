import {Person} from './model'

@Component
export struct ContactItem{
  @ObjectLink person:Person;
  @State isExpand:boolean=false;
  @Link @Watch('ExpandChange') currentExpandId:number;
  @Prop isSelect:boolean;
  @Link isSelectIdList:number[];

  ExpandChange(){
    if (this.currentExpandId != this.person.id) {
      this.isExpand = false
    }
  }

  build(){
    Column(){
      Row({space:10}){
        // 复选框
        if (this.isSelect){
          Toggle({type:ToggleType.Checkbox, isOn:false})
            .selectedColor(Color.Red)
            .onChange(value=>{
              if (value) {
                this.isSelectIdList.push(this.person.id)
              }else{
                let index = this.isSelectIdList.indexOf(this.person.id)
                this.isSelectIdList.splice(index,1)
              }
            })
        }

        // 头像
        Image($r('app.media.ic_star_red'))
          .width(40)
          .height(40)
          .borderRadius(20)
        Text(this.person.name).fontSize(20)
        Blank()
        Image(this.person.isStar?$r('app.media.ic_star_red'):$r('app.media.ic_star_red'))
          .width(40)
          .height(40)
          .onClick(()=>{
            this.person.isStar = !this.person.isStar
          })
      }.width('100%').height(50)


      if(this.isExpand){
        Divider()
          .color(Color.Black).strokeWidth(2)

        Text('手机号码：'+this.person.phone).textAlign(TextAlign.Start).height(30).width('100%')
      }
    }
    .width('100%')
    .padding(10)
    .backgroundColor(Color.Pink)
    .borderRadius(20)
    .onClick(()=>{
      this.isExpand = !this.isExpand
      this.currentExpandId = this.person.id
    })
  }
}

