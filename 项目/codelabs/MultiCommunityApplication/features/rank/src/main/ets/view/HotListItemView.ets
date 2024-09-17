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

import { HotItemInterface, HOST_LIST_ARRAY, CommonConstants as BaseCommon } from '@ohos/base';
import { CommonConstants as Common } from '../constants/CommonConstants';

@Component
export struct HotListItemView {
  item: HotItemInterface = HOST_LIST_ARRAY[0][0];
  showDetail: boolean = false;
  indexWidth: ResourceStr = $r('app.float.index_width_normal');
  indexIconGap: ResourceStr = $r('app.float.index_icon_gap_normal');

  build() {
    Row() {
      Row() {
        Text(`${this.item.index}`)
          .fontSize($r('app.float.index_font_size'))
          .fontWeight(BaseCommon.FONT_WEIGHT_500)
          .fontColor(this.isTopThree() ? $r('app.color.top_three_color') : $r('app.color.normal_index_color'))
          .textAlign(TextAlign.End)
          .width(this.indexWidth)

        Row() {
          if (this.isShowDetail()) {
            Image(this.item.icon)
              .width($r('app.float.list_item_icon_width'))
              .aspectRatio(1)
              .borderRadius($r('app.float.item_icon_br'))
          }

          Column({ space: Common.TITLE_CONTENT_SPACE }) {
            Row() {
              Text(this.item.title)
                .fontSize($r('app.float.rank_item_font_size'))
                .fontWeight(FontWeight.Normal)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })

              Image(this.item.stateIcon)
                .height($r('app.float.state_icon_height'))
                .aspectRatio(1)
                .margin({ left: $r('app.float.state_icon_margin_left') })
            }
            .justifyContent(FlexAlign.Start)

            Text(this.item.content)
              .fontSize($r('app.float.content_font_size'))
              .fontWeight(FontWeight.Normal)
              .fontColor($r('app.color.content_color'))
              .visibility(this.isShowDetail() ? Visibility.Visible : Visibility.None)
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
          }
          .alignItems(HorizontalAlign.Start)
          .margin({
            left: this.isShowDetail() ? Common.WINDOW_PADDING_HALF_SM : $r('app.float.zero')
          })
          .layoutWeight(1)
        }
        .layoutWeight(1)
        .margin({ left: this.indexIconGap })
        .justifyContent(FlexAlign.Start)

        Row() {
          Text(`${this.item.clickCount}`)
            .fontSize($r('app.float.click_count_font_size'))
            .fontWeight(FontWeight.Normal)
            .textAlign(TextAlign.End)
            .fontColor($r('app.color.click_count_color'))

          Image(this.item.upDownIcon)
            .width($r('app.float.up_down_icon_width'))
            .aspectRatio(1)
        }
        .height(BaseCommon.FULL_PERCENT)
        .borderRadius($r('app.float.rank_list_rd'))
        .margin({
          right: $r('app.float.icon_name_margin_left')
        })
      }
      .height(BaseCommon.FULL_PERCENT)
      .width(BaseCommon.FULL_PERCENT)
    }
    .width(BaseCommon.FULL_PERCENT)
    .height((this.isShowDetail()) ? $r('app.float.top_three_height') : $r('app.float.normal_item_height'))
  }

  isShowDetail(): boolean {
    return this.showDetail || this.isTopThree();
  }

  isTopThree(): boolean {
    return this.item.index <= Common.TOP_COUNT;
  }
}