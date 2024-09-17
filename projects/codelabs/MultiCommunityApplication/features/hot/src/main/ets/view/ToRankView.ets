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

import { CommonConstants as Common } from '../constants/CommonConstants'

@Component
export struct ToRankView {
  @StorageLink('pageInfos') pageInfos: NavPathStack = new NavPathStack();

  build() {
    Row() {
      Text($r('app.string.read_total_rank'))
        .fontWeight(FontWeight.Normal)
        .fontColor($r('app.color.read_total_rank_color'))
        .fontSize($r('app.float.read_total_rank_fs'))

      Image($r('app.media.ic_more'))
        .width($r('app.float.arrow_right_width'))
        .aspectRatio(1)
        .margin({ left: $r('app.float.arrow_right_ml') })
        .opacity(Common.ICON_MORE_OPACITY)
    }
    .justifyContent(FlexAlign.Start)
    .alignItems(VerticalAlign.Center)
    .margin({ top: $r('app.float.read_total_rank_mt') })
    .onClick(() => {
      this.pageInfos.pushPath({ name: 'rankPage' });
    })
  }
}