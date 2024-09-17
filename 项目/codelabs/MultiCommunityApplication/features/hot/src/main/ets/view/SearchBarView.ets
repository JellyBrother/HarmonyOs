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

import { BreakpointConstants as Breakpoint, CommonConstants as BaseCommon } from '@ohos/base';
import { CommonConstants as Common } from '../constants/CommonConstants';

@Component
export struct SearchBarView {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = Breakpoint.BREAKPOINT_SM;

  build() {
    if (this.currentBreakpoint === Breakpoint.BREAKPOINT_SM) {
      Row() {
        Image($r('app.media.ic_public_input_search'))
          .width($r('app.float.input_search_icon_width'))
          .aspectRatio(1)
      }
    } else {
      Row() {
        Row() {
          Image($r('app.media.ic_public_search'))
            .height($r('app.float.icon_search_height'))
            .aspectRatio(1)
            .margin({ left: $r('app.float.icon_search_ml') })

          TextInput({ placeholder: $r('app.string.placeholder') })
            .layoutWeight(1)
            .backgroundColor($r('app.color.acetate'))
            .padding({ left: $r('app.float.zero') })
            .margin({ left: $r('app.float.search_input_margin_left') })
            .enableKeyboardOnFocus(false)

          Image($r('app.media.ic_public_voice'))
            .height($r('app.float.icon_voice_height'))
            .aspectRatio(1)
            .margin({ left: $r('app.float.icon_voice_ml') })

          Image($r('app.media.ic_public_spinner_small'))
            .width($r('app.float.spinner_small_width'))
            .height($r('app.float.spinner_small_height'))
            .margin({ right: $r('app.float.spinner_small_ml') })
        }
        .backgroundColor($r('app.color.white'))
        .borderRadius($r('app.float.search_bar_br'))
        .borderWidth($r('app.float.search_bar_bw'))
        .height($r('app.float.search_bar_height'))
        .width(BaseCommon.FULL_PERCENT)
        .margin({
          top: $r('app.float.search_bar_mt'),
          bottom: $r('app.float.search_bar_mt')
        })
        .opacity(Common.SEARCH_BAR_OPACITY)
      }
      .alignItems(VerticalAlign.Center)
    }
  }
}