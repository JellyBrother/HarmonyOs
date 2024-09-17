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

import { BottomTabsItem, BreakpointSystem, CommonConstants as Const } from '@ohos/common';
import { HomeTabs } from '../view/HomeTabsComponent';
import { FindTabs } from '../view/FindTabsComponent';
import { DriveTabs } from '../view/DriveTabsComponent';
import { MineTabs } from '../view/MineTabsComponent';
import { BottomTabsList } from '../viewmodel/BottomTabsModel';

@Entry
@Component
struct MainPage {
  @State @Watch('onIndexChange') bottomTabIndex: number = 0;
  @StorageProp('currentBreakpoint') currentBreakpoint: string = Const.MD;
  private breakpointSystem: BreakpointSystem = new BreakpointSystem();
  private controller: TabsController = new TabsController();

  aboutToAppear(){
    this.breakpointSystem.register();
  }

  aboutToDisappear() {
    this.breakpointSystem.unregister();
  }

  onIndexChange() {
    this.controller.changeIndex(this.bottomTabIndex);
  }

  @Builder BottomTabBuilder(item: BottomTabsItem, index: number) {
    Column() {
      Image(index === this.bottomTabIndex ? item.iconSelected : item.icon)
        .width(Const.BOTTOM_IMAGE_SIZE)
        .height(Const.BOTTOM_IMAGE_SIZE)
        .objectFit(ImageFit.Contain)
        .margin({ bottom: $r('app.float.bottom_margin') })

      Text(item.text)
        .fontSize($r('app.float.bottom_font_size'))
        .opacity(Const.OPACITY)
        .fontColor(index !== this.bottomTabIndex ? $r('app.color.bottom_tabs_font_color') : $r('app.color.bottom_tabs_font_color_selected'))
    }
    .height(this.currentBreakpoint === Const.LG ? Const.LEFT_TAB_HEIGHT : Const.FULL_SIZE)
    .width(Const.FULL_SIZE)
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Tabs({
      barPosition: this.currentBreakpoint === Const.LG ? BarPosition.Start : BarPosition.End,
      index: 0,
      controller: this.controller
    }) {
      TabContent() {
        HomeTabs({ currentBreakpoint: $currentBreakpoint })
      }
      .tabBar(this.BottomTabBuilder(BottomTabsList[0], 0))
      .padding({
        left: this.currentBreakpoint === Const.SM ? $r('app.float.main_page_padding1') : (this.currentBreakpoint === Const.MD ? $r('app.float.main_page_padding3') : 0),
        right: this.currentBreakpoint === Const.SM ? $r('app.float.main_page_padding1') : $r('app.float.main_page_padding3')
      })

      TabContent() {
        FindTabs()
      }
      .tabBar(this.BottomTabBuilder(BottomTabsList[1], 1))
      .padding({
        left: this.currentBreakpoint === Const.SM ? $r('app.float.main_page_padding2') : (this.currentBreakpoint === Const.MD ? $r('app.float.main_page_padding3') : 0),
        right: this.currentBreakpoint === Const.SM ? $r('app.float.main_page_padding2') : $r('app.float.main_page_padding3')
      })

      TabContent() {
        DriveTabs()
      }
      .tabBar(this.BottomTabBuilder(BottomTabsList[2], 2))
      .padding({
        left: this.currentBreakpoint === Const.SM ? $r('app.float.main_page_padding1') : (this.currentBreakpoint === Const.MD ? $r('app.float.main_page_padding3') : 0),
        right: this.currentBreakpoint === Const.SM ? $r('app.float.main_page_padding1') : $r('app.float.main_page_padding3')
      })

      TabContent() {
        MineTabs()
      }
      .tabBar(this.BottomTabBuilder(BottomTabsList[3], 3))
    }
    .barHeight(this.currentBreakpoint !== Const.LG ? $r('app.float.tabs_height') : Const.FULL_SIZE)
    .barWidth(this.currentBreakpoint === Const.LG ? $r('app.float.tabs_width') : Const.FULL_SIZE)
    .barMode(this.currentBreakpoint === Const.LG ? BarMode.Scrollable : BarMode.Fixed,
      { nonScrollableLayoutStyle: LayoutStyle.ALWAYS_CENTER })
    .vertical(this.currentBreakpoint === Const.LG)
    .onChange((index: number) => {
      this.bottomTabIndex = index;
    })
    .width(Const.FULL_SIZE)
    .backgroundColor($r('app.color.background_color'))
  }
}