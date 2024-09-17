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

import { BreakpointConstants, CommonConstants, ResourceUtil } from '@ohos/commons';
import { Categories } from './Categories';
import { FlashSale } from './FlashSale';
import { HomeHeader } from './HomeHeader';
import { RecommendedProductView } from './RecommendedProductView';
import { Selection } from './Selection';
import { WelfareView } from './WelfareView';

@Component
export struct HomeContent {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  private scroller: Scroller = new Scroller();

  build() {
    Column() {
      HomeHeader()

      Scroll(this.scroller) {
        Column() {
          Categories()

          Column() {
            RecommendedProductView()
            WelfareView()
            Selection()
            FlashSale()
          }
          .width(CommonConstants.FULL_PERCENT)
          .justifyContent(FlexAlign.Start)
          .padding({ right: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint) })
        }
        .width(CommonConstants.FULL_PERCENT)
        .justifyContent(FlexAlign.Start)
      }
      .width(CommonConstants.FULL_PERCENT)
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .backgroundColor(ResourceUtil.getCommonBackgroundColor()[0])
    .padding({
      left: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint)
    })
    .height(CommonConstants.FULL_PERCENT)
    .width(CommonConstants.FULL_PERCENT)
  }
}