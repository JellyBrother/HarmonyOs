@Entry
@Component
struct WidgetCard {
  /*
   * The display priority value is 1.
   */
  readonly DISPLAY_PRIORITY_ONE: number = 1;
  /*
   * The display priority value is 2.
   */
  readonly DISPLAY_PRIORITY_TOW: number = 2;
  /*
   * The flex grow value is 1.
   */
  readonly FLEX_GROW_VALUE: number = 1;
  /*
   * The width or height full percentage setting.
   */
  readonly FULL_PERCENT: string = '100%';
  /*
   * The height of image.
   */
  readonly IMAGE_HEIGHT: string = '58%';
  /*
   * The action type.
   */
  readonly ACTION_TYPE: string = 'router';
  /*
   * The ability name.
  */
  readonly ABILITY_NAME: string = 'EntryAbility';
  /*
   * The message.
   */
  readonly MESSAGE: string = 'add detail';
  /*
   * The layoutWeightValue.
   */
  readonly LAYOUT_WEIGHT_VALUE: number = 1;
  /*
   * The maxLinesValue.
   */
  readonly MAX_LINES_VALUE: number = 1;

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Stack({ alignContent: Alignment.BottomStart }) {
        Image($r('app.media.ic_widget'))
          .width(this.FULL_PERCENT)
          .height(this.FULL_PERCENT)

        Column() {
          Text($r('app.string.card_title'))
            .fontSize($r('app.float.card_title_font_size'))
            .width(this.FULL_PERCENT)
            .fontColor($r('app.color.title_font'))
            .fontWeight(FontWeight.Medium)
        }
        .padding($r('app.float.maximum_padding'))
        .alignItems(HorizontalAlign.Start)
      }
      .width(this.FULL_PERCENT)
      .height(this.FULL_PERCENT)
      .displayPriority(this.DISPLAY_PRIORITY_ONE)
      .flexGrow(this.FLEX_GROW_VALUE)

      Flex({ direction: FlexDirection.Column }) {
        Flex({ direction: FlexDirection.Row }) {
          Column() {
            Image($r('app.media.ic_widget'))
              .width(this.FULL_PERCENT)
              .height(this.IMAGE_HEIGHT)
              .borderRadius($r('app.float.image_border_radius'))
              .margin({ bottom: $r('app.float.image_margin_bottom') })
              .flexGrow(this.FLEX_GROW_VALUE)

            Column() {
              Text($r('app.string.card_title'))
                .fontSize($r('app.float.card_title_font_size'))
                .width(this.FULL_PERCENT)
                .fontColor($r('app.color.information_title_font'))
                .fontWeight(FontWeight.Medium)
                .maxLines(this.MAX_LINES_VALUE)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
              Text($r('app.string.introduction'))
                .fontSize($r('app.float.item_font_size'))
                .width(this.FULL_PERCENT)
                .fontColor($r('app.color.item_text_font'))
                .fontWeight(FontWeight.Regular)
                .margin({ top: $r('app.float.item_margin_top') })
                .maxLines(this.MAX_LINES_VALUE)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }
            .justifyContent(FlexAlign.Center)
            .layoutWeight(this.LAYOUT_WEIGHT_VALUE)
            .flexGrow(this.FLEX_GROW_VALUE)
          }
          .width($r('app.float.info_column_width'))
          .height(this.FULL_PERCENT)
          .flexGrow(this.FLEX_GROW_VALUE)
        }
        .backgroundColor($r('app.color.image_info_background'))
        .displayPriority(this.DISPLAY_PRIORITY_TOW)
        .flexGrow(this.FLEX_GROW_VALUE)
        .height($r('app.float.info_column_height'))
        .padding($r('app.float.info_column_padding'))
      }
    }
    .onClick(() => {
      postCardAction(this, {
        action: this.ACTION_TYPE,
        abilityName: this.ABILITY_NAME,
        params: {
          message: this.MESSAGE
        }
      });
    })
  }
}