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

import { deviceInfo } from '@kit.BasicServicesKit';
import { SearchView } from '@ohos/search';
import { BreakpointConstants, CommonConstants } from '@ohos/commons';
import { FooterTab, FooterTabViewModel } from '../viewmodel/FooterTabViewModel';
import { HomeHeader } from './HomeHeader';
import { HomeContent } from './HomeContent';

@Component
export struct Home {
  @State currentBottomIndex: number = 0;
  @State isSearching: boolean = false;
  @StorageLink('scrollHeight') scrollHeight: number = 0;
  @StorageLink('currentTopIndex') currentTopIndex: number = 0;
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  private tabList: FooterTab[] = new FooterTabViewModel().getTabList();
  private scroller: Scroller = new Scroller();
  private sideScroller: Scroller = new Scroller();

  @Builder
  BottomTabBuilder(item: FooterTab, index: number) {
    Column() {
      Image(index !== this.currentBottomIndex ? (this.currentTopIndex === 2 && this.currentBottomIndex === 0 &&
        !this.isSearching ? item.getIconWhite() : item.getIcon()) : item.getIconSelected())
        .width($r('app.float.icon_tab_width'))
        .height($r('app.float.icon_tab_height'))
      Text(item.getName())
        .fontSize($r('app.float.tab_font_size'))
        .fontWeight(CommonConstants.FONT_WEIGHT_500)
        .fontColor(index === this.currentBottomIndex ? $r('app.color.tab_sel_color') : (this.currentTopIndex === 2 &&
          this.currentBottomIndex === 0 && !this.isSearching ? Color.White : Color.Black))
        .margin({ top: $r('app.float.tab_top_margin') })
        .opacity(index === this.currentBottomIndex ? CommonConstants.TEXT_OPACITY[3] : CommonConstants.TEXT_OPACITY[0])
    }
    .padding({ bottom: this.currentBreakpoint !== BreakpointConstants.BREAKPOINT_LG && deviceInfo.deviceType !==
      CommonConstants.DEVICE_TYPES[0] ? $r('app.float.bottom_navigation') : 0 })
    .height(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? $r('app.float.tab_height_lg') :
      CommonConstants.FULL_PERCENT)
    .width(CommonConstants.FULL_PERCENT)
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Tabs({
      barPosition: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? BarPosition.Start : BarPosition.End
    }) {
      TabContent() {
        if (this.currentTopIndex === 2) {
          // The immersive design of the home page is displayed when the top tab is switched to 2.
          Stack() {
            Scroll(this.sideScroller) {
              Column() {
                HomeContent()
                  .visibility(!this.isSearching ? Visibility.Visible : Visibility.None)

                SearchView({ isSearching: $isSearching })
                  .visibility(!this.isSearching ? Visibility.None : Visibility.Visible)
              }
              .width(CommonConstants.FULL_PERCENT)
            }
            .scrollBar(BarState.Off)
            .height(CommonConstants.FULL_PERCENT)
            // Obtains the sliding offset on the y axis during sliding.
            .onScrollFrameBegin((offset: number) => {
              this.scrollHeight = this.sideScroller.currentOffset().yOffset;
              return { offsetRemain: offset }
            })

            HomeHeader({ isSearching: $isSearching })
              .visibility(!this.isSearching ? Visibility.Visible : Visibility.None)
              .padding({ left: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
                $r('app.float.side_bar_width') : 0 })
          }
          .height(CommonConstants.FULL_PERCENT)
          .width(CommonConstants.FULL_PERCENT)
          .alignContent(Alignment.Top)
        } else {
          // Non-immersive design for the home page.
          Column() {
            HomeHeader({ isSearching: $isSearching })
              .visibility(!this.isSearching ? Visibility.Visible : Visibility.None)

            Scroll(this.scroller) {
              Column() {
                HomeContent()
                  .visibility(!this.isSearching ? Visibility.Visible : Visibility.None)

                SearchView({ isSearching: $isSearching })
                  .visibility(!this.isSearching ? Visibility.None : Visibility.Visible)
              }
              .width(CommonConstants.FULL_PERCENT)
            }
            .layoutWeight(1)
            .scrollBar(BarState.Off)
          }
          .height(CommonConstants.FULL_PERCENT)
          .width(CommonConstants.FULL_PERCENT)
        }
      }
      .tabBar(this.BottomTabBuilder(this.tabList[0], 0))

      TabContent() {
      }
      .tabBar(this.BottomTabBuilder(this.tabList[1], 1))

      TabContent() {
      }
      .tabBar(this.BottomTabBuilder(this.tabList[2], 2))

      TabContent() {
      }
      .tabBar(this.BottomTabBuilder(this.tabList[3], 3))
    }
    // Change the position and size of the tab at the bottom.
    .barWidth(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? $r('app.float.bottom_tab_bar_width_lg') :
      CommonConstants.FULL_PERCENT)
    .barHeight(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? CommonConstants.FULL_PERCENT :
      (deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[0] ? $r('app.float.tab_size_lg') :
      $r('app.float.tab_size')))
    .barMode(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? BarMode.Scrollable : BarMode.Fixed,
      { nonScrollableLayoutStyle: LayoutStyle.ALWAYS_CENTER })
    .vertical(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG)
    .barBackgroundColor(this.currentTopIndex === 2 && this.currentBottomIndex === 0 ?
      (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? $r('app.color.side_bar_background') :
      $r('app.color.home_content_background')) : $r('app.color.tab_background_color'))
    .barOverlap(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG && this.currentTopIndex === 2 ? true :
      false)
    .onChange((index: number) => {
      this.currentBottomIndex = index;
    })
    .scrollable(false)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    .height(CommonConstants.FULL_PERCENT)
    .width(CommonConstants.FULL_PERCENT)
  }
}