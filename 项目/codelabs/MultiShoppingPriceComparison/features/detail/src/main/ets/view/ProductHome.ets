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
import { AbilityConstant, common, StartOptions, Want } from '@kit.AbilityKit';
import { BreakpointConstants, CommonConstants, PipWindowUtil, ResourceUtil } from '@ohos/commons';
import { ProductInfo, ProductPicture } from './ProductDetail';
import { ProductUtilView } from './ProductUtilView';
import { DetailTopIcon } from './CommonView';
import { AllComments } from './ProductConfig';

@Component
export struct ProductHome {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @StorageLink('topRectHeight') topRectHeight: number = 0;
  @StorageLink('windowWidth') windowWidth: number = 0;
  @StorageLink('isShowingSidebar') isShowingSidebar: boolean = false;
  @StorageLink('isSplitMode') isSplitMode: boolean = false;
  @State isMoreDetail: boolean = false;
  @State isShoppingBag: boolean = false;
  @State isCustomerService: boolean = false;
  @State isDialogOpen: boolean = false;
  @State detailType: string = CommonConstants.BIND_SHEET_PAGE_TYPES[3];
  @State isLiveMoreDetail: boolean = false;
  @Consume('pageInfos') pageInfos: NavPathStack;
  private pipWindowUtil: PipWindowUtil | undefined = PipWindowUtil.getPipWindowUtil();

  aboutToDisappear(): void {
    if (deviceInfo.deviceType !== CommonConstants.DEVICE_TYPES[0]) {
      if (this.pipWindowUtil === undefined) {
        return;
      }
      this.pipWindowUtil.stopPip();
    }
  }

  build() {
    NavDestination() {
      SideBarContainer() {
        Column() {
          Image($r('app.media.icon_close_4'))
            .width(ResourceUtil.getCommonImgSize()[1])
            .height(ResourceUtil.getCommonImgSize()[1])
            .onClick(() => {
              if (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG) {
                this.isShowingSidebar = false;
              }
            })
            .margin({
              top: $r('app.float.detail_lg_top_row_margin'),
              bottom: $r('app.float.detail_lg_top_row_margin')
            })
          AllComments()
        }
        .alignItems(HorizontalAlign.End)
        .height(CommonConstants.FULL_PERCENT)
        .padding({
          top: deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[0] ? 0 : this.topRectHeight,
          left: $r('app.float.three_column_page_padding'),
          right: $r('app.float.three_column_page_padding')
        })

        Row() {
          if (this.currentBreakpoint !== BreakpointConstants.BREAKPOINT_LG) {
            Column() {
              Scroll() {
                Column() {
                  ProductPicture({ pageBreakpoint: this.currentBreakpoint, isMoreLiveDetail: $isLiveMoreDetail })
                  ProductInfo({ pageBreakpoint: this.currentBreakpoint })
                }
              }
              .scrollBar(BarState.Off)
              .layoutWeight(1)

              ProductUtilView({ isMoreDetail: $isMoreDetail, isShoppingBag: $isShoppingBag, isCustomerService:
                $isCustomerService })
            }
            .padding({ top: deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[0] ? 0 : this.topRectHeight })
            .height(CommonConstants.FULL_PERCENT)
            .layoutWeight(1)
          } else {
            Column() {
              ProductPicture({ pageBreakpoint: this.currentBreakpoint, isMoreLiveDetail: $isLiveMoreDetail })
            }
            .padding({ top: deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[0] ? 0 : this.topRectHeight })
            .height(CommonConstants.FULL_PERCENT)
            .layoutWeight(1)
          }

          if (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG) {
            Column() {
              Row() {
                DetailTopIcon({ imageResource: $r('app.media.ic_mate_pad_2') })
                  .margin({ right: $r('app.float.detail_top_icon_margin_sm') })
                  .onClick(() => {
                    if (deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[0]) {
                      return;
                    }
                    if (!this.isSplitMode) {
                      let want: Want = {
                        bundleName: 'com.huawei.multishoppingpricecomparison',
                        abilityName: 'SecondAbility'
                      };
                      let option: StartOptions = { windowMode: AbilityConstant.WindowMode.WINDOW_MODE_SPLIT_PRIMARY };
                      (getContext(this) as common.UIAbilityContext).startAbility(want, option);
                    } else {
                      (getContext(this) as common.UIAbilityContext).terminateSelf();
                    }
                  })
                DetailTopIcon({ imageResource: $r('app.media.ic_more') })
              }
              .padding({
                left: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint),
                right: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint)
              })
              .justifyContent(FlexAlign.End)
              .width(CommonConstants.FULL_PERCENT)
              .margin({
                top: $r('app.float.detail_lg_top_row_margin'),
                bottom: $r('app.float.detail_lg_top_row_margin')
              })

              Scroll() {
                ProductInfo({ pageBreakpoint: BreakpointConstants.BREAKPOINT_LG })
              }
              .align(Alignment.Top)
              .scrollBar(BarState.Off)
              .layoutWeight(1)

              ProductUtilView({ isMoreDetail: $isMoreDetail, isShoppingBag: $isShoppingBag, isCustomerService:
                $isCustomerService })
            }
            .padding({ top: deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[0] ? 0 : this.topRectHeight })
            .backgroundColor($r('app.color.products_info'))
            .height(CommonConstants.FULL_PERCENT)
            .layoutWeight(1)
            .justifyContent(FlexAlign.Start)
          }
        }
        .alignItems(VerticalAlign.Top)
        .height(CommonConstants.FULL_PERCENT)
        .width(CommonConstants.FULL_PERCENT)
        .layoutWeight(2)
      }
      .showSideBar(this.isShowingSidebar)
      .showControlButton(false)
      .sideBarPosition(SideBarPosition.End)
      .divider({
        strokeWidth: $r('app.float.sidebar_divider_width'),
        color: ResourceUtil.getCommonDividerColor()
      })
      .minSideBarWidth(px2vp(this.windowWidth) / CommonConstants.THREE)
      .maxSideBarWidth(px2vp(this.windowWidth) / CommonConstants.THREE)
      .autoHide(false)
    }
    .hideTitleBar(true)
  }
}