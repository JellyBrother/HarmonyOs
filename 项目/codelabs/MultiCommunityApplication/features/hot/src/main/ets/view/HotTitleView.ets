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
import { SearchBarView } from '../view/SearchBarView';

@Component
export struct HotTitleView {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = Breakpoint.BREAKPOINT_SM;
  @StorageLink('isFoundSelected') isFoundSelected: boolean = false;

  build() {
    Column() {
      Stack() {
        Row() {
          Text($r('app.string.found'))
            .fontSize(this.isFoundSelected ? $r('app.float.title_font_size_selected') :
              $r('app.float.title_font_size_normal'))
            .fontWeight(BaseCommon.FONT_WEIGHT_500)
            .fontColor(Color.Black)
            .opacity(this.isFoundSelected ? $r('app.float.title_opacity_selected') :
              $r('app.float.title_opacity_normal'))
            .onClick(()=>{
              this.isFoundSelected = true;
            })

          Text($r('app.string.follow'))
            .fontSize(this.isFoundSelected ? $r('app.float.title_font_size_normal') :
              $r('app.float.title_font_size_selected'))
            .fontWeight(BaseCommon.FONT_WEIGHT_500)
            .fontColor(Color.Black)
            .margin({
              left: new BreakpointType($r('app.float.title_margin_left_sm'), $r('app.float.title_margin_left_md'),
                $r('app.float.title_margin_left_lg')).getValue(this.currentBreakpoint)
            })
            .opacity(this.isFoundSelected ? $r('app.float.title_opacity_normal') :
              $r('app.float.title_opacity_selected'))
            .onClick(()=>{
              this.isFoundSelected = false;
            })
        }
        .width(BaseCommon.FULL_PERCENT)
        .height(BaseCommon.FULL_PERCENT)
        .justifyContent(FlexAlign.Center)

        SearchBarView()
          .width(new BreakpointType($r('app.float.search_bar_view_width_sm'), $r('app.float.search_bar_view_width_md'),
            $r('app.float.search_bar_view_width_lg')).getValue(this.currentBreakpoint))
      }
      .alignContent(Alignment.End)
      .padding({
        left: new BreakpointType($r('app.float.window_padding_left_sm'), $r('app.float.window_padding_left_md'),
          $r('app.float.window_padding_left_lg')).getValue(this.currentBreakpoint),
        right: new BreakpointType($r('app.float.window_padding_left_sm'), $r('app.float.window_padding_left_md'),
          $r('app.float.window_padding_left_lg')).getValue(this.currentBreakpoint)
      })
    }
    .height($r('app.float.hot_title_height'))
    .borderColor($r('app.color.hot_title_border_color'))
    .borderWidth({
      bottom: new BreakpointType($r('app.float.hot_title_border_width_normal'),
        $r('app.float.hot_title_border_width_normal'), $r('app.float.hot_title_border_width_more')
      ).getValue(this.currentBreakpoint)
    })
  }
}