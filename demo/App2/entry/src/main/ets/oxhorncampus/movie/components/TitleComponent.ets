
@Component
export default struct TitleComponent{
  @Prop title:string;
  @Prop showMarginBottom:boolean;

  build(){
    Row(){
      Divider()
        .height(20)
        .width(5)
        .backgroundColor('#2196f3')
        .margin({right:10})
      Text(this.title).fontSize(15)
    }.alignSelf(ItemAlign.Start)
    .margin({bottom:this.showMarginBottom ? 15 : 0})
  }
}