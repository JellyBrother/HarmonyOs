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

import { BreakpointConstants, CommonConstants } from '@ohos/commons';
import { BreakpointType } from '@ohos/commons';
import { HomeConstants } from '../constants/HomeConstants';
import { IconViewModel, VideoIcon } from '../viewmodel/IconViewModel';
import { getTabIndex } from './CommonView';

@Component
export struct IconView {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @StorageLink('windowWidth') windowWidth: number = 0;
  @StorageLink('currentTopIndex') currentTopIndex: number = 0;
  private iconList: VideoIcon[] = new IconViewModel().getIconList();

  @Styles focusedStyles(): void {
    .border({
      width: $r('app.float.focus_radius_width'),
      color: $r('app.color.focus_radius_color'),
      radius: $r('app.float.icon_focus_radius')
    })
  }

  @Styles normalStyles(): void {
    .border({
      width: 0,
      radius: $r('app.float.icon_focus_radius')
    })
  }

  build() {
    // Icon swiper.
    Column() {
      Swiper() {
        ForEach(this.iconList, (item: VideoIcon, index: number) => {
          Column() {
            Image(item.getImage())
              .width($r('app.float.icon_img_size'))
              .height($r('app.float.icon_img_size'))
              .margin({ bottom: $r('app.float.icon_img_bottom_margin') })
              .focusable(true)
              .groupDefaultFocus(index === 0 ? true : false)
              .stateStyles({
                normal: this.normalStyles,
                focused: this.focusedStyles
              })

            Text(item.getName())
              .fontSize($r('app.float.icon_list_font_size'))
              .fontWeight(FontWeight.Normal)
              .lineHeight($r('app.float.icon_list_font_height'))
              .fontColor(this.currentTopIndex === 2 ? Color.White : Color.Black)
          }
          .alignItems(HorizontalAlign.Center)
          .height($r('app.float.icon_list_height'))
        }, (item: VideoIcon) => JSON.stringify(item))
      }
      .tabIndex(getTabIndex(HomeConstants.DIRECTION_LIST[3]))
      // The number of different breakpoints is different.
      .displayCount(new BreakpointType(CommonConstants.FOUR, HomeConstants.SIX, HomeConstants.EIGHT)
        .getValue(this.currentBreakpoint))
      .nextMargin(this.getNextMargin(this.windowWidth, this.currentBreakpoint))
      .indicator(false)
      .width(CommonConstants.FULL_PERCENT)
      .loop(false)
      .effectMode(EdgeEffect.None)
      .displayMode(SwiperDisplayMode.AUTO_LINEAR)
    }
    .padding({
      left: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? $r('app.float.icon_list_column_padding_lg') :
        $r('app.float.icon_list_column_padding')
    })
    .margin({ top: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
      $r('app.float.icon_list_column_margin_lg') : $r('app.float.icon_list_column_margin') })
    .visibility(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG && this.currentTopIndex === 2 ?
      Visibility.None : Visibility.Visible)
  }

  getNextMargin(windowWidth: number, currentBreakpoint: string): string {
    // Obtain the window width and subtract the blank parts on both sides.
    let result: number = px2vp(windowWidth) - new BreakpointType(HomeConstants.VIDEO_GRID_MARGIN[0],
      HomeConstants.VIDEO_GRID_MARGIN[1], HomeConstants.VIDEO_GRID_MARGIN[2]).getValue(this.currentBreakpoint) /
      HomeConstants.TWO;
    if (currentBreakpoint === BreakpointConstants.BREAKPOINT_SM) {
      result = result / HomeConstants.DISPLAYED_ICON_NUMBER[0];
    } else if (currentBreakpoint === BreakpointConstants.BREAKPOINT_MD) {
      result = result / HomeConstants.DISPLAYED_ICON_NUMBER[1];
    } else {
      result = (result - HomeConstants.LG_SIDEBAR_WIDTH) / HomeConstants.DISPLAYED_ICON_NUMBER[2];
    }
    return result + HomeConstants.HEIGHT_UNIT;
  }
}