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

import { CommonConstants as BaseCommon } from '@ohos/base';
import { CommonConstants as Common } from '../constants/CommonConstants';

const TEXTAREA_KEY: string = 'textarea';
const BUTTON_KEY: string = 'button';

@Component
export struct CommentInputView {
  @State content: string = '';
  darkMode: boolean = true;

  build() {
    Row() {
      TextArea({ placeholder: $r('app.string.detail_write_comment'), text: this.content })
        .key(TEXTAREA_KEY)
        .maxLines(Common.TEXT_AREA_MAX_LINES)
        .constraintSize({
          minHeight: $r('app.float.constraint_size')
        })
        .enableKeyboardOnFocus(true)
        .maxLength(Common.TEXT_AREA_MAX_LENGTH)
        .showCounter(this.content.length === Common.TEXT_AREA_MAX_LENGTH ? true : false)
        .layoutWeight(1)
        .onChange((value: string) => {
          this.content = value;
        })
        .onAppear(() => {
          focusControl.requestFocus(TEXTAREA_KEY);
        })

      Image($r('app.media.ic_toolbar_sent'))
        .width($r('app.float.toolbar_sent_width'))
        .aspectRatio(1)
        .margin({
          left: $r('app.float.toolbar_sent_ml'),
          bottom: $r('app.float.toolbar_sent_mb')
        })
        .key(BUTTON_KEY)
        .onClick(() => {
          AppStorage.setOrCreate('isShowInput', false);
          focusControl.requestFocus(BUTTON_KEY);
        })
    }
    .width(BaseCommon.FULL_PERCENT)
    .padding({
      left: $r('app.float.dialog_pl'),
      right: $r('app.float.dialog_pr'),
      top: $r('app.float.dialog_pt'),
      bottom: $r('app.float.dialog_pt')
    })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Bottom)
    .backgroundColor($r('app.color.white'))
  }
}