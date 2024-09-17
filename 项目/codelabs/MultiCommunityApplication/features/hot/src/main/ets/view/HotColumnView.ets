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

import { BreakpointConstants as Breakpoint, CommonConstants as BaseCommon, BreakpointType } from '@ohos/base';
import { HotItemInterface, HOST_LIST_ARRAY } from '@ohos/base';
import { HotListItemView } from '@ohos/rank';
import { CommonConstants as Common } from '../constants/CommonConstants';
import { ToRankView } from './ToRankView';

const SWIPER_LIST: number[] = [0, 1, 2];

@Component
export struct HotColumnView {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = Breakpoint.BREAKPOINT_SM;
  @State tab_index: number = 0;

  @Builder
  HotListBuilder(index: number) {
    List() {
      ForEach(HOST_LIST_ARRAY[this.tab_index], (item: HotItemInterface) => {
        if (item.index > index * Common.HOT_COLUMN_MAX_COUNT &&
          item.index <= (index + 1) * Common.HOT_COLUMN_MAX_COUNT) {
          ListItem() {
            HotListItemView({
              item: item,
              showDetail: true,
              indexWidth: item.index <= Common.HOT_COLUMN_MAX_COUNT ? $r('app.float.index_width_normal') :
                $r('app.float.index_width_more'),
              indexIconGap: $r('app.float.index_icon_gap')
            })
          }
        }
      }, (item: HotItemInterface) => JSON.stringify(item))
    }
  }

  build() {
    Column() {
      Swiper() {
        ForEach(SWIPER_LIST, (item: number) => {
          this.HotListBuilder(item)
        }, (item: number) => JSON.stringify(item))
      }
      .autoPlay(false)
      .indicator(false)
      .disableSwipe(true)
      .displayCount(new BreakpointType(
        Common.SWIPER_DISPLAY_COUNT_ONE,
        Common.SWIPER_DISPLAY_COUNT_TWO,
        Common.SWIPER_DISPLAY_COUNT_THREE
      ).getValue(this.currentBreakpoint))
      .itemSpace((new BreakpointType(Common.HOT_COLUMN_IS_SM, Common.HOT_COLUMN_IS_MD, Common.HOT_COLUMN_IS_LG))
        .getValue(this.currentBreakpoint))

      ToRankView()
    }
    .width(BaseCommon.FULL_PERCENT)
    .alignItems(HorizontalAlign.Start)
  }
}