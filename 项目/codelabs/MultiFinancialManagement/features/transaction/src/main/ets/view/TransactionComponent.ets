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

import { window } from '@kit.ArkUI';
import { CommonConstants, FundDetail } from '@ohos/basic';
import { TransactionConstants } from '../constants/TransactionConstants';

@Component
export struct TransactionComponent {
  @StorageLink('pageInfo') pageInfo: NavPathStack = new NavPathStack();
  @State indexList: number = 0;
  @StorageProp('allFund') fundInfo: FundDetail[] = [];
  @StorageProp('breakPoint') breakPoint: string = CommonConstants.BREAK_POINT_SM;

  build() {
    NavDestination() {
      Column() {
        Row() {
          Image($r('app.media.ic_public_back'))
            .width($r('app.float.common_image_width'))
            .height($r('app.float.common_image_height'))
            .onClick(() => {
              this.pageInfo.pop();
            })
          Text($r('app.string.financial_purchase'))
            .fontSize($r('app.float.title_size'))
          Image($r('app.media.ic_public_comments'))
            .width($r('app.float.common_image_width'))
            .height($r('app.float.common_image_height'))
        }
        .width(CommonConstants.FULL_WIDTH_PERCENT)
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({
          left: $r('app.float.padding_common'),
          right: $r('app.float.padding_common')
        })

        Row() {
          Text(this.fundInfo[this.indexList].name)
            .fontSize($r('app.float.fund_text_size'))
            .fontColor($r('app.color.fund_text'))
            .lineHeight($r('app.float.fund_text_height'))
            .fontWeight(CommonConstants.FONT_WEIGHT_500)

          Text(this.fundInfo[this.indexList].amplitude)
            .fontSize($r('app.float.amplitude_size'))
            .fontColor($r('app.color.amplitude_color'))
        }
        .width(CommonConstants.FULL_WIDTH_PERCENT)
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({
          left: $r('app.float.padding_common'),
          right: $r('app.float.padding_common'),
          top: $r('app.float.fund_text_padding_top')
        })

        Row({ space: TransactionConstants.ROW_SPACE }) {
          Text($r('app.string.fixed_investment'))
            .textTypeExtend()

          Text($r('app.string.fund_type'))
            .textTypeExtend()

          Text($r('app.string.risk_level'))
            .textTypeExtend()
        }
        .width(CommonConstants.FULL_WIDTH_PERCENT)
        .justifyContent(FlexAlign.Start)
        .padding({
          left: $r('app.float.padding_common'),
          right: $r('app.float.padding_common'),
          top: $r('app.float.type_padding_top'),
          bottom: $r('app.float.type_padding_bottom')
        })

        Row() {
          Text($r('app.string.transaction_account'))
            .fontSize($r('app.float.account_size'))
            .fontColor($r('app.color.account_text'))
            .lineHeight($r('app.float.account_text_height'))
            .fontWeight(CommonConstants.FONT_WEIGHT_500)
          Row() {
            Text($r('app.string.payment_account'))
              .fontSize($r('app.float.payment_size'))
              .fontColor($r('app.color.common_text'))
              .lineHeight($r('app.float.payment_text_height'))
            Image($r('app.media.ic_public_arrow_right'))
              .width($r('app.float.arrow_width'))
              .height($r('app.float.arrow_height'))
              .fillColor($r('app.color.arrow_right'))
              .margin({
                left: $r('app.float.arrow_margin_left')
              })
          }
        }
        .width(CommonConstants.FULL_WIDTH_PERCENT)
        .justifyContent(FlexAlign.SpaceBetween)
        .height($r('app.float.account_height'))
        .backgroundColor(Color.White)
        .padding({
          top: $r('app.float.account_padding_top_bottom'),
          bottom: $r('app.float.account_padding_top_bottom'),
          left: $r('app.float.padding_common'),
          right: $r('app.float.padding_common')
        })

        Row() {
          Text($r('app.string.available_balance'))
            .fontSize($r('app.float.available_size'))
            .fontColor($r('app.color.available_text'))
            .lineHeight($r('app.float.available_height'))
          Image($r('app.media.ic_about'))
            .width($r('app.float.about_image'))
            .height($r('app.float.about_image'))
            .margin({
              left: $r('app.float.about_margin_left')
            })
        }
        .width(CommonConstants.FULL_WIDTH_PERCENT)
        .justifyContent(FlexAlign.End)
        .height($r('app.float.available_row_height'))
        .padding({
          left: $r('app.float.padding_common'),
          right: $r('app.float.padding_common')
        })

        Column() {
          Row() {
            Text($r('app.string.purchase_amount'))
              .fontSize($r('app.float.purchase_size'))
              .fontColor($r('app.color.purchase_text'))
              .lineHeight($r('app.float.purchase_text_height'))
              .fontWeight(CommonConstants.FONT_WEIGHT_500)
            Text($r('app.string.transaction_rules'))
              .fontSize($r('app.float.rules_size'))
              .fontColor($r('app.color.rules_text'))
              .lineHeight($r('app.float.rules_text_height'))
              .fontWeight(CommonConstants.FONT_WEIGHT_500)
          }
          .width(CommonConstants.FULL_WIDTH_PERCENT)
          .justifyContent(FlexAlign.SpaceBetween)
          .padding({
            left: $r('app.float.padding_common'),
            right: $r('app.float.padding_common'),
          })

          Row() {
            Text($r('app.string.money_symbol'))
              .fontSize($r('app.float.symbol_size'))
            TextInput()
              .enableKeyboardOnFocus(false)
              .fontSize($r('app.float.symbol_size'))
              .backgroundColor(Color.White)
              .layoutWeight(1)
              .textAlign(TextAlign.End)
              .type(InputType.Number)
              .margin({
                left: $r('app.float.input_margin'),
                right: $r('app.float.input_margin')
              })
            Button($r('app.string.buy_all'))
              .backgroundColor($r('app.color.button_buy_background'))
              .width($r('app.float.button_buy_width'))
              .height($r('app.float.button_buy_height'))
              .fontSize($r('app.float.button_buy_size'))
              .fontColor($r('app.color.button_buy'))
              .fontWeight(CommonConstants.FONT_WEIGHT_500)
          }
          .width(CommonConstants.FULL_WIDTH_PERCENT)
          .justifyContent(FlexAlign.SpaceBetween)
          .padding({
            left: $r('app.float.padding_common'),
            right: $r('app.float.padding_common'),
          })

          Row() {
            Text($r('app.string.confirm_share_prompt', TransactionConstants.RATE_VALUE,
              TransactionConstants.RATE_MOUTH, TransactionConstants.RATE_DAY))
              .fontSize($r('app.float.confirm_size'))
              .fontColor($r('app.color.common_text'))
              .lineHeight($r('app.float.confirm_text_height'))
          }
          .width(CommonConstants.FULL_WIDTH_PERCENT)
          .justifyContent(FlexAlign.Start)
          .padding({
            top: $r('app.float.confirm_padding_top'),
            left: $r('app.float.padding_common'),
            right: $r('app.float.padding_common'),
          })
          .border({
            width: {
              top: $r('app.float.confirm_border_width')
            },
            color: $r('app.color.confirm_border')
          })
        }
        .height($r('app.float.buy_info_height'))
        .width(CommonConstants.FULL_WIDTH_PERCENT)
        .justifyContent(FlexAlign.SpaceBetween)
        .backgroundColor(Color.White)
        .padding({
          top: $r('app.float.buy_info_padding'),
          bottom: $r('app.float.buy_info_padding')
        })

        Row() {
          Text($r('app.string.recommendation_no'))
            .fontSize($r('app.float.recommendation_size'))
            .fontColor($r('app.color.recommendation_text'))
            .lineHeight($r('app.float.recommendation_text_height'))
            .fontWeight(CommonConstants.FONT_WEIGHT_500)
          TextInput({ placeholder: $r('app.string.recommendation_optional') })
            .fontSize($r('app.float.recommendation_size'))
            .backgroundColor(Color.White)
            .layoutWeight(1)
            .textAlign(TextAlign.End)
            .type(InputType.Number)
            .padding(0)
        }
        .width(CommonConstants.FULL_WIDTH_PERCENT)
        .height($r('app.float.recommendation_height'))
        .justifyContent(FlexAlign.SpaceBetween)
        .backgroundColor(Color.White)
        .padding({
          left: $r('app.float.padding_common'),
          right: $r('app.float.padding_common'),
        })
        .margin({
          top: $r('app.float.recommendation_margin'),
          bottom: $r('app.float.recommendation_margin')
        })

        Column() {
          Row() {
            Text($r('app.string.transaction_read'))
              .fontSize($r('app.float.read_size'))
              .fontColor($r('app.color.common_text'))
              .lineHeight($r('app.float.read_text_height'))
              .margin({
                right: $r('app.float.read_margin_right')
              })
            Image($r('app.media.ic_public_arrow_right'))
              .width($r('app.float.arrow_right_width'))
              .height($r('app.float.common_image_height'))
          }
          .width(CommonConstants.FULL_WIDTH_PERCENT)

          Button($r('app.string.transaction_button'))
            .backgroundColor($r('app.color.button_background'))
            .width(CommonConstants.FULL_WIDTH_PERCENT)
            .constraintSize({
              minWidth: $r('app.float.button_min_width'),
              maxWidth: $r('app.float.button_max_width')
            })
            .height($r('app.float.button_height'))
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.SpaceBetween)
        .backgroundColor(Color.White)
        .padding({
          left: $r('app.float.padding_common'),
          right: $r('app.float.padding_common'),
          top: $r('app.float.read_padding_top'),
          bottom: $r('app.float.read_padding_bottom')
        })
      }
      .width(CommonConstants.FULL_WIDTH_PERCENT)
      .height(CommonConstants.FULL_HEIGHT_PERCENT)
      .backgroundColor($r('app.color.transaction_background'))
    }
    .hideTitleBar(true)
    .onShown(() => {
      window.getLastWindow(getContext(this)).then((windowStage: window.Window) => {
        let sysBarProps: window.SystemBarProperties = {
          statusBarColor: '#F7F7F7'
        };
        windowStage.setWindowSystemBarProperties(sysBarProps);
      })
    })
    .onHidden(() => {
      window.getLastWindow(getContext(this)).then((windowStage: window.Window) => {
        let sysBarProps: window.SystemBarProperties = {
          statusBarColor: '#00ffffff'
        };
        windowStage.setWindowSystemBarProperties(sysBarProps);
      })
    })
  }
}

@Extend(Text)
function textTypeExtend() {
  .fontSize($r('app.float.type_text_size'))
  .fontColor($r('app.color.type_text'))
  .backgroundColor($r('app.color.type_text_background'))
  .padding({
    left: $r('app.float.type_text_padding_lr'),
    right: $r('app.float.type_text_padding_lr'),
    top: $r('app.float.type_text_padding_tb'),
    bottom: $r('app.float.type_text_padding_tb')
  })
}
