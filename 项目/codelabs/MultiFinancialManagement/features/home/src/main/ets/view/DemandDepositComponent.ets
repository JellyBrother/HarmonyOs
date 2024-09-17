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
import { HomeConstants } from '../constants/HomeConstants';

@Component
export struct DemandDepositComponent {
  @Prop breakPoint: string = CommonConstants.BREAK_POINT_SM;

  build() {
    if (this.breakPoint === CommonConstants.BREAK_POINT_LG) {
      Row({ space: HomeConstants.ROW_SPACE }) {
        Column() {
          Row() {
            this.buildSavingCard()
            this.buildImageArrowRight()
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .height($r('app.float.account_common_height'))

          Text($r('app.string.save_card_account'))
            .fontSize($r('app.float.account_big_font'))
            .lineHeight($r('app.float.account_lint_height'))
            .fontWeight(CommonConstants.FONT_WEIGHT_500)
        }
        .buildColumnItemStyles()

        Column() {
          Row() {
            Text($r('app.string.current_deposit'))
              .fontSize($r('app.float.account_font_size'))
              .lineHeight($r('app.float.common_line_height'))
            this.buildImageArrowRight()
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .height($r('app.float.account_common_height'))
          Text($r('app.string.current_deposit_count'))
            .fontSize($r('app.float.account_big_font'))
            .lineHeight($r('app.float.common_line_height'))
            .fontWeight(CommonConstants.FONT_WEIGHT_500)
        }
        .buildColumnItemStyles()
        Column() {
          Row() {
            Text($r('app.string.day_day_treasure'))
              .fontSize($r('app.float.account_font_size'))
              .lineHeight($r('app.float.common_line_height'))
            this.buildImageArrowRight()
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .height($r('app.float.account_common_height'))
          Column() {
            Text($r('app.string.day_day_count'))
              .fontSize($r('app.float.account_big_font'))
              .lineHeight($r('app.float.common_line_height'))
              .fontWeight(CommonConstants.FONT_WEIGHT_500)
            Text($r('app.string.yesterday_earnings_day'))
              .fontSize($r('app.float.account_small_font_size'))
              .lineHeight($r('app.float.small_line_height'))
              .opacity(0.6)
          }
          .alignItems(HorizontalAlign.Start)
        }
        .buildColumnItemStyles()
      }
      .backgroundColor($r('app.color.account_background'))
      .width(CommonConstants.FULL_WIDTH_PERCENT)
      .margin({
        bottom: $r('app.float.margin_common')
      })
      .justifyContent(FlexAlign.SpaceBetween)
    } else {
      Row() {
        Column() {
          Row() {
            this.buildSavingCard()

            Row() {
              Text($r('app.string.save_card_account'))
                .fontSize($r('app.float.account_font_size'))
                .lineHeight($r('app.float.account_lint_height'))
                .fontWeight(CommonConstants.FONT_WEIGHT_500)
              this.buildImageArrowRight()
            }
          }
          .buildDemandRowStyles()

          Flex({
            direction: this.breakPoint === CommonConstants.BREAK_POINT_SM ? FlexDirection.Column : FlexDirection.Row
          }) {
            Row() {
              Text($r('app.string.current_deposit'))
                .fontSize($r('app.float.amount_font_size'))
                .lineHeight($r('app.float.small_line_height'))
              Row() {
                Text($r('app.string.day_day_count'))
                  .fontSize($r('app.float.account_font_size'))
                  .lineHeight($r('app.float.account_lint_height'))
                  .fontWeight(CommonConstants.FONT_WEIGHT_500)
                this.buildImageArrowRight()
              }
            }
            .buildDemandRowStyles()

            if (this.breakPoint === CommonConstants.BREAK_POINT_MD) {
              Divider()
                .vertical(true)
                .height($r('app.float.divider_height'))
                .width($r('app.float.divider_width'))
                .color($r('app.color.divider_color'))
                .margin({
                  left: $r('app.float.divider_margin'),
                  right: $r('app.float.divider_margin')
                })
            }
            Row() {
              Text($r('app.string.day_day_treasure'))
                .fontSize($r('app.float.amount_font_size'))
                .lineHeight($r('app.float.small_line_height'))
              Row() {
                Column() {
                  Text($r('app.string.day_day_count'))
                    .fontSize($r('app.float.account_font_size'))
                    .lineHeight($r('app.float.account_lint_height'))
                    .fontWeight(CommonConstants.FONT_WEIGHT_500)
                  Text($r('app.string.yesterday_earnings_day'))
                    .fontSize($r('app.float.account_small_font_size'))
                    .lineHeight($r('app.float.small_line_height'))
                    .opacity(0.6)
                }

                this.buildImageArrowRight()
              }
            }
            .buildDemandRowStyles()
          }
          .flexBasis(this.breakPoint === CommonConstants.BREAK_POINT_SM ?
            HomeConstants.DEMAND_FLEX_HEIGHT_SM : HomeConstants.DEMAND_FLEX_HEIGHT)
        }
      }
      .margin({
        right: this.breakPoint === CommonConstants.BREAK_POINT_MD ?
          $r('app.float.margin_common') : $r('app.float.account_padding_common'),
        left: this.breakPoint === CommonConstants.BREAK_POINT_MD ?
          $r('app.float.margin_common') : $r('app.float.account_padding_common')
      })
      .padding({
        top: $r('app.float.account_item_padding_tb'),
        bottom: $r('app.float.account_item_padding_tb'),
        right: $r('app.float.account_item_padding_rl'),
        left: $r('app.float.account_item_padding_rl')
      })
      .backgroundColor(Color.White)
      .borderRadius($r('app.float.common_radius'))
      .justifyContent(FlexAlign.SpaceBetween)
    }
  }

  @Builder
  buildSavingCard() {
    Row() {
      Text($r('app.string.saving_card'))
        .fontSize($r('app.float.account_font_size'))
        .lineHeight($r('app.float.common_line_height'))
        .fontWeight(CommonConstants.FONT_WEIGHT_500);
      this.buildImageUpwards();
    }
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
function buildDemandRowStyles() {
  .width(CommonConstants.FULL_WIDTH_PERCENT)
  .justifyContent(FlexAlign.SpaceBetween)
  .height($r('app.float.account_common_height'))
}

@Extend(Column)
function buildColumnItemStyles() {
  .width(HomeConstants.DEMAND_LG_WIDTH)
  .backgroundColor(Color.White)
  .alignItems(HorizontalAlign.Start)
  .height($r('app.float.column_item_height'))
  .padding($r('app.float.account_padding_common'))
  .borderRadius($r('app.float.common_radius'))
}
