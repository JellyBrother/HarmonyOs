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

import { BreakpointConstants as Breakpoint, CommonConstants as Common } from '@ohos/base';
import { DetailPage } from '@ohos/detail';
import { HotRankPage } from '@ohos/rank';
import { PictureDetail } from '@ohos/picture';
import { TabContentView } from '../view/TabContentView';

@Entry
@Component
struct Index {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = Breakpoint.BREAKPOINT_LG;
  @StorageLink('pageInfos') pageInfos: NavPathStack = new NavPathStack();

  aboutToAppear(): void {
    this.pageInfos.pushPath({ name: 'mainPage' });
  }

  @Builder
  pageMap(name: string, param: number) {
    if ('rankPage' === name) {
      NavDestination() {
        HotRankPage()
      }
      .hideTitleBar(true)
    } else if ('mainPage' === name) {
      NavDestination() {
        Column() {
          TabContentView()
        }
        .width(Common.FULL_PERCENT)
        .height(Common.FULL_PERCENT)
      }
      .hideTitleBar(true)
    } else if ('detailPage' === name) {
      NavDestination() {
        DetailPage()
      }
      .onBackPressed(()=>{
        AppStorage.setOrCreate('isDetailPage', false);
        return false;
      })
      .hideTitleBar(true)
    } else if ('pictureDetail' === name) {
      NavDestination() {
        PictureDetail({ index: param })
      }
      .hideTitleBar(true)
    }
  }

  build() {
    Navigation(this.pageInfos)
      .hideNavBar(true)
      .navDestination(this.pageMap)
      .width(Common.FULL_PERCENT)
      .height(Common.FULL_PERCENT)
  }
}