/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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

import { deviceInfo } from '@kit.BasicServicesKit';
import { BreakpointConstants, BreakpointType, CommonConstants, ResourceUtil } from '@ohos/commons';
import { DetailConstants } from '../constants/DetailConstants';

@Component
export struct CustomerServiceView {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @StorageLink('topRectHeight') topRectHeight: number = 0;
  @Consume('pageInfos') pageInfos: NavPathStack;

  build() {
    Column() {
      Row() {
        NormalImage({ imageResource: $r('app.media.ic_public_back') })
          .margin({ right: $r('app.float.top_icon_right_margin') })
          .onClick(() => {
            this.pageInfos.pop();
          })
          .visibility(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM ? Visibility.Visible :
            Visibility.None)
        NormalImage({ imageResource: $r('app.media.shop_logo') })
          .margin({ right: $r('app.float.top_icon_right_margin') })
        Text(DetailConstants.CUSTOMER_SERVICE_CONTENTS[0])
          .fontSize($r('app.float.customer_service_font'))
          .lineHeight($r('app.float.customer_service_line_height'))
          .fontWeight(CommonConstants.FONT_WEIGHT_500)
        Blank()
        NormalImage({ imageResource: $r('app.media.ic_public_more') })
          .margin({ right: new BreakpointType($r('app.float.more_icon_margin_sm'), $r('app.float.more_icon_margin_md'),
            $r('app.float.more_icon_margin_lg')).getValue(this.currentBreakpoint) })
        NormalImage({ imageResource: $r('app.media.ic_public_close') })
          .onClick(() => {
            this.pageInfos.pop();
          })
          .visibility(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM ? Visibility.None :
            Visibility.Visible)
      }
      .height($r('app.float.service_shop_row_height'))
      .width(CommonConstants.FULL_PERCENT)
      .padding({
        left: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint),
        right: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint)
      })
      .margin({ top: deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[0] ?
        $r('app.float.service_shop_row_margin') : this.topRectHeight })

      Divider()
        .strokeWidth(1)
        .color(ResourceUtil.getCommonDividerColor())

      Scroll() {
        Column() {
          Row() {
            Image($r('app.media.shop_product'))
              .height(CommonConstants.FULL_PERCENT)
              .aspectRatio(1)

            Column() {
              Text(DetailConstants.CUSTOMER_SERVICE_CONTENTS[4])
                .fontSize($r('app.float.service_card_font_3'))
                .lineHeight($r('app.float.service_card_line_3'))
                .fontWeight(FontWeight.Normal)
                .width(CommonConstants.FULL_PERCENT)
                .maxLines(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? CommonConstants.THREE :
                  CommonConstants.TWO)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .margin({ bottom: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
                  $r('app.float.service_card_margin_3_lg') : $r('app.float.service_card_margin_3') })

              Row() {
                Text(DetailConstants.CUSTOMER_SERVICE_CONTENTS[1])
                  .fontSize($r('app.float.service_card_font_1'))
                  .lineHeight(CommonConstants.FULL_PERCENT)
                  .fontWeight(CommonConstants.FONT_WEIGHT_500)
                  .fontColor($r('app.color.service_font_color'))
                  .margin({ right: $r('app.float.service_card_margin') })
                  .displayPriority(2)
                Text(DetailConstants.CUSTOMER_SERVICE_CONTENTS[2])
                  .fontSize($r('app.float.service_card_font_2'))
                  .lineHeight($r('app.float.service_card_line_2'))
                  .fontWeight(FontWeight.Normal)
                  .fontColor($r('app.color.service_card_font'))
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .decoration({
                    type: TextDecorationType.LineThrough,
                    color: $r('app.color.service_card_font')
                  })
                  .displayPriority(1)
                  .visibility(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? Visibility.Visible :
                    Visibility.None)
                Blank()
                  .displayPriority(3)
                Button(DetailConstants.CUSTOMER_SERVICE_CONTENTS[3])
                  .width(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
                    $r('app.float.service_button_width_lg') : $r('app.float.service_button_width'))
                  .height(CommonConstants.FULL_PERCENT)
                  .fontSize($r('app.float.service_button_font'))
                  .fontWeight(CommonConstants.FONT_WEIGHT_500)
                  .borderRadius(ResourceUtil.getCommonBorderRadius()[5])
                  .backgroundColor($r('app.color.service_font_color'))
                  .displayPriority(3)
              }
              .width(CommonConstants.FULL_PERCENT)
              .height($r('app.float.service_card_price_height'))
            }
            .layoutWeight(1)
            .height(CommonConstants.FULL_PERCENT)
            .padding({
              top: $r('app.float.service_card_padding_top'),
              bottom: $r('app.float.service_card_padding_bottom'),
              left: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
                $r('app.float.service_card_padding_left_lg') : 0,
              right: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
                $r('app.float.service_card_padding_right_lg') : $r('app.float.service_card_padding_right')
            })
          }
          .height($r('app.float.service_card_height'))
          .width((CommonConstants.FULL_PERCENT))
          .borderRadius(ResourceUtil.getCommonBorderRadius()[4])
          .backgroundColor(Color.White)

          MessageView({
            messageContent: DetailConstants.CUSTOMER_SERVICE_CONTENTS[5],
            isReceiving: false,
            isSameSender: false
          })
          MessageView({
            messageContent: DetailConstants.CUSTOMER_SERVICE_CONTENTS[6],
            isReceiving: true,
            isSameSender: false
          })
          MessageView({
            messageContent: DetailConstants.CUSTOMER_SERVICE_CONTENTS[7],
            isReceiving: true,
            isSameSender: true
          })
        }
        .width(CommonConstants.FULL_PERCENT)
        .padding({
          top: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM ? $r('app.float.service_padding_top_sm') :
            $r('app.float.service_padding_top'),
          bottom: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM ? $r('app.float.service_padding_top_sm') :
            $r('app.float.service_padding_top'),
          left: $r('app.float.service_padding_top_sm'),
          right: $r('app.float.service_padding_top_sm')
        })
      }
      .scrollBar(BarState.Off)
      .align(Alignment.Top)
      .layoutWeight(1)
      .width(CommonConstants.FULL_PERCENT)

      Divider()
        .strokeWidth(1)
        .color(ResourceUtil.getCommonDividerColor())

      Row() {
        NormalImage({ imageResource: $r('app.media.ic_public_voice') })
          .margin({ right: new BreakpointType($r('app.float.service_util_right_margin_sm'),
            $r('app.float.service_util_right_margin_md'), $r('app.float.service_util_right_margin_lg'))
            .getValue(this.currentBreakpoint) })
        TextInput()
          .height($r('app.float.text_input_height'))
          .layoutWeight(1)
          .margin({ right: new BreakpointType($r('app.float.service_util_right_margin_sm'),
            $r('app.float.service_util_right_margin_md'), $r('app.float.service_util_right_margin_lg'))
            .getValue(this.currentBreakpoint) })
        NormalImage({ imageResource: $r('app.media.ic_public_emoji') })
          .margin({ right: new BreakpointType($r('app.float.service_util_right_margin_sm'),
            $r('app.float.service_util_right_margin_md'), $r('app.float.service_util_right_margin_lg'))
            .getValue(this.currentBreakpoint) })
        NormalImage({ imageResource: $r('app.media.ic_public_add') })
      }
      .height(deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[0] ? CommonConstants.TAB_BAR_HEIGHT :
        CommonConstants.TAB_BAR_HEIGHT + CommonConstants.BOTTOM_RECT_HEIGHT)
      .width(CommonConstants.FULL_PERCENT)
      .padding({
        left: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint),
        right: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint),
        bottom: deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[0] ? 0 : CommonConstants.BOTTOM_RECT_HEIGHT
      })
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(CommonConstants.FULL_PERCENT)
  }
}

@Component
struct NormalImage {
  private imageResource: Resource = $r('app.media.ic_public_back');

  build() {
    Image(this.imageResource)
      .width(ResourceUtil.getCommonImgSize()[0])
      .height(ResourceUtil.getCommonImgSize()[0])
  }
}

@Component
struct MessageView {
  private messageContent: string = '';
  private isReceiving: boolean = false;
  private isSameSender: boolean = false;

  build() {
    Flex({
      direction: this.isReceiving ? FlexDirection.Row : FlexDirection.RowReverse,
      justifyContent: FlexAlign.Start,
      alignItems: ItemAlign.Start
    }) {
      Image(this.isReceiving ? $r('app.media.shop_logo') : $r('app.media.user_profile'))
        .width(ResourceUtil.getCommonImgSize()[2])
        .height(ResourceUtil.getCommonImgSize()[2])
        .objectFit(ImageFit.Contain)
        .visibility(this.isSameSender ? Visibility.None : Visibility.Visible)
        .margin({
          left: !this.isReceiving ? $r('app.float.message_image_margin') : 0,
          right: this.isReceiving ? $r('app.float.message_image_margin') : 0
        })
      Row() {
        Text(this.messageContent)
          .fontSize($r('app.float.message_content_font'))
          .lineHeight($r('app.float.message_content_line'))
          .fontWeight(FontWeight.Normal)
      }
      .borderRadius(ResourceUtil.getCommonBorderRadius()[3])
      .padding({
        top: $r('app.float.message_padding_top_bottom'),
        bottom: $r('app.float.message_padding_top_bottom'),
        left: $r('app.float.message_padding_left_right'),
        right: $r('app.float.message_padding_left_right')
      })
      .backgroundColor(this.isReceiving ? Color.White : $r('app.color.message_user_background'))
    }
    .margin({ top: this.isSameSender ? $r('app.float.message_flex_margin_same') : $r('app.float.message_flex_margin') })
    .width(CommonConstants.FULL_PERCENT)
    .padding({
      left: !this.isReceiving ? $r('app.float.message_flex_padding') : (this.isSameSender ?
        $r('app.float.message_flex_padding') : 0),
      right: this.isReceiving ? $r('app.float.message_flex_padding') : (this.isSameSender ?
        $r('app.float.message_flex_padding') : 0)
    })
  }
}