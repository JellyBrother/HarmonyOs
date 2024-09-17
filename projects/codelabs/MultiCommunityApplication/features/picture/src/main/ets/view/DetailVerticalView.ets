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
import { CommonConstants as BaseCommon, BreakpointConstants as Breakpoint } from '@ohos/base'
import { MircoBlogView, CommentListView, CommentBarView, CardArrayViewModel, CardArray } from '@ohos/detail';

@Component
export struct DetailVertical {
  @StorageLink('cardArrayViewModel') cardArrayViewModel: CardArray = CardArrayViewModel.getInstance();
  @StorageProp('selectCardIndex') selectCardIndex: number = 0;
  @StorageLink('currentBreakpoint') currentBreakpoint: string = Breakpoint.BREAKPOINT_SM;

  build() {
    Column() {
      Scroll() {
        Column() {
          MircoBlogView({
            cardItem: this.cardArrayViewModel.cardArray[this.selectCardIndex],
            index: this.selectCardIndex,
            showPicture: false,
            isDarkMode: true
          })
            .padding({
              left: $r('app.float.picture_content_padding'),
              right: $r('app.float.picture_content_padding')
            })
            .margin({
              top: $r('app.float.detail_padding_top_md')
            })

          CommentListView({
            focusHide: true,
            commentPadding: $r('app.float.picture_content_padding'),
            isDarkMode: true
          })
            .margin({
              top: $r('app.float.picture_comment_list_mt')
            })
        }
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)

      CommentBarView({
        isDarkMode: true
      })
    }
    .height(BaseCommon.FULL_PERCENT)
    .padding({
      top: this.getPaddingTop()
    })
    .backgroundColor($r('app.color.picture_background_color'))
  }

  getPaddingTop(): Resource {
    if (this.currentBreakpoint === Breakpoint.BREAKPOINT_LG && deviceInfo.deviceType !== BaseCommon.DEVICE_2IN1) {
      return $r('app.float.detail_padding_top_md');
    }
    return $r('app.float.zero');
  }
}