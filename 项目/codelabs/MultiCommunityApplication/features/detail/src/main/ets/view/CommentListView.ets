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

import { BreakpointConstants as Breakpoint, CommonConstants as BaseCommon, CommentItemInterface, } from '@ohos/base';
import { CommonConstants as Common } from '../constants/CommonConstants';
import { CommentItemView } from '../view/CommentItemView';
import { CommentBarView } from '../view/CommentBarView';
import { CardArray } from '../viewmodel/CardArrayViewModel';
import CardArrayViewModel from '../viewmodel/CardArrayViewModel';

@Component
export struct CommentListView {
  @StorageLink('isFoldHorizontal') isFoldHorizontal: boolean = true;
  @StorageLink('currentBreakpoint') currentBreakpoint: string = Breakpoint.BREAKPOINT_SM;
  @StorageLink('cardArrayViewModel') cardArrayViewModel: CardArray = CardArrayViewModel.getInstance();
  @StorageProp('selectCardIndex') selectCardIndex: number = 0;
  focusHide?: boolean = false;
  commentPadding?: ResourceStr;
  isDarkMode: boolean = false;

  @Builder
  itemHead() {
    Row() {
      Text($r('app.string.comment_list_title'))
        .fontSize($r('app.float.comment_list_title_fs'))
        .fontWeight(BaseCommon.FONT_WEIGHT_500)
        .width(BaseCommon.FULL_PERCENT)
        .fontColor(this.isDarkMode ? Color.White : Color.Black)
    }
    .width(BaseCommon.FULL_PERCENT)
    .height($r('app.float.comment_list_title_height'))
    .padding({
      top: $r('app.float.tab_bar_padding_top')
    })
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.Start }) {
        TabContent() {
          List({ space: Common.LIST_ITEM_SPACE }) {
            ForEach(this.cardArrayViewModel.cardArray[this.selectCardIndex].commentList,
              (item: CommentItemInterface) => {
                ListItem() {
                  CommentItemView({
                    commentItem: item,
                    authorName: this.cardArrayViewModel.cardArray[this.selectCardIndex].name,
                    isDarkMode: this.isDarkMode
                  })
                }
              }, (item: CommentItemInterface, index: number) => index + JSON.stringify(item))
          }
          .nestedScroll({
            scrollForward: (this.isFoldHorizontal && this.currentBreakpoint === Breakpoint.BREAKPOINT_MD) ?
              NestedScrollMode.PARENT_FIRST : NestedScrollMode.PARENT_FIRST,
            scrollBackward: NestedScrollMode.SELF_FIRST
          })
          .scrollBar(BarState.Off)
          .edgeEffect(EdgeEffect.None)
          .margin({
            top: $r('app.float.tab_content_margin_top')
          })
        }
        .tabBar(this.itemHead())
        .align(Alignment.Top)
      }
      .vertical(false)
      .layoutWeight(1)
      .padding({
        left: this.commentPadding ?? this.getPadding(),
        right: this.commentPadding ?? this.getPadding()
      })

      CommentBarView()
        .visibility(this.isShow() ? Visibility.Visible : Visibility.None)
    }
    .justifyContent(FlexAlign.End)
  }

  isShow(): boolean {
    if (this.focusHide) {
      return false;
    }
    if ((this.currentBreakpoint === Breakpoint.BREAKPOINT_MD && this.isFoldHorizontal) ||
      (this.currentBreakpoint === Breakpoint.BREAKPOINT_LG)) {
      return true;
    }
    return false;
  }

  getPadding(): Resource {
    if (this.currentBreakpoint === Breakpoint.BREAKPOINT_SM) {
      return $r('app.float.window_padding_left_sm');
    }
    if (this.currentBreakpoint === Breakpoint.BREAKPOINT_MD) {
      if (this.isFoldHorizontal) {
        return $r('app.float.window_padding_left_sm');
      } else {
        return $r('app.float.window_padding_left_md');
      }
    }
    return $r('app.float.window_padding_left_lg');
  }
}