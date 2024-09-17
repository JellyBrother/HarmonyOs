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

import { display } from '@kit.ArkUI';
import { Callback, deviceInfo } from '@kit.BasicServicesKit';
import { BreakpointConstants, BreakpointType, CommonConstants, Logger, ResourceUtil } from '@ohos/commons';
import { Live } from './Live';
import { ShopBag } from './ShopBag';
import { LiveConstants } from '../constants/LiveConstants';
import { PayCard } from './PayCard';
import { ProductUtilView } from './ProductUtilView';
import { ProductInfo, ProductPicture } from './ProductDetail';

@Component
export struct LiveHome {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @StorageLink('topRectHeight') topRectHeight: number = 0;
  @State isMoreDetail: boolean = false;
  @State detailType: string = CommonConstants.BIND_SHEET_PAGE_TYPES[0];
  @State isBindSheetOpen: boolean = false;
  @State utilMoreDetail: boolean = true;
  @State utilShoppingBag: boolean = false;
  @State utilCustomerService: boolean = false;
  @Consume('pageInfos') pageInfos: NavPathStack;
  private onFoldStatusChange: Callback<display.FoldStatus> = (data: display.FoldStatus) => {
    if (data === display.FoldStatus.FOLD_STATUS_FOLDED && this.detailType === CommonConstants.BIND_SHEET_PAGE_TYPES[2])
    {
      this.isMoreDetail = false;
    }
  };

  aboutToAppear(): void {
    try {
      display.on('foldStatusChange', this.onFoldStatusChange);
    } catch (exception) {
      Logger.error('Failed to register the fold status callback. Code: ' + JSON.stringify(exception));
    }
  }

  aboutToDisappear(): void {
    try {
      display.off('foldStatusChange');
    } catch (exception) {
      Logger.error('Failed to unregister the fold status callback. Code: ' + JSON.stringify(exception));
    }
  }

  @Builder
  ShopBagBuilder() {
    Column() {
      ShopBag({
        isMoreDetail: $isMoreDetail,
        PayCardButton: (): void => { this.PayCardButton() }
      })
        .visibility(this.detailType === CommonConstants.BIND_SHEET_PAGE_TYPES[0] ? Visibility.Visible : Visibility.None)

      PayCard({
        isOpen: $isBindSheetOpen,
        detailType: $detailType,
        currentBreakpoint: this.currentBreakpoint
      })
        .visibility(this.detailType === CommonConstants.BIND_SHEET_PAGE_TYPES[1] ? Visibility.Visible : Visibility.None)
    }
    .padding({ top: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM ? (this.detailType ===
      CommonConstants.BIND_SHEET_PAGE_TYPES[0] ? $r('app.float.index_col_padding_top_1') :
      $r('app.float.index_col_padding_top_2')) : 0 })
    .width(CommonConstants.FULL_PERCENT)
    .height(CommonConstants.FULL_PERCENT)
  }

  @Builder
  shopCarButton() {
    Image($r('app.media.icon_cart'))
      .width(ResourceUtil.getCommonImgSize()[10])
      .height(ResourceUtil.getCommonImgSize()[10])
      .onClick(() => {
        this.isMoreDetail = true;
        this.detailType = CommonConstants.BIND_SHEET_PAGE_TYPES[0];
      })
      .bindSheet((this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM && this.isMoreDetail),
        this.ShopBagBuilder(), {
          detents: [$r('app.float.index_bind_detents'), LiveConstants.NINETY_PERCENT],
          onDisappear: () => { this.isMoreDetail = false },
          showClose: false,
          backgroundColor: ResourceUtil.getCommonBackgroundColor()[0],
          dragBar: false
        })
  }

  @Builder
  PayCardButton() {
    Text(LiveConstants.PAY_BUTTON_TEXT)
      .width($r('app.float.pay_button_width'))
      .height($r('app.float.live_pay_button_height'))
      .fontColor(Color.White)
      .border({ radius: ResourceUtil.getCommonBorderRadius()[5] })
      .fontSize($r('app.float.pay_button_font'))
      .backgroundColor($r('app.color.pay_button_color'))
      .textAlign(TextAlign.Center)
      .displayPriority(3)
      .onClick(() => {
        this.detailType = CommonConstants.BIND_SHEET_PAGE_TYPES[1];
      })
  }

  build() {
    NavDestination() {
      Row() {
        Column() {
          Live({
            shopCarButton: (): void => { this.shopCarButton() },
            currentBreakpoint: this.isMoreDetail ? new BreakpointType(BreakpointConstants.BREAKPOINT_SM,
              BreakpointConstants.BREAKPOINT_SM, BreakpointConstants.BREAKPOINT_MD).getValue(this.currentBreakpoint) :
            this.currentBreakpoint,
            detailType: $detailType,
            isMoreDetail: $isMoreDetail
          })
        }
        .layoutWeight(5)

        Column() {
          ShopBag({
            isMoreDetail: $isMoreDetail,
            PayCardButton: (): void => { this.PayCardButton() }
          })
            .visibility(this.detailType === CommonConstants.BIND_SHEET_PAGE_TYPES[0] ? Visibility.Visible :
              Visibility.None)

          PayCard({
            isOpen: $isBindSheetOpen,
            detailType: $detailType,
            currentBreakpoint: this.currentBreakpoint
          })
            .visibility(this.detailType === CommonConstants.BIND_SHEET_PAGE_TYPES[1] ? Visibility.Visible :
              Visibility.None)

          Column() {
            Scroll() {
              Column() {
                ProductPicture({ pageBreakpoint: BreakpointConstants.BREAKPOINT_SM, isMoreLiveDetail: $isMoreDetail })
                ProductInfo({ pageBreakpoint: BreakpointConstants.BREAKPOINT_SM })
              }
              .padding({ bottom: deviceInfo.deviceType !== CommonConstants.DEVICE_TYPES[0] ?
                CommonConstants.BOTTOM_RECT_HEIGHT : 0 })
            }
            .scrollBar(BarState.Off)
            .layoutWeight(1)
            .width(CommonConstants.FULL_PERCENT)
            .visibility(this.currentBreakpoint !== BreakpointConstants.BREAKPOINT_SM && this.detailType ===
              CommonConstants.BIND_SHEET_PAGE_TYPES[2] ? Visibility.Visible : Visibility.None)

            ProductUtilView({ isMoreDetail: $utilMoreDetail, isShoppingBag: $utilShoppingBag, isCustomerService:
              $utilCustomerService, isLivePage: true })
          }
          .height(CommonConstants.FULL_PERCENT)
          .width(CommonConstants.FULL_PERCENT)
        }
        .visibility(this.isMoreDetail && this.currentBreakpoint !== BreakpointConstants.BREAKPOINT_SM ?
          Visibility.Visible : Visibility.None)
        .backgroundColor(ResourceUtil.getCommonBackgroundColor()[0])
        .height(CommonConstants.FULL_PERCENT)
        .layoutWeight(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? 3 : 5)
        .padding({ top: deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[0] ? 0 : this.topRectHeight })
      }
      .height(CommonConstants.FULL_PERCENT)
      .width(CommonConstants.FULL_PERCENT)
    }
    .hideTitleBar(true)
    .expandSafeArea([SafeAreaType.KEYBOARD])
  }
}