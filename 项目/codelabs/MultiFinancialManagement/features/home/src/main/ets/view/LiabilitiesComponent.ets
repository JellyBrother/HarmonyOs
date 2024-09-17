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

import { BreakpointUtil, CommonConstants } from '@ohos/basic/Index';

@Component
export struct LiabilitiesComponent {
  @Prop breakPoint: string = CommonConstants.BREAK_POINT_SM;

  build() {
    Column() {
      Row() {
        Text($r('app.string.credit_card_account'))
          .fontSize($r('app.float.account_font_size'))
          .lineHeight($r('app.float.common_line_height'))
          .fontWeight(CommonConstants.FONT_WEIGHT_500)
        Image($r('app.media.ic_public_more_list'))
          .width($r('app.float.common_image_width'))
          .height($r('app.float.common_image_height'))
      }
      .buildRowStyles()

      Flex({
        direction: this.breakPoint === CommonConstants.BREAK_POINT_SM ? FlexDirection.Column : FlexDirection.Row
      }) {
        if (this.breakPoint !== CommonConstants.BREAK_POINT_SM) {
          Column() {
            Row() {
              Text($r('app.string.remaining_available_count'))
                .fontSize(this.breakPoint === CommonConstants.BREAK_POINT_LG ?
                $r('app.float.account_big_font') : $r('app.float.account_font_size'))
                .lineHeight($r('app.float.common_line_height'))
                .fontWeight(CommonConstants.FONT_WEIGHT_500)
              this.buildImageArrowRight()
            }
            .width(CommonConstants.FULL_WIDTH_PERCENT)
            .justifyContent(FlexAlign.SpaceBetween)
            Row() {
              Text($r('app.string.remaining_available_amount'))
                .fontSize($r('app.float.account_small_font_size'))
                .lineHeight($r('app.float.small_line_height'))
                .opacity(0.6)
            }
            .width(CommonConstants.FULL_WIDTH_PERCENT)
            .justifyContent(FlexAlign.Start)
          }
          Divider()
            .vertical(true)
            .height($r('app.float.liabilities_divider_height'))
            .width($r('app.float.divider_width'))
            .color($r('app.color.divider_color'))
            .margin({
              left: $r('app.float.divider_margin'),
              right: $r('app.float.divider_margin')
            })
          Column() {
            Row() {
              Text($r('app.string.remaining_due_count'))
                .fontSize(this.breakPoint === CommonConstants.BREAK_POINT_LG ?
                $r('app.float.account_big_font') : $r('app.float.account_font_size'))
                .lineHeight($r('app.float.common_line_height'))
                .fontWeight(CommonConstants.FONT_WEIGHT_500)
              this.buildImageArrowRight()
            }
            .width(CommonConstants.FULL_WIDTH_PERCENT)
            .justifyContent(FlexAlign.SpaceBetween)
            Row() {
              Text($r('app.string.remaining_due'))
                .fontSize($r('app.float.amount_font_size'))
                .lineHeight($r('app.float.small_line_height'))
                .opacity(0.6)
            }
            .width(CommonConstants.FULL_WIDTH_PERCENT)
            .justifyContent(FlexAlign.Start)
          }
        } else {
          Row() {
            Text() {
              Span($r('app.string.remaining_available_amount'))
                .fontSize($r('app.float.account_small_font_size'))
                .lineHeight($r('app.float.small_line_height'))
                .opacity(0.6)
              Span($r('app.string.remaining_available_count'))
                .fontSize($r('app.float.account_font_size'))
                .lineHeight($r('app.float.small_line_height'))
                .fontWeight(CommonConstants.FONT_WEIGHT_500)
            }
            this.buildImageArrowRight()
          }
          .buildRowStyles()

          Row() {
            Text() {
              Span($r('app.string.remaining_due'))
                .fontSize($r('app.float.amount_font_size'))
                .lineHeight($r('app.float.small_line_height'))
                .opacity(0.6)
              Span($r('app.string.remaining_due_count'))
                .fontSize($r('app.float.account_font_size'))
                .lineHeight($r('app.float.common_line_height'))
                .fontWeight(CommonConstants.FONT_WEIGHT_500)
            }
            this.buildImageArrowRight()
          }
          .buildRowStyles()
        }
      }
      .height($r('app.float.liabilities_item_height'))
    }
    .height($r('app.float.liabilities_height'))
    .margin({
      right: new BreakpointUtil({
        sm: $r('app.float.account_margin'),
        md: $r('app.float.margin_common'),
        lg: 0
      }).getValue(this.breakPoint),
      left: new BreakpointUtil({
        sm: $r('app.float.account_margin'),
        md: $r('app.float.margin_common'),
        lg: 0
      }).getValue(this.breakPoint)
    })
    .padding({
      top: $r('app.float.account_item_padding_tb'),
      bottom: $r('app.float.account_item_padding_tb'),
      right: $r('app.float.account_item_padding_rl'),
      left: $r('app.float.account_item_padding_rl')
    })
    .backgroundColor(Color.White)
    .borderRadius($r('app.float.common_radius'))
  }

  @Builder
  buildImageArrowRight() {
    Image($r('app.media.ic_public_arrow_right'))
      .width($r('app.float.image_arrow'))
      .height($r('app.float.common_image_height'))
      .fillColor($r('app.color.image_arrow'))
      .margin({
        left:$r('app.float.image_arrow_margin')
      })
  }
}

@Extend(Row)
function buildRowStyles() {
  .width(CommonConstants.FULL_WIDTH_PERCENT)
  .justifyContent(FlexAlign.SpaceBetween)
  .height($r('app.float.account_common_height'))
}
