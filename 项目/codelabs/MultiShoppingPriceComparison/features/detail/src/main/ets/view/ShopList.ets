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

import { BreakpointConstants, BreakpointType, CommonConstants, ResourceUtil } from '@ohos/commons';
import { LiveConstants } from '../constants/LiveConstants';
import { ShopCarModel, ShopCarProduct } from '../viewmodel/ShopCarViewModel';

@Component
export struct ShopList {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @Builder payCardBuilder() {};
  @BuilderParam PayCardButton:() => void = this.payCardBuilder;
  private shopCarProduct: ShopCarProduct[] = new ShopCarModel().getShopCarProductList();

  build() {
    Column() {
      Row() {
        Text($r('app.string.preferential_scheme'))
          .fontColor(Color.White)
          .fontSize($r('app.float.preferential_scheme_font_size'))
          .lineHeight($r('app.float.preferential_scheme_line_height'))
          .fontWeight(CommonConstants.FONT_WEIGHT_500)
      }
      .alignSelf(ItemAlign.Start)
      .backgroundColor($r('app.color.preferential_scheme_background_color'))
      .height($r('app.float.preferential_scheme_height'))
      .borderRadius(ResourceUtil.getCommonBorderRadius()[5])
      .padding({
        left: $r('app.float.preferential_scheme_padding'),
        right: $r('app.float.preferential_scheme_padding')
      })
      .margin({ bottom: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
        $r('app.float.preferential_scheme_margin_lg') : $r('app.float.preferential_scheme_margin') })

      ForEach(this.shopCarProduct, (item: ShopCarProduct) => {
        Row() {
          Image(item.getImage())
            .width(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
              $r('app.float.bag_item_image_size_lg') : $r('app.float.bag_item_image_size'))
            .aspectRatio(1)
          Column() {
            Text(item.getName())
              .fontWeight(CommonConstants.FONT_WEIGHT_500)
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .fontSize($r('app.float.bag_item_name_font_size'))
              .margin({ bottom: $r('app.float.bag_item_name_margin_bottom') })
            Text(item.getRemark())
              .fontSize($r('app.float.bag_item_remark_font_size'))
              .fontWeight(FontWeight.Normal)
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .fontColor($r('app.color.bag_item_remark_font_color'))
              .margin({ bottom: $r('app.float.bag_item_remark_margin_bottom') })
            Row() {
              ForEach(item.getDiscounts(), (discountsItem: string, index: number) => {
                Row() {
                  Text(discountsItem)
                    .fontWeight(FontWeight.Normal)
                    .fontColor($r('app.color.bag_item_discounts_font_color'))
                    .fontSize($r('app.float.bag_item_discounts_font_size'))
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .padding({
                      top: $r('app.float.bag_item_discounts_padding_top'),
                      bottom: $r('app.float.bag_item_discounts_padding_top'),
                      left: $r('app.float.bag_item_discounts_padding_left'),
                      right: $r('app.float.bag_item_discounts_padding_left')
                    })
                    .border({
                      radius: $r('app.float.bag_item_discounts_border_radius'),
                      color: $r('app.color.bag_item_discounts_border_color'),
                      width: $r('app.float.bag_item_discounts_border_width')
                    })
                    .margin({ right: $r('app.float.bag_item_discounts_margin_right') })
                }
                .layoutWeight(index > 0 ? 1 : 0)
              }, (discountsItem: string, index: number) => discountsItem + index)
            }
            .width(CommonConstants.FULL_PERCENT)
            Blank()
            Row() {
              Text( LiveConstants.CURRENCY_SYMBOL + JSON.stringify(item.getPrice()))
                .fontColor($r('app.color.bag_item_price_color'))
                .fontSize($r('app.float.bag_item_font_size'))
                .fontWeight(CommonConstants.FONT_WEIGHT_500)
                .displayPriority(1)
              Blank()
                .displayPriority(2)
              this.PayCardButton()
            }
            .width(CommonConstants.FULL_PERCENT)
          }
          .height(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
            $r('app.float.bag_item_height_lg') : $r('app.float.bag_item_height'))
          .padding({
            top: $r('app.float.bag_item_padding_top'),
            bottom:  $r('app.float.bag_item_padding_left'),
            left: $r('app.float.bag_item_padding_left'),
            right: new BreakpointType($r('app.float.bag_item_padding_top'), $r('app.float.bag_item_padding_left'),
              $r('app.float.bag_item_padding_top')).getValue(this.currentBreakpoint),
          })
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.Start)
        }
        .width(CommonConstants.FULL_PERCENT)
        .backgroundColor(Color.White)
        .borderRadius(ResourceUtil.getCommonBorderRadius()[6])
        .margin({ bottom: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
          $r('app.float.bag_item_margin_lg') : $r('app.float.bag_item_margin') })
      }, (item: ShopCarProduct, index: number) => JSON.stringify(item) + index)
    }
    .width(CommonConstants.FULL_PERCENT)
  }
}