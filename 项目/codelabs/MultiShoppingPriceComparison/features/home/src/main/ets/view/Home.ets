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
import { FooterTab, FooterTabViewModel } from '../viewmodel/FooterTabViewModel';
import { HomeContent } from './HomeContent';
import { ClassifyContent } from './ClassifyContent';
import { ShoppingBagContent } from './ShoppingBagContent';

@Component
export struct Home {
  @State currentBottomIndex: number = 0;
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @StorageLink('topRectHeight') topRectHeight: number = 0;
  private tabList: FooterTab[] = new FooterTabViewModel().getTabList();

  @Builder
  BottomTabBuilder(item: FooterTab, index: number) {
    Column() {
      Image(index !== this.currentBottomIndex ? item.getIcon() : item.getIconSelected())
        .width(ResourceUtil.getCommonImgSize()[0])
        .height(ResourceUtil.getCommonImgSize()[0])
      Text(item.getName())
        .fontSize($r('app.float.tab_font_size'))
        .fontWeight(CommonConstants.FONT_WEIGHT_500)
        .fontColor(index === this.currentBottomIndex ? $r('app.color.tab_sel_color') : Color.Black)
        .margin({ top: $r('app.float.tab_top_margin') })
        .opacity(index === this.currentBottomIndex ? CommonConstants.TEXT_OPACITY[0] : CommonConstants.TEXT_OPACITY[1])
    }
    .padding({
      bottom: deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[0] ? 0 : CommonConstants.BOTTOM_RECT_HEIGHT
    })
    .height(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? $r('app.float.side_tab_bar_height') :
      CommonConstants.FULL_PERCENT)
    .width(CommonConstants.FULL_PERCENT)
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Column() {
      Tabs({ barPosition: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? BarPosition.Start :
        BarPosition.End }) {
        TabContent() {
          HomeContent()
        }
        .tabBar(this.BottomTabBuilder(this.tabList[0], 0))

        TabContent() {
          ClassifyContent()
        }
        .tabBar(this.BottomTabBuilder(this.tabList[1], 1))

        TabContent() {
        }
        .tabBar(this.BottomTabBuilder(this.tabList[2], 2))

        TabContent() {
          ShoppingBagContent()
        }
        .tabBar(this.BottomTabBuilder(this.tabList[3], 3))

        TabContent() {
        }
        .tabBar(this.BottomTabBuilder(this.tabList[4], 4))
      }
      // Change the position and size of the tab at the bottom.
      .barWidth(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? $r('app.float.bottom_tab_bar_width_lg') :
        CommonConstants.FULL_PERCENT)
      .barHeight(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? CommonConstants.FULL_PERCENT :
        ((deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[0] ? CommonConstants.TAB_BAR_HEIGHT :
          CommonConstants.TAB_BAR_HEIGHT + CommonConstants.BOTTOM_RECT_HEIGHT)))
      .barBackgroundColor($r('app.color.tab_background_color'))
      .barMode(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? BarMode.Scrollable : BarMode.Fixed,
        { nonScrollableLayoutStyle: LayoutStyle.ALWAYS_CENTER })
      .vertical(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG)
      .onChange((index: number) => {
        this.currentBottomIndex = index;
      })
      .scrollable(false)
    }
  }
}