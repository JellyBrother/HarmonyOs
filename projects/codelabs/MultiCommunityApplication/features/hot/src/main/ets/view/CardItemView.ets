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

import { App as app } from '@kit.ArkUI';
import { BreakpointConstants as Breakpoint, CommonConstants as BaseCommon, BreakpointType } from '@ohos/base';
import { CommonConstants as Common } from '../constants/CommonConstants'
import { FollowItemInterface, FOLLOW_LIST, TITLE_DETAIL_LIST } from '../model/FollowModel';

@Preview
@Component
export struct CardItemView {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = Breakpoint.BREAKPOINT_SM;
  @State index: number = 0;
  item: FollowItemInterface = FOLLOW_LIST[0];
  name: string = '';

  aboutToAppear(): void {
    app.setImageRawDataCacheSize(1024*1024*100);
    app.setImageCacheCount(100);
  }

  build() {
    Column() {
      Row() {
        Row() {
          Image(this.index === 0 ? this.item.icon : TITLE_DETAIL_LIST[this.index].icon)
            .width($r('app.float.follow_item_icon_width'))
            .aspectRatio(1)
            .borderRadius($r('app.float.follow_item_icon_br'))
            .autoResize(true)

          Column() {
            Text(this.index === 0 ? this.item.name : TITLE_DETAIL_LIST[this.index].name)
              .fontSize($r('app.float.follow_item_title_fs'))
              .fontWeight(BaseCommon.FONT_WEIGHT_500)

            Text(this.item.date)
              .fontSize($r('app.float.follow_item_date_fs'))
              .fontColor($r('app.color.follow_item_date_fc'))
          }
          .alignItems(HorizontalAlign.Start)
          .margin({
            left: $r('app.float.follow_item_title_ml')
          })
        }

        Image($r('app.media.ic_point_more'))
          .width($r('app.float.follow_item_more_width'))
          .aspectRatio(1)
      }
      .width(BaseCommon.FULL_PERCENT)
      .justifyContent(FlexAlign.SpaceBetween)

      Stack() {
        Image(this.item.picture)
          .width(BaseCommon.FULL_PERCENT)
          .objectFit(ImageFit.Cover)
          .autoResize(true)

        Row() {
          Text(this.item.type)
            .fontSize($r('app.float.follow_item_type_fs'))
            .fontColor(Color.White)

          Divider()
            .vertical(true)
            .width($r('app.float.follow_item_divider_width'))
            .height($r('app.float.follow_item_divider_height'))
            .margin({
              left: $r('app.float.follow_item_divider_ml'),
              right: $r('app.float.follow_item_divider_ml')
            })
            .color(Color.White)

          Text(this.item.subType)
            .fontSize($r('app.float.follow_item_type_fs'))
            .fontColor(Color.White)
        }
        .backgroundColor($r('app.color.follow_item_type_bgc'))
        .padding({
          left: $r('app.float.follow_item_type_pl'),
          right: $r('app.float.follow_item_type_pl'),
          top: $r('app.float.follow_item_type_pt'),
          bottom: $r('app.float.follow_item_type_pt')
        })
        .borderRadius($r('app.float.follow_item_type_br'))
        .margin({
          left: $r('app.float.follow_item_type_margin'),
          bottom: $r('app.float.follow_item_type_margin')
        })
      }
      .alignContent(Alignment.BottomStart)
      .margin({
        top: $r('app.float.follow_item_picture_margin'),
        bottom: $r('app.float.follow_item_picture_margin')
      })
      .constraintSize({
        maxHeight: Common.FOLLOW_ITEM_PICTURE_MAX_HEIGHT
      })

      Row() {
        Text(this.item.content)
          .maxLines(1)
          .layoutWeight(1)
          .textOverflow({
            overflow: TextOverflow.Ellipsis
          })
          .fontColor($r('app.color.follow_item_content_fc'))
          .fontSize($r('app.float.follow_item_content_fs'))

        Text($r('app.string.read_total'))
          .fontColor($r('app.color.follow_item_content_total_fc'))
          .fontSize($r('app.float.follow_item_content_fs'))
          .fontWeight(BaseCommon.FONT_WEIGHT_500)
          .margin({
            left: $r('app.float.follow_item_content_total_ml')
          })
      }
      .width(BaseCommon.FULL_PERCENT)

      Row() {
        Row() {
          Image($r('app.media.ic_toolbar_share'))
            .height($r('app.float.follow_item_share_height'))
            .aspectRatio(1)

          Text(`${this.item.shareCount}`)
            .fontSize($r('app.float.follow_item_share_fs'))
            .fontColor($r('app.color.follow_item_share_fc'))
            .margin({
              left: $r('app.float.follow_item_share_ml')
            })
        }

        Row() {
          Image($r('app.media.ic_toolbar_comment'))
            .height($r('app.float.follow_item_share_height'))
            .aspectRatio(1)

          Text(`${this.item.viewCount}`)
            .fontSize($r('app.float.follow_item_share_fs'))
            .fontColor($r('app.color.follow_item_share_fc'))
            .margin({
              left: $r('app.float.follow_item_share_ml')
            })
        }

        Row() {
          Image($r('app.media.ic_toolbar_heart'))
            .height($r('app.float.follow_item_share_height'))
            .aspectRatio(1)

          Text(`${this.item.favourCount}`)
            .fontSize($r('app.float.follow_item_share_fs'))
            .fontColor($r('app.color.follow_item_share_fc'))
            .margin({
              left: $r('app.float.follow_item_share_ml')
            })
        }
      }
      .width(BaseCommon.FULL_PERCENT)
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({
        top: $r('app.float.follow_item_share_mt')
      })
    }
    .padding({
      top: $r('app.float.follow_item_margin_top'),
      left: new BreakpointType($r('app.float.follow_item_sm_ml'), $r('app.float.follow_item_md_ml'),
        $r('app.float.follow_item_lg_ml')).getValue(this.currentBreakpoint),
      right: new BreakpointType($r('app.float.follow_item_sm_ml'), $r('app.float.follow_item_md_ml'),
        $r('app.float.follow_item_lg_ml')).getValue(this.currentBreakpoint),
      bottom: $r('app.float.follow_item_margin_bottom')
    })
    .borderRadius($r('app.float.follow_item_border_radius'))
    .backgroundColor(Color.White)
  }
}