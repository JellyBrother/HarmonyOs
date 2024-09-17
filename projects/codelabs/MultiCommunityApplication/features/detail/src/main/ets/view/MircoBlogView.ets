/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { CardItemInterface, BreakpointConstants as Breakpoint, CommonConstants as BaseCommon } from '@ohos/base';
import { CardItem } from '../viewmodel/CardViewModel';
import { CommonConstants as Common } from '../constants/CommonConstants';

interface ImageInfo {
  width: number;
  height: number;
  componentWidth: number;
  componentHeight: number;
  loadingStatus: number;
  contentWidth: number;
  contentHeight: number;
  contentOffsetX: number;
  contentOffsetY: number;
}

@Component
export struct MircoBlogView {
  @StorageProp('currentBreakpoint') currentBreakpoint: string = Breakpoint.BREAKPOINT_LG;
  @StorageLink('isDetailPage') isDetailPage: boolean = false;
  @StorageLink('isPictureDetail') isPictureDetail: boolean = false;
  @StorageLink('pageInfos') pageInfos: NavPathStack = new NavPathStack();
  @State index: number = 0;
  @State cardItem: CardItem = new CardItem({} as CardItemInterface, 0);
  @State showPicture: boolean = true;
  @State imageWidth: string = BaseCommon.FULL_PERCENT;
  @State contentFontSize: number = Common.CONTENT_FONT_SIZE;
  @State contentFontHeight: number = Common.CONTENT_FONT_HEIGHT;
  @State scaleValue: number = 1;
  @State pinchValue: number = 1;
  @State pictureMarginTop: number = Common.PICTURE_MARGIN_TOP;
  isDarkMode: boolean = false;
  jumpDetail: () => void = () => {
  };

  jump(index: number) {
    AppStorage.setOrCreate('selectCardIndex', this.index);
    if (this.isDetailPage) {
      this.pageInfos.replacePath({ name: 'pictureDetail', param: index });
    } else {
      this.pageInfos.pushPath({ name: 'pictureDetail', param: index });
    }
  }

  build() {
    Column() {
      if (this.cardItem !== undefined) {
        Row() {
          Row() {
            Image(this.cardItem.icon)
              .width($r('app.float.blog_icon_width'))
              .aspectRatio(1)
              .borderRadius($r('app.float.blog_icon_br'))

            Column() {
              Text(this.cardItem.name)
                .fontSize($r('app.float.blog_name_fs'))
                .fontWeight(BaseCommon.FONT_WEIGHT_500)
                .height($r('app.float.blog_name_height'))
                .fontColor(this.isDarkMode ? $r('app.color.card_item_name_fc_dark') : Color.Black)

              Text(this.cardItem.authorType)
                .fontWeight(FontWeight.Normal)
                .fontSize($r('app.float.author_type_fs'))
                .fontColor(this.isDarkMode ? $r('app.color.author_type_fc_dark') : $r('app.color.author_type_color'))
                .height($r('app.float.author_type_height'))
            }
            .margin({ left: $r('app.float.blog_title_ml') })
            .justifyContent(FlexAlign.Start)
            .alignItems(HorizontalAlign.Start)
          }
          .justifyContent(FlexAlign.Start)

          Row() {
            Image(this.isDarkMode ? $r('app.media.ic_public_add_white') : $r('app.media.ic_public_add'))
              .width($r('app.float.blog_add_width'))
              .aspectRatio(1)

            Text($r('app.string.blog_follow'))
              .fontSize($r('app.float.follow_font_size'))
              .margin({ left: $r('app.float.follow_margin_left') })
              .fontColor(this.isDarkMode ? Color.White : $r('app.color.follow_font_color'))
          }
          .borderRadius($r('app.float.blog_title_follow_br'))
          .backgroundColor(this.isDarkMode ? $r('app.color.dark_mode_gbc') : $r('app.color.replay_bgc'))
          .padding({
            left: $r('app.float.blog_title_padding_left'),
            right: $r('app.float.blog_title_padding_left')
          })
          .width($r('app.float.blog_title_follow_width'))
          .height($r('app.float.blog_title_follow_height'))
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width(BaseCommon.FULL_PERCENT)
        .padding({
          top: $r('app.float.card_title_padding'),
          bottom: $r('app.float.card_title_padding')
        })

        Row() {
          Text(this.cardItem.content)
            .fontSize(`${this.contentFontSize}${Common.SUFFIX_FP}`)
            .lineHeight(`${this.contentFontHeight}${Common.SUFFIX_VP}`)
            .width(BaseCommon.FULL_PERCENT)
            .onClick(() => {
              this.jumpDetail();
            })
            .fontColor(this.isDarkMode ? $r('app.color.card_item_content_fc_dark') : Color.Black)
            .copyOption(CopyOptions.LocalDevice)
        }
        .gesture(
          PinchGesture({ fingers: Common.PINCH_GESTURE_FINGERS })
            .onActionUpdate((event?: GestureEvent) => {
              if (event && (this.isDetailPage || this.isPictureDetail)) {
                let tmp = this.pinchValue * event.scale;
                if (tmp > Common.MAX_SCALE) {
                  tmp = Common.MAX_SCALE;
                }
                if (tmp < Common.MIN_SCALE) {
                  tmp = Common.MIN_SCALE;
                }
                this.scaleValue = tmp;
                this.contentFontSize = Common.CONTENT_FONT_SIZE * this.scaleValue;
                this.contentFontHeight = Common.CONTENT_FONT_HEIGHT * this.scaleValue;
                this.pictureMarginTop = Common.PICTURE_MARGIN_TOP * (this.scaleValue > 1 ? this.scaleValue : 1);
              }
            })
            .onActionEnd(() => {
              this.pinchValue = this.scaleValue;
            })
        )

        if (this.showPicture) {
          if (this.cardItem.pictureArray.length === 1) {
            Image(this.cardItem.pictureArray[0])
              .onComplete((event: ImageInfo) => {
                if (event.width < event.height) {
                  this.imageWidth = BaseCommon.HALF_PERCENT;
                }
              })
              .width(this.imageWidth)
              .onClick(() => {
                this.jump(0);
              })
              .margin({ top: `${this.pictureMarginTop}${Common.SUFFIX_VP}` })
          } else {
            Grid() {
              ForEach(this.cardItem.pictureArray, (item: Resource, index: number) => {
                GridItem() {
                  Image(item)
                    .width(BaseCommon.FULL_PERCENT)
                    .aspectRatio(1)
                    .onClick(() => {
                      this.jump(index);
                    })
                    .autoResize(true)
                }
              }, (item: Resource, index: number) => index + JSON.stringify(item))
            }
            .columnsTemplate(Common.GRID_COLUMNS_TEMPLATE)
            .columnsGap($r('app.float.grid_gap'))
            .rowsGap($r('app.float.grid_gap'))
            .width(BaseCommon.FULL_PERCENT)
            .aspectRatio(this.getAspectRatio(this.cardItem.pictureArray.length))
            .margin({ top: `${this.pictureMarginTop}${Common.SUFFIX_VP}` })
          }
        }
      }
    }
    .alignItems(HorizontalAlign.Start)
    .flexShrink(1)
    .width(BaseCommon.FULL_PERCENT)
  }

  getAspectRatio(length: number): number {
    let rowNumber: number = (length % Common.MAX_GRID_COLUMN === 0) ? length / Common.MAX_GRID_COLUMN :
      (Math.floor(length / Common.MAX_GRID_COLUMN) + 1);
    return Common.MAX_GRID_COLUMN / rowNumber;
  }
}