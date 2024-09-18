
@Component
export default struct item {
  @Prop iconURL: string;
  @Prop text: string;
  @Prop showDivider: boolean;

  build() {
    Column() {
      Flex({
        justifyContent: FlexAlign.Center,
        alignItems: ItemAlign.Center
      }) {
        Image($rawfile(this.iconURL)).width('80px').height('80px')
          .margin({right: '40px'})

        Row() {
          Text(this.text)
            .fontSize('50px')
        }.flexBasis('600px').flexGrow(2)

        Image($r("app.media.ic_arrow_right")).width('50px')
      }.width('100%').margin('10px 16px')

      if(this.showDivider) {
        Divider().width('100%').height('1px').color('#000000').opacity(0.5)
      }
    }.width('90%').margin({left: '20px', right: '30px', top: '10px', bottom: '10px'})
  }
}
