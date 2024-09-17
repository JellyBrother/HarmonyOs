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

import { CommonConstants } from '@ohos/basic/';
import { window } from '@kit.ArkUI';
import { FundConstants } from '../constants/FundConstants';
import { FundComponent } from './FundComponent';
import FundingViewModel from '../viewmodel/FundingViewModel';

@Component
export struct Funding {
  @StorageLink('breakPoint') breakPoint: string = CommonConstants.BREAK_POINT_SM;
  @State currentTabIndex: number = 0;
  @StorageProp('avoidArea') topHeight: number = 0;

  @Builder
  BuildTabs(icon: Resource, title: ResourceStr, index: number) {
    Column({ space: FundConstants.TAB_COLUMN_SPACE }) {
      Image(icon)
        .width($r('app.float.common_image'))
        .height($r('app.float.common_image'))
        .fillColor(this.currentTabIndex === index ? $r('app.color.tab_choose_image') : $r('app.color.tab_un_image'))
      Text(title)
        .fontSize($r('app.float.home_tab_text_size'))
        .lineHeight($r('app.float.tab_text_height'))
        .fontWeight(FontWeight.Regular)
        .fontColor(this.currentTabIndex === index ? $r('app.color.tab_choose_image') : $r('app.color.tab_un_image'))
    }
  }

  @Builder
  BuildTabsMine(icon: Resource, unIcon: Resource, title: ResourceStr, index: number) {
    Column({ space: FundConstants.TAB_COLUMN_SPACE }) {
      Image(this.currentTabIndex === index ? icon : unIcon)
        .width($r('app.float.common_image'))
        .height($r('app.float.common_image'))
      Text(title)
        .fontSize($r('app.float.home_tab_text_size'))
        .lineHeight($r('app.float.tab_text_height'))
        .fontWeight(FontWeight.Regular)
        .fontColor(this.currentTabIndex === index ? $r('app.color.tab_choose_image') : $r('app.color.tab_un_image'))
    }
  }

  build() {
    NavDestination() {
      GridRow({
        breakpoints: {
          value: CommonConstants.BREAK_POINTS_VALUE,
          reference: BreakpointsReference.WindowSize
        },
        columns: {
          sm: CommonConstants.COLUMN_SM,
          md: CommonConstants.COLUMN_MD,
          lg: CommonConstants.COLUMN_LG
        },
        direction: GridRowDirection.Row
      }) {
        GridCol({
          span: {
            sm: CommonConstants.COLUMN_SM,
            md: CommonConstants.COLUMN_MD,
            lg: CommonConstants.COLUMN_LG
          }
        }) {
          Column() {
            Tabs({
              barPosition: this.breakPoint === CommonConstants.BREAK_POINT_LG ? BarPosition.Start : BarPosition.End
            }) {
              TabContent() {
                FundComponent()
              }
              .tabBar(this.BuildTabs($r('app.media.ic_public_home_filled'), $r('app.string.tab_bar_home'), 0))

              TabContent() {
              }
              .tabBar(this.BuildTabs($r('app.media.ic_public_cards_filled'), $r('app.string.tab_bar_card'), 1))

              TabContent() {
              }
              .tabBar(this.BuildTabs($r('app.media.ic_home_fortunes'), $r('app.string.tab_bar_fortunes'), 2))

              TabContent() {
              }
              .tabBar(this.BuildTabs($r('app.media.ic_life_filled'), $r('app.string.tab_bar_life'), 3))

              TabContent() {
              }
              .tabBar(this.BuildTabsMine($r('app.media.ic_home_mine'), $r('app.media.ic_home_mine_filled'),
                $r('app.string.tab_bar_mine'), 4))
            }
            .vertical(this.breakPoint === CommonConstants.BREAK_POINT_LG)
            .barWidth(this.breakPoint === CommonConstants.BREAK_POINT_LG ?
              $r('app.float.tab_bar_width') : CommonConstants.TAB_BAR_HEIGHT_PERCENT)
            .barHeight(this.breakPoint === CommonConstants.BREAK_POINT_LG ?
            CommonConstants.TAB_HEIGHT_PERCENT : 0)
            .backgroundColor($r('app.color.home_background'))
            .scrollable(false)
            .onChange((index: number) => {
              this.currentTabIndex = index;
            })
          }
        }
      }
    }
    .hideTitleBar(true)
    .onWillShow(() => {
      AppStorage.setOrCreate('allFund', FundingViewModel.getAllFundInfo());
      window.getLastWindow(getContext(this)).then((windowStage: window.Window) => {
        let sysBarProps: window.SystemBarProperties = {
          statusBarColor: '#FFFFFF'
        };
        windowStage.setWindowSystemBarProperties(sysBarProps);
      })
    })
    .onWillDisappear(() => {
      window.getLastWindow(getContext(this)).then((windowStage: window.Window) => {
        let sysBarProps: window.SystemBarProperties = {
          statusBarColor: '#00ffffff'
        };
        windowStage.setWindowSystemBarProperties(sysBarProps);
      })
    })
  }
}