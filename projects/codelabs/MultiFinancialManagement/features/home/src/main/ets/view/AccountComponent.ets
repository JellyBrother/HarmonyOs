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

import { CommonConstants } from '@ohos/basic/Index';
import { DemandDepositComponent } from './DemandDepositComponent';
import { InvestmentComponent } from './InvestmentComponent';
import { LiabilitiesComponent } from './LiabilitiesComponent';

@Preview
@Component
export struct AccountComponent {
  @StorageLink('breakPoint') breakPoint: string = CommonConstants.BREAK_POINT_SM;
  @StorageProp('avoidArea') topHeight: number = 0;
  @StorageProp('bottom') bottom: number = 0;
  @StorageLink('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack();

  build() {
    GridRow({
      breakpoints: {
        value: CommonConstants.BREAK_POINTS_VALUE,
        reference: BreakpointsReference.WindowSize
      },
      columns: {
        sm: CommonConstants.COLUMN_SM,
        md: CommonConstants.COLUMN_MD,
        lg: CommonConstants.COLUMN_LG
      },
      direction: GridRowDirection.Row
    }) {
      GridCol({
        span: {
          sm: CommonConstants.COLUMN_SM,
          md: CommonConstants.COLUMN_MD,
          lg: CommonConstants.COLUMN_SM
        }
      }) {
        Column() {
          Row() {
            Image($r('app.media.ic_public_back'))
              .width($r('app.float.common_image_width'))
              .height($r('app.float.common_image_height'))
              .fillColor(Color.White)
              .onClick(() => {
                this.pageIndexInfos.pop();
              })
            Text($r('app.string.account_all_info'))
              .fontSize($r('app.float.account_font_size'))
              .fontColor(Color.White)
            Image($r('app.media.ic_public_more'))
              .width($r('app.float.common_image_width'))
              .height($r('app.float.common_image_height'))
              .fillColor(Color.White)
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .width(CommonConstants.FULL_WIDTH_PERCENT)
          Row() {
            Text($r('app.string.account_count'))
              .fontSize($r('app.float.account_count_size'))
              .fontColor(Color.White)
              .fontWeight(CommonConstants.FONT_WEIGHT_500)
            Image($r('app.media.ic_public_arrow_right'))
              .width($r('app.float.account_image_width'))
              .height($r('app.float.common_image_height'))
              .margin({
                left: $r('app.float.account_margin_left')
              })
              .fillColor(Color.White)
          }
          .margin({
            top: this.breakPoint === CommonConstants.BREAK_POINT_LG ?
              $r('app.float.account_margin_top_lg') : $r('app.float.account_margin_top')
          })
          Row() {
            Text($r('app.string.yesterday_earnings'))
              .fontSize($r('app.float.account_small_font_size'))
              .fontColor(Color.White)
          }
          .backgroundColor($r('app.color.five_percent_white'))
          .padding($r('app.float.account_padding'))
          .borderRadius($r('app.float.earnings_radius'))
          .margin({
            top: $r('app.float.account_margin'),
            bottom: this.breakPoint === CommonConstants.BREAK_POINT_LG ?
              $r('app.float.account_margin_bottom_lg') : $r('app.float.account_margin')
          })
          Row() {
            this.buildAccountItemInfo($r('app.string.current_period_amount'), $r('app.string.current_period'))
            this.buildAccountItemInfo($r('app.string.investment_amount'), $r('app.string.investment_name'))
            this.buildAccountItemInfo($r('app.string.remaining_due_amount'), $r('app.string.remaining_due_month'))
          }
          .width(CommonConstants.FULL_WIDTH_PERCENT)
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .height(this.breakPoint === CommonConstants.BREAK_POINT_LG ?
          CommonConstants.FULL_HEIGHT_PERCENT : $r('app.float.account_top_height'))
        .padding({
          top: $r('app.float.account_top_padding'),
          bottom: $r('app.float.account_padding_common'),
          left: $r('app.float.account_padding_common'),
          right: $r('app.float.account_padding_common')
        })
      }
      .linearGradient({
        direction: GradientDirection.Left,
        colors: [[$r('app.color.top_start'), 0], [$r('app.color.top_end'), 1]]
      })
      .padding({
        top: this.topHeight
      })
      GridCol({
        span: {
          sm: CommonConstants.COLUMN_SM,
          md: CommonConstants.COLUMN_MD,
          lg: CommonConstants.COLUMN_MD
        }
      }) {
        Scroll() {
          Column() {
            if (this.breakPoint !== CommonConstants.BREAK_POINT_LG) {
              Row() {
                Circle()
                  .fill($r('app.color.circle_color'))
                  .width($r('app.float.circle_width_height'))
                  .height($r('app.float.circle_width_height'))
                  .margin($r('app.float.account_margin'))
                Text($r('app.string.prompt_message'))
                  .fontSize($r('app.float.message_font_size'))
                  .lineHeight($r('app.float.account_lint_height'))
              }
              .width(CommonConstants.FULL_WIDTH_PERCENT)
              .backgroundColor(Color.White)
            }

            Row() {
              Text($r('app.string.current_period'))
                .fontSize($r('app.float.account_font_size'))
                .fontColor($r('app.color.current_period_color'))
                .fontWeight(CommonConstants.FONT_WEIGHT_500)
            }
            .width(CommonConstants.FULL_WIDTH_PERCENT)
            .justifyContent(this.breakPoint === CommonConstants.BREAK_POINT_LG ? FlexAlign.Start : FlexAlign.Center)
            .margin({
              top: $r('app.float.margin_common'),
              bottom: $r('app.float.current_period_margin')
            })
            .padding({
              left: $r('app.float.current_period_padding')
            })

            DemandDepositComponent({ breakPoint: this.breakPoint })
            if (this.breakPoint === CommonConstants.BREAK_POINT_LG) {
              Row() {
                Circle()
                  .fill($r('app.color.circle_color'))
                  .width($r('app.float.circle_width_height'))
                  .height($r('app.float.circle_width_height'))
                  .margin($r('app.float.account_margin'))
                Text($r('app.string.prompt_message'))
                  .fontSize($r('app.float.message_font_size'))
                  .lineHeight($r('app.float.account_lint_height'))
              }
              .width(CommonConstants.FULL_WIDTH_PERCENT)
              .backgroundColor(Color.White)
              .borderRadius($r('app.float.common_radius'))
            }
            Row() {
              Text($r('app.string.investment_name'))
                .fontSize($r('app.float.account_font_size'))
                .fontColor($r('app.color.investment_name'))
                .fontWeight(CommonConstants.FONT_WEIGHT_500)
            }
            .width(CommonConstants.FULL_WIDTH_PERCENT)
            .justifyContent(this.breakPoint === CommonConstants.BREAK_POINT_LG ? FlexAlign.Start : FlexAlign.Center)
            .margin({
              top: $r('app.float.account_margin'),
              bottom: $r('app.float.current_period_margin')
            })
            .padding({
              left: $r('app.float.current_period_padding')
            })

            InvestmentComponent({ breakPoint: this.breakPoint })
            Row() {
              Text($r('app.string.liabilities_name'))
                .fontSize($r('app.float.account_font_size'))
                .fontColor($r('app.color.liabilities_name'))
                .fontWeight(CommonConstants.FONT_WEIGHT_500)
            }
            .width(CommonConstants.FULL_WIDTH_PERCENT)
            .justifyContent(this.breakPoint === CommonConstants.BREAK_POINT_LG ? FlexAlign.Start : FlexAlign.Center)
            .margin({
              top: $r('app.float.margin_common'),
              bottom: $r('app.float.current_period_margin')
            })
            .padding({
              left: $r('app.float.current_period_padding')
            })

            LiabilitiesComponent({ breakPoint: this.breakPoint })
          }
          .justifyContent(FlexAlign.Start)
        }
        .padding({
          left: this.breakPoint === CommonConstants.BREAK_POINT_LG ? $r('app.float.account_content_padding') : 0,
          right: this.breakPoint === CommonConstants.BREAK_POINT_LG ? $r('app.float.account_content_padding') : 0
        })
        .scrollBar(BarState.Off)
      }
      .backgroundColor($r('app.color.account_background'))
      .padding({
        bottom: this.bottom
      })
    }
    .backgroundColor($r('app.color.account_background'))
  }

  @Builder
  buildAccountItemInfo(amount: ResourceStr, name: ResourceStr) {
    Column() {
      Text(amount)
        .fontSize($r('app.float.amount_font_size'))
        .fontColor(Color.White)
        .fontWeight(CommonConstants.FONT_WEIGHT_500);
      Text(name)
        .fontSize($r('app.float.account_small_font_size'))
        .fontColor(Color.White)
        .opacity(0.6)
        .margin({
          top: $r('app.float.amount_margin')
        })
    }
  }
}