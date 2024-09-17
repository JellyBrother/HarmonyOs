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

import { window } from '@kit.ArkUI';
import { BreakpointUtil, CommonConstants, RouterConstants } from '@ohos/basic';
import { AccountPage, AdvertisementDialog, HomeComponent } from '@ohos/home';
import { Funding, FundingDetail, TrendsPage } from '@ohos/fund';
import { ComparisonDetailPage, ComparisonInfo } from '@ohos/fundComparison';

@Entry
@Component
struct Index {
  @StorageLink('breakPoint') breakPoint: string = CommonConstants.BREAK_POINT_SM;
  @State currentTabIndex: number = 0;
  @StorageProp('avoidArea') topHeight: number = 0;
  @StorageProp('bottom') bottom: number = 0;
  @State backgroundImageY: number = 0;
  @StorageLink('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack();
  dialogController: CustomDialogController = new CustomDialogController({
    builder: AdvertisementDialog(),
    backgroundColor: $r('app.color.dialog_background'),
    alignment: DialogAlignment.Center,
    maskColor: $r('app.color.dialog_mask'),
    customStyle: true
  });

  aboutToAppear() {
    this.dialogController.open();
  }

  onPageShow() {
    window.getLastWindow(getContext(this)).then((windowStage: window.Window) => {
      let area = windowStage.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
      let topHeight = px2vp(area.topRect.height);
      let bottomArea = windowStage.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR);
      let bottom = px2vp(bottomArea.bottomRect.height);
      if (topHeight > 0) {
        windowStage.setWindowLayoutFullScreen(true);
        AppStorage.setOrCreate('avoidArea', topHeight);
        AppStorage.setOrCreate('bottom', bottom);
      }
    });
  }

  onPageHide() {
    window.getLastWindow(getContext(this)).then((windowStage: window.Window) => {
      if (this.topHeight > 0) {
        windowStage.setWindowLayoutFullScreen(false);
      }
    });
  }

  getTabBarColor(index: number, currentTabIndex: number, breakPoint: string): ResourceColor {
    if (this.backgroundImageY < -20 && this.currentTabIndex === 0 && index === 0) {
      return $r('app.color.tab_choose_image')
    } else if (index === 0 && breakPoint === CommonConstants.BREAK_POINT_LG) {
      return currentTabIndex === index ? Color.White : $r('app.color.tab_un_image');
    }
    return currentTabIndex === index ? $r('app.color.tab_choose_image') : $r('app.color.tab_un_image');
  }

  @Builder
  BuildTabs(icon: Resource, title: ResourceStr, index: number) {
    Column() {
      Image(icon)
        .width($r('app.float.common_image_width'))
        .height($r('app.float.common_image_height'))
        .fillColor(this.getTabBarColor(index, this.currentTabIndex, this.breakPoint))
      Text(title)
        .fontSize($r('app.float.tab_text_size'))
        .lineHeight($r('app.float.tab_text_height'))
        .fontWeight(FontWeight.Regular)
        .fontColor(this.getTabBarColor(index, this.currentTabIndex, this.breakPoint))
    }
  }

  @Builder
  BuildTabsMine(icon: Resource, unIcon: Resource, title: ResourceStr, index: number) {
    Column() {
      Image(this.currentTabIndex === index ? icon : unIcon)
        .width($r('app.float.common_image_width'))
        .height($r('app.float.common_image_height'))
      Text(title)
        .fontSize($r('app.float.tab_text_size'))
        .lineHeight($r('app.float.tab_text_height'))
        .fontWeight(FontWeight.Regular)
        .fontColor(this.getTabBarColor(index, this.currentTabIndex, this.breakPoint))
    }
  }

  @Builder
  PagesMap(name: string, param?: object) {
    if (name === RouterConstants.FUNDING_URL) {
      Funding()
    } else if (name === RouterConstants.ACCOUNT_PAGE_URL) {
      NavDestination() {
        AccountPage()
      }
      .hideTitleBar(true)
      .onWillShow(() => {
        window.getLastWindow(getContext(this)).then((windowStage: window.Window) => {
          windowStage.setWindowLayoutFullScreen(false);
        })
      })
      .onWillDisappear(() => {
        window.getLastWindow(getContext(this)).then((windowStage: window.Window) => {
          windowStage.setWindowLayoutFullScreen(true);
        })
      })
    } else if (name === RouterConstants.FUNDING_DETAIL_URL) {
      FundingDetail({ index: (param as Record<string, number>)['listIndex'] })
    } else if (name === RouterConstants.TRENDS_PAGE_URL) {
      TrendsPage({ name: (param as Record<string, string>)['name'] })
    } else if (name === RouterConstants.COMPARISON_PAGE_URL) {
      NavDestination() {
        ComparisonDetailPage({ chooseComparison: (param as Record<string, ComparisonInfo[]>)['chooseComparison'] })
      }
      .hideTitleBar(true)
      .onWillShow(() => {
        window.getLastWindow(getContext(this)).then((windowStage: window.Window) => {
          windowStage.setWindowLayoutFullScreen(false);
        })
      })
      .onWillDisappear(() => {
        window.getLastWindow(getContext(this)).then((windowStage: window.Window) => {
          windowStage.setWindowLayoutFullScreen(true);
        })
      })
    }
  }

  build() {
    Navigation(this.pageIndexInfos) {
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
                HomeComponent({
                  currentPoint: this.breakPoint,
                  scrollY: this.backgroundImageY
                })
                  .margin({
                    top: this.topHeight
                  })
              }
              .tabBar(this.BuildTabs($r('app.media.ic_public_home_filled'), $r('app.string.tab_bar_home'), 0))

              TabContent() {
              }
              .tabBar(this.BuildTabs($r('app.media.ic_public_cards_filled'), $r('app.string.tab_bar_card'), 1))
              .backgroundColor(Color.White)

              TabContent() {
              }
              .tabBar(this.BuildTabs($r('app.media.ic_home_fortunes'), $r('app.string.tab_bar_fortunes'), 2))
              .backgroundColor(Color.White)

              TabContent() {
              }
              .tabBar(this.BuildTabs($r('app.media.ic_life_filled'), $r('app.string.tab_bar_life'), 3))
              .backgroundColor(Color.White)

              TabContent() {
              }
              .tabBar(this.BuildTabsMine($r('app.media.ic_home_mine'), $r('app.media.ic_home_mine_filled'),
                $r('app.string.tab_bar_mine'), 4))
              .backgroundColor(Color.White)
            }
            .vertical(this.breakPoint === CommonConstants.BREAK_POINT_LG)
            .barWidth(this.breakPoint === CommonConstants.BREAK_POINT_LG ?
              $r('app.float.tab_bar_width') : CommonConstants.TAB_BAR_HEIGHT_PERCENT)
            .barHeight(this.breakPoint === CommonConstants.BREAK_POINT_LG ?
            CommonConstants.TAB_HEIGHT_PERCENT : $r('app.float.tab_bar_height'))
            .backgroundImage(this.currentTabIndex === 0 ? new BreakpointUtil({
              sm: $r('app.media.ic_home_phone_background'),
              md: $r('app.media.ic_home_fold_background'),
              lg: $r('app.media.ic_home_tablet_background')
            }).getValue(this.breakPoint) : $r('app.media.ic_home_not_background'))
            .backgroundImageSize(ImageSize.Contain)
            .backgroundImagePosition({
              y: this.backgroundImageY
            })
            .backgroundColor($r('app.color.home_background'))
            .scrollable(false)
            .onChange((index: number) => {
              this.currentTabIndex = index;
            })
            .padding({
              bottom: this.bottom
            })
          }
        }
      }
    }
    .mode(NavigationMode.Stack)
    .navDestination(this.PagesMap)
    .height(CommonConstants.FULL_HEIGHT_PERCENT)
    .hideTitleBar(true)
    .hideToolBar(true)
  }
}