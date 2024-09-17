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
import { BreakpointConstants, CommonConstants, ResourceUtil } from '@ohos/commons';
import { LiveConstants } from '../constants/LiveConstants';
import { ShopBagHeader } from './ShopBagHeader';
import { ShopList } from './ShopList';

@Component
export struct ShopBag {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @Link isMoreDetail: boolean;
  @State currentIndex: number = 0;
  @Builder payCardBuilder() {};
  @BuilderParam PayCardButton: () => void = this.payCardBuilder;
  private scroller: Scroller = new Scroller();

  @Builder
  tabBuilder(title: string, targetIndex: number) {
    Column() {
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? $r('app.color.shop_tab_text_color_current') :
          $r('app.color.shop_tab_text_color'))
        .fontSize($r('app.float.shop_tab_text_size'))
        .lineHeight($r('app.float.shop_tab_line_height'))
        .fontWeight(CommonConstants.FONT_WEIGHT_500)
    }
    .margin({
      right: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
        $r('app.float.shop_tab_margin_right_lg') : $r('app.float.shop_tab_margin_right')
    })
  }

  build() {
    Column() {
      ShopBagHeader({ isMoreDetail: this.isMoreDetail })
      Tabs({ barPosition: BarPosition.Start }) {
        ForEach(LiveConstants.SHOP_CAR_TABS, (item: string, index: number) => {
          TabContent() {
            Scroll(this.scroller) {
              ShopList({ PayCardButton: this.PayCardButton })
            }
            .align(Alignment.Top)
            .scrollBar(BarState.Off)
            .height(CommonConstants.FULL_PERCENT)
            .width(CommonConstants.FULL_PERCENT)
          }
          .tabBar(this.tabBuilder(item, index))
        }, (item: string, index: number) => index + JSON.stringify(item))
      }
      .onChange((index) => {
        this.currentIndex = index;
      })
      .layoutWeight(1)
      .barWidth(CommonConstants.FULL_PERCENT)
      .barHeight($r('app.float.shop_tab_height'))
      .barMode(BarMode.Scrollable, { margin: 0, nonScrollableLayoutStyle: LayoutStyle.ALWAYS_AVERAGE_SPLIT })
      .fadingEdge(false)
      .margin({
        bottom: deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[0] ? 0 : CommonConstants.BOTTOM_RECT_HEIGHT
      })
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(CommonConstants.FULL_PERCENT)
    .padding({
      left: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint),
      right: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint)
    })
  }
}