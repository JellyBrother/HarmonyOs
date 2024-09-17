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
export struct InvestmentComponent {
  @Prop breakPoint: string = CommonConstants.BREAK_POINT_SM;

  build() {
    Flex({
      direction: this.breakPoint === CommonConstants.BREAK_POINT_SM ? FlexDirection.Column : FlexDirection.Row
    }) {
      Column() {
        Row() {
          Row() {
            Text($r('app.string.investment_wealth'))
              .buildFontSixteen()
              .fontWeight(CommonConstants.FONT_WEIGHT_500)
            this.buildImageUpwards()
          }
          Row() {
            if (this.breakPoint !== CommonConstants.BREAK_POINT_LG) {
              Text($r('app.string.investment_wealth_count'))
                .buildFontSixteen()
                .fontWeight(CommonConstants.FONT_WEIGHT_500)
            }
            this.buildImageArrowRight()
          }
        }
        .buildDemandRowStyles()
        if (this.breakPoint === CommonConstants.BREAK_POINT_LG) {
          Row() {
            Text($r('app.string.investment_wealth_count'))
              .fontSize($r('app.float.account_big_font'))
              .lineHeight($r('app.float.common_line_height'))
              .fontWeight(CommonConstants.FONT_WEIGHT_500)
          }
          .width(CommonConstants.FULL_WIDTH_PERCENT)
          .justifyContent(FlexAlign.Start)
          .margin({
            bottom: '40vp'
          })
        }
        Row() {
          Text($r('app.string.half_year_treasure'))
            .fontSize($r('app.float.amount_font_size'))
            .lineHeight($r('app.float.common_line_height'))
            .fontWeight(this.breakPoint === CommonConstants.BREAK_POINT_LG ? CommonConstants.FONT_WEIGHT_500 : FontWeight.Normal)
          this.buildImageArrowRight()
        }
        .buildDemandRowStyles()

        Row() {
          Text() {
            Span($r('app.string.earnings_holding_positions'))
              .buildSpanFont()
              .opacity(0.6)
            Span($r('app.string.earnings_holding_positions_count'))
              .fontSize($r('app.float.amount_font_size'))
              .fontColor($r('app.color.earnings_holding_positions'))
              .fontWeight(CommonConstants.FONT_WEIGHT_500)
          }

          Text($r('app.string.investment_wealth_count'))
            .buildFontSixteen()
            .fontWeight(CommonConstants.FONT_WEIGHT_500)
        }
        .buildHalfRowHeight()

        Row() {
          Text() {
            Span($r('app.string.last_redemption_date'))
              .buildSpanFont()
              .opacity(0.6)
            Span($r('app.string.last_date'))
              .buildSpanFont()
              .opacity(0.6)
          }
          Text($r('app.string.position_amount'))
            .fontSize($r('app.float.account_small_font_size'))
            .lineHeight($r('app.float.small_line_height'))
            .opacity(0.6)
        }
        .buildHalfRowHeight()
      }
      .margin({
        right: $r('app.float.account_margin'),
        left: this.breakPoint === CommonConstants.BREAK_POINT_SM ? $r('app.float.account_margin') : 0
      })
      .padding({
        top: $r('app.float.account_item_padding_tb'),
        bottom: $r('app.float.account_item_padding_tb'),
        right: $r('app.float.account_item_padding_rl'),
        left: $r('app.float.account_item_padding_rl')
      })
      .backgroundColor(Color.White)
      .borderRadius($r('app.float.common_radius'))
      Column() {
        Row() {
          Row() {
            Text($r('app.string.fund_name'))
              .buildFontSixteen()
              .fontWeight(CommonConstants.FONT_WEIGHT_500)
            this.buildImageUpwards()
          }
          Row() {
            if (this.breakPoint !== CommonConstants.BREAK_POINT_LG) {
              Text($r('app.string.investment_wealth_count'))
                .buildFontSixteen()
                .fontWeight(CommonConstants.FONT_WEIGHT_500)
            }
            this.buildImageArrowRight()
          }
        }
        .buildDemandRowStyles()
        if (this.breakPoint === CommonConstants.BREAK_POINT_LG) {
          Row() {
            Text($r('app.string.investment_wealth_count'))
              .fontSize($r('app.float.account_big_font'))
              .lineHeight($r('app.float.common_line_height'))
              .fontWeight(CommonConstants.FONT_WEIGHT_500)
          }
          .width(CommonConstants.FULL_WIDTH_PERCENT)
          .justifyContent(FlexAlign.Start)
          .margin({
            bottom: '40vp'
          })
        }
        Row() {
          Text($r('app.string.exponent_c'))
            .fontSize($r('app.float.amount_font_size'))
            .lineHeight($r('app.float.common_line_height'))
            .fontWeight(this.breakPoint === CommonConstants.BREAK_POINT_LG ? CommonConstants.FONT_WEIGHT_500 : FontWeight.Normal)
          this.buildImageArrowRight()
        }
        .buildDemandRowStyles()
        Row() {
          Text() {
            Span($r('app.string.yesterday_earnings_exponent'))
              .buildSpanFont()
              .opacity(0.6)
            Span($r('app.string.yesterday_exponent_count'))
              .fontSize($r('app.float.amount_font_size'))
              .fontColor($r('app.color.yesterday_earnings_exponent'))
              .fontWeight(CommonConstants.FONT_WEIGHT_500)
          }
          Text($r('app.string.investment_wealth_count'))
            .buildFontSixteen()
            .fontWeight(CommonConstants.FONT_WEIGHT_500)
        }
        .buildHalfRowHeight()
        Row() {
          Text() {
            Span($r('app.string.earnings_holding_positions'))
              .buildSpanFont()
              .opacity(0.6)
            Span($r('app.string.investment_holding_count'))
              .fontSize($r('app.float.amount_font_size'))
              .fontColor($r('app.color.earnings_holding_positions'))
              .fontWeight(CommonConstants.FONT_WEIGHT_500)
          }
          Text($r('app.string.position_amount'))
            .fontSize($r('app.float.account_small_font_size'))
            .lineHeight($r('app.float.small_line_height'))
            .opacity(0.6)
        }
        .buildHalfRowHeight()
      }
      .margin({
        top: this.breakPoint === CommonConstants.BREAK_POINT_SM ? $r('app.float.investment_margin_top') : 0,
        right: this.breakPoint === CommonConstants.BREAK_POINT_SM ? $r('app.float.account_padding_common') : 0,
        left: this.breakPoint === CommonConstants.BREAK_POINT_SM ? $r('app.float.account_padding_common') : 0
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
    .height(new BreakpointUtil({
      sm: $r('app.float.investment_flex_height_sm'),
      md: $r('app.float.investment_flex_height'),
      lg: $r('app.float.investment_flex_height_lg'),
    }).getValue(this.breakPoint))
    .margin({
      left: this.breakPoint === CommonConstants.BREAK_POINT_MD ? $r('app.float.margin_common') : 0,
      right: this.breakPoint === CommonConstants.BREAK_POINT_MD ? $r('app.float.margin_common') : 0
    })
  }

  @Builder
  buildImageUpwards() {
    Image($r('app.media.ic_public_upwards'))
      .width($r('app.float.image_account'))
      .height($r('app.float.image_account'))
      .margin({
        right: $r('app.float.current_period_margin')
      })
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
function buildHalfRowHeight() {
  .width(CommonConstants.FULL_WIDTH_PERCENT)
  .justifyContent(FlexAlign.SpaceBetween)
  .height($r('app.float.investment_row_height'))
}

@Extend(Span)
function buildSpanFont() {
  .fontSize($r('app.float.account_small_font_size'))
  .lineHeight($r('app.float.small_line_height'))
}

@Extend(Text)
function buildFontSixteen() {
  .fontSize($r('app.float.account_font_size'))
  .lineHeight($r('app.float.common_line_height'))
}

@Extend(Row)
function buildDemandRowStyles() {
  .width(CommonConstants.FULL_WIDTH_PERCENT)
  .justifyContent(FlexAlign.SpaceBetween)
  .height($r('app.float.account_common_height'))
}