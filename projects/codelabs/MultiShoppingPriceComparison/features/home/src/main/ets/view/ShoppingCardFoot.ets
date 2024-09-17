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

import { BreakpointConstants, CommonConstants, ResourceUtil } from '@ohos/commons';
import { ShoppingBagConstants } from '../constants/ShoppingBagConstants';

@Component
export struct ShoppingCardFoot {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  private isMoreDetail: boolean = false;

  build() {
    Row(){
      Row(){
        Checkbox()
          .selectedColor($r('app.color.classify_indicator_selected_color'))
          .width($r('app.float.check_box_size'))
          .height($r('app.float.check_box_size'))
          .margin({
            right: $r('app.float.shop_card_check_margin'),
            left: 0
          })
          .border({
            color: ResourceUtil.getCommonBorderColor()[2]
          })
          .shape(CheckBoxShape.ROUNDED_SQUARE)
        Text(ShoppingBagConstants.SHOPPING_CARD_FOOT_TITLES[0])
          .fontSize($r('app.float.shop_card_font_1'))
          .lineHeight($r('app.float.shop_card_line_1'))
          .fontWeight(FontWeight.Normal)
      }
      .height(CommonConstants.FULL_PERCENT)
      .justifyContent(FlexAlign.Start)

      Blank()

      Row(){
        Column(){
          Row(){
            Text(ShoppingBagConstants.SHOPPING_CARD_FOOT_TITLES[1])
              .fontSize($r('app.float.shop_card_font_1'))
              .lineHeight($r('app.float.shop_card_line_1'))
            Text(ShoppingBagConstants.SHOPPING_CARD_FOOT_TITLES[2])
              .fontSize($r('app.float.shop_card_font_1'))
              .lineHeight($r('app.float.shop_card_line_2'))
              .fontColor($r('app.color.shop_card_font_color'))
            Text(ShoppingBagConstants.SHOPPING_CARD_FOOT_TITLES[3])
              .fontSize($r('app.float.shop_card_font_2'))
              .lineHeight($r('app.float.shop_card_line_3'))
              .fontColor($r('app.color.shop_card_font_color'))
          }
          Row(){
            Text(ShoppingBagConstants.SHOPPING_CARD_FOOT_TITLES[4])
              .fontSize($r('app.float.shop_card_font_3'))
              .lineHeight($r('app.float.shop_card_line_4'))
              .fontWeight(FontWeight.Normal)
              .opacity(CommonConstants.TEXT_OPACITY[2])
              .margin({
                right: $r('app.float.arrow_up_margin')
              })
            Image($r('app.media.ic_public_arrow_up'))
              .width($r('app.float.arrow_up_width'))
              .height($r('app.float.arrow_up_height'))
              .opacity(CommonConstants.TEXT_OPACITY[1])
          }
        }

        Button(ShoppingBagConstants.SHOPPING_CARD_FOOT_TITLES[5], { type: ButtonType.Capsule, stateEffect: true })
          .labelStyle({
            font:{
              size:$r('app.float.shop_card_font_2')
            }
          })
          .backgroundColor($r('app.color.shop_card_foot_button'))
          .height($r('app.float.foot_button_height'))
          .width($r('app.float.foot_button_width'))
          .margin({
            left: $r('app.float.foot_button_margin')
          })
      }
      .height(CommonConstants.FULL_PERCENT)
      .alignItems(VerticalAlign.Center)
    }
    .justifyContent(FlexAlign.Start)
    .width(CommonConstants.FULL_PERCENT)
    .height($r('app.float.foot_height'))
    .padding({
      left: this.isMoreDetail ? $r('app.float.foot_padding_more') : 0,
      right: this.isMoreDetail ? $r('app.float.foot_padding_more') : 0
    })
  }
}