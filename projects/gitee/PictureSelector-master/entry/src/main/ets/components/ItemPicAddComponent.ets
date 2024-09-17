import { SIZE_MATCH } from 'selector/src/main/ets/constants/Constants';

@Component
export struct ItemPicAddComponent {
  @Prop maxCountText: string;

  build() {
    RelativeContainer() {
      Image($r('app.media.ic_add_img_border'))
        .width(SIZE_MATCH)
        .height(SIZE_MATCH)
      Column() {
        Image($r('app.media.ic_camera'))
          .width(36)
          .height(36)
        Text(this.maxCountText)
          .fontColor($r('app.color.989898'))
          .fontSize(10)
          .textAlign(TextAlign.Center)
      }.alignRules({
        top: { anchor: "__container__", align: VerticalAlign.Top },
        left: { anchor: "__container__", align: HorizontalAlign.Start },
        right: { anchor: "__container__", align: HorizontalAlign.End },
        bottom: { anchor: "__container__", align: VerticalAlign.Bottom }
      }).justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)

    }.width(SIZE_MATCH)
    .aspectRatio(1)
  }
}