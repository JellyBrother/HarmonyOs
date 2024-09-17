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
import { ClassifyConstants, DetailShoppingBagView } from '@ohos/home';
import { CustomerServiceView } from './CustomerServiceView';
import { ProductInfo, ProductPicture } from './ProductDetail';
import { ProductUtilView } from './ProductUtilView';
import { DetailConstants } from '../constants/DetailConstants';

@Component
export struct ProductMoreDetail {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @StorageLink('topRectHeight') topRectHeight: number = 0;
  @State isMoreDetail: boolean = true;
  @State isShoppingBag: boolean = false;
  @State isCustomerService: boolean = false;
  @State isLiveMoreDetail: boolean = false;
  @Consume('pageInfos') pageInfos: NavPathStack;

  aboutToAppear(): void {
    let navParams: string = JSON.stringify(this.pageInfos.getParamByName(ClassifyConstants.PAGE_INFO_LIST[1]));
    if (navParams.includes(DetailConstants.PARAM_STRING_LIST[0])) {
      this.isShoppingBag = true;
    }
    if (navParams.includes(DetailConstants.PARAM_STRING_LIST[1])) {
      this.isCustomerService = true;
    }
  }

  aboutToDisappear(): void {
    this.isShoppingBag = false;
    this.isCustomerService = false;
  }

  build() {
    NavDestination() {
      Row() {
        Column() {
          Scroll() {
            Column() {
              ProductPicture({
                pageBreakpoint: new BreakpointType(BreakpointConstants.BREAKPOINT_SM, BreakpointConstants.BREAKPOINT_SM,
                  BreakpointConstants.BREAKPOINT_MD).getValue(this.currentBreakpoint),
                isMoreLiveDetail: $isLiveMoreDetail
              })
              ProductInfo({
                pageBreakpoint: new BreakpointType(BreakpointConstants.BREAKPOINT_SM,
                  BreakpointConstants.BREAKPOINT_SM, BreakpointConstants.BREAKPOINT_MD).getValue(this.currentBreakpoint)
              })
            }
            .margin({ top: deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[0] ? 0 : this.topRectHeight })
          }
          .scrollBar(BarState.Off)
          .layoutWeight(1)

          ProductUtilView({ isMoreDetail: $isMoreDetail, isShoppingBag: $isShoppingBag, isCustomerService:
            $isCustomerService })
        }
        .height(CommonConstants.FULL_PERCENT)
        // Setting the width ratio of offering details to side panel.
        .layoutWeight(new BreakpointType(0, CommonConstants.THREE, CommonConstants.FIVE)
          .getValue(this.currentBreakpoint))
        .borderWidth({ right: $r('app.float.more_detail_col_border_width') })
        .borderColor(ResourceUtil.getCommonBorderColor()[0])
        // Hide the product details page under the SM breakpoint.
        .visibility(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM ? Visibility.None : Visibility.Visible)

        Column() {
          // Check the auxiliary information page of the side panel.
          if (this.isShoppingBag) {
            DetailShoppingBagView({ isMoreDetail: this.isMoreDetail })
          }
          if (this.isCustomerService) {
            CustomerServiceView()
          }
        }
        .backgroundColor(ResourceUtil.getCommonBackgroundColor()[0])
        .height(CommonConstants.FULL_PERCENT)
        // Setting the width ratio of offering details to side panel.
        .layoutWeight(CommonConstants.THREE)
      }
      .height(CommonConstants.FULL_PERCENT)
      .width(CommonConstants.FULL_PERCENT)
    }
    .hideTitleBar(true)
    .expandSafeArea([SafeAreaType.KEYBOARD])
  }
}