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
import { deviceInfo } from '@kit.BasicServicesKit';
import { ShoppingCardFoot } from './ShoppingCardFoot';
import { ShoppingBagDiscounts } from './ShoppingBagDiscounts';
import { ShoppingBagListViewModel, ShoppingBagProduct } from '../viewmodel/ShoppingBagListViewModel';
import { ShoppingCardItem } from './ShoppingCardItem';
import { ShoppingBagConstants } from '../constants/ShoppingBagConstants';

@Component
export struct ShoppingBagContent {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;

  build() {
    Row() {
      ShoppingBagView()
      ShoppingBagDiscounts()
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(CommonConstants.FULL_PERCENT)
    .backgroundColor(ResourceUtil.getCommonBackgroundColor()[0])
  }
}

@Component
struct ShoppingBagView {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @StorageLink('topRectHeight') topRectHeight: number = 0;

  build() {
    Column() {
      Column() {
        Row() {
          Text(ShoppingBagConstants.SHOPPING_BAG_TITLES[0])
            .font({
              size: $r('app.float.bag_title_font'),
              weight: CommonConstants.FONT_WEIGHT_500
            })
          Blank()
          Text(ShoppingBagConstants.SHOPPING_BAG_TITLES[1])
            .font({
              size: $r('app.float.bag_name_font')
            })
            .opacity(CommonConstants.TEXT_OPACITY[2])
        }
        .height($r('app.float.bag_title_row_height'))
        .width(CommonConstants.FULL_PERCENT)

        ShoppingBagCard()
      }
      .width(CommonConstants.FULL_PERCENT)
      .layoutWeight(1)
      .margin({ top: deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[0] ? $r('app.float.bag_col_margin') :
        this.topRectHeight })

      ShoppingCardFoot()
        .visibility(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? Visibility.None : Visibility.Visible)
    }
    .padding({
      left: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint),
      right: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint)
    })
    .layoutWeight(ShoppingBagConstants.SHOPPING_BAG_LAYOUT_WEIGHTS[0])
    .height(CommonConstants.FULL_PERCENT)
    .border({
      width: { right: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? 1 : 0 },
      color: ResourceUtil.getCommonBorderColor()[1]
    })
  }
}

@Component
export struct DetailShoppingBagView {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @StorageLink('topRectHeight') topRectHeight: number = 0;
  @Consume('pageInfos') pageInfos: NavPathStack;
  private isMoreDetail: boolean = false;

  build() {
    Column() {
      Column() {
        Row() {
          Image($r('app.media.ic_public_back'))
            .width(ResourceUtil.getCommonImgSize()[0])
            .height(ResourceUtil.getCommonImgSize()[0])
            .margin({ right: $r('app.float.bag_back_margin') })
            .visibility(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM && this.isMoreDetail ?
              Visibility.Visible : Visibility.None)
            .onClick(() => {
              if (this.pageInfos !== undefined) {
                this.pageInfos.pop();
              }
            })
          Text(ShoppingBagConstants.SHOPPING_BAG_TITLES[0])
            .font({
              size: $r('app.float.bag_title_font'),
              weight: CommonConstants.FONT_WEIGHT_500
            })
          Blank()
          Text(ShoppingBagConstants.SHOPPING_BAG_TITLES[1])
            .font({ size: $r('app.float.bag_name_font') })
            .opacity(CommonConstants.TEXT_OPACITY[2])
          Image($r('app.media.icon_close'))
            .width(ResourceUtil.getCommonImgSize()[0])
            .height(ResourceUtil.getCommonImgSize()[0])
            .margin({ left: $r('app.float.bag_close_margin') })
            .visibility(this.currentBreakpoint !== BreakpointConstants.BREAKPOINT_SM ? Visibility.Visible :
              Visibility.None)
            .onClick(() => {
              if (this.pageInfos !== undefined) {
                this.pageInfos.pop();
              }
            })
        }
        .height($r('app.float.bag_title_row_height'))
        .width(CommonConstants.FULL_PERCENT)

        ShoppingBagCard()
      }
      .width(CommonConstants.FULL_PERCENT)
      .layoutWeight(1)
      .margin({ top: deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[0] ? $r('app.float.bag_col_margin') :
        this.topRectHeight })

      ShoppingCardFoot()
        .margin({ bottom: deviceInfo.deviceType !== CommonConstants.DEVICE_TYPES[0] ?
          CommonConstants.BOTTOM_RECT_HEIGHT : 0 })
        .visibility(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG && !this.isMoreDetail ?
          Visibility.None : Visibility.Visible)
    }
    .padding({
      left: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint),
      right: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint)
    })
    .layoutWeight(ShoppingBagConstants.SHOPPING_BAG_LAYOUT_WEIGHTS[0])
    .height(CommonConstants.FULL_PERCENT)
    .border({
      width: { right: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? 1 : 0 },
      color: ResourceUtil.getCommonBorderColor()[1]
    })
  }
}

@Component
export struct ShoppingBagCard {
  private ShoppingBagList: ShoppingBagProduct[] = new ShoppingBagListViewModel().getShoppingBagItemData();

  build() {
    Scroll() {
      Column() {
        Row() {
          CheckboxGroup({ group: 'shoppingCardHuaWei' })
            .selectedColor($r('app.color.classify_indicator_selected_color'))
            .width($r('app.float.check_box_size'))
            .height($r('app.float.check_box_size'))
            .margin({ right: $r('app.float.check_box_group_margin') })
            .border({ color: ResourceUtil.getCommonBorderColor()[2] })

          Image($r('app.media.shopping_card_logo'))
            .width(ResourceUtil.getCommonImgSize()[0])
            .height(ResourceUtil.getCommonImgSize()[0])
            .margin({ right: $r('app.float.bag_seller_logo_margin') })
            .border({
              radius: ResourceUtil.getCommonBorderRadius()[4],
              width: $r('app.float.bag_seller_logo_border_width'),
              color: ResourceUtil.getCommonBorderColor()[3]
            })

          Text(ShoppingBagConstants.SHOPPING_BAG_TITLES[2])
            .font({
              size: $r('app.float.bag_name_font'),
              weight: CommonConstants.FONT_WEIGHT_500
            })
            .layoutWeight(1)
        }
        .height($r('app.float.bag_card_title_row_height'))
        .width(CommonConstants.FULL_PERCENT)

        List() {
          ForEach(this.ShoppingBagList, (item: ShoppingBagProduct, index: number) => {
            ListItem() {
              Row() {
                Column() {
                  Checkbox({ group: 'shoppingCardHuaWei' })
                    .selectedColor($r('app.color.classify_indicator_selected_color'))
                    .width($r('app.float.check_box_size'))
                    .height($r('app.float.check_box_size'))
                    .margin({
                      right: $r('app.float.bag_card_check_box_margin'),
                      left: 0
                    })
                    .border({
                      color: ResourceUtil.getCommonBorderColor()[2]
                    })
                    .shape(CheckBoxShape.ROUNDED_SQUARE)
                }
                .width($r('app.float.bag_card_check_col_width'))
                .padding({ top: $r('app.float.bag_card_check_col_padding') })
                .justifyContent(FlexAlign.Start)

                ShoppingCardItem({
                  shoppingBagProductItem: item,
                  titleEllipsis: false
                })
                  .layoutWeight(1)
              }
              .width(CommonConstants.FULL_PERCENT)
              .padding({
                top: $r('app.float.bag_card_row_padding'),
                bottom: $r('app.float.bag_card_row_padding')
              })
            }
          })
        }
        .scrollBar(BarState.Off)
      }
      .width(CommonConstants.FULL_PERCENT)
      .backgroundColor(Color.White)
      .borderRadius(ResourceUtil.getCommonBorderRadius()[7])
      .padding($r('app.float.bag_card_col_padding'))
      .margin({ bottom: CommonConstants.BOTTOM_RECT_HEIGHT })
    }
    .scrollBar(BarState.Off)
    .layoutWeight(1)
    .width(CommonConstants.FULL_PERCENT)
  }
}