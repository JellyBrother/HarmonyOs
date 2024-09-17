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
import { SearchConstants } from '../constants/SearchConstants';
import { SearchVideoImg } from '../viewmodel/SearchVideoImgViewModel';

@Component
export struct SearchContent {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @State currentIndex: number = 0;
  @Link searchVideoList: SearchVideoImg[];

  build() {
    Scroll() {
      Column() {
        this.searchHistory()
        this.searchDiscovery()
        this.searchHotTrending()
      }
      .alignItems(HorizontalAlign.Start)
      .width(CommonConstants.FULL_PERCENT)
    }
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Off)
  }

  @Builder
  searchHistory() {
    Row() {
      Text(SearchConstants.SEARCH_SUB_TITLES[0])
        .fontSize($r('app.float.search_history_title_font'))
        .fontWeight(CommonConstants.FONT_WEIGHT_500)
      Blank()
      Image($r('app.media.ic_public_delete'))
        .height($r('app.float.search_history_img_size'))
        .width($r('app.float.search_history_img_size'))
        .opacity(CommonConstants.TEXT_OPACITY[4])
    }
    .margin({ top: $r('app.float.search_history_title_margin') })
    .width(CommonConstants.FULL_PERCENT)
    .height($r('app.float.search_history_title_height'))

    Row() {
      this.searchContent()
      this.searchContent()
    }
    .width(CommonConstants.FULL_PERCENT)
    .height($r('app.float.search_history_content_height'))
    .margin({ top: $r('app.float.search_history_content_margin') })
  }

  @Builder
  searchContent() {
    Row() {
      Text(SearchConstants.SEARCH_SUB_TITLES[1])
        .fontSize($r('app.float.search_history_content_font'))
        .fontWeight(CommonConstants.FONT_WEIGHT_500)
    }
    .justifyContent(FlexAlign.Center)
    .width($r('app.float.search_history_content_row_width'))
    .height($r('app.float.search_history_content_row_height'))
    .borderRadius($r('app.float.search_history_content_row_radius'))
    .backgroundColor($r('app.color.result_background'))
    .margin({ right: new BreakpointType($r('app.float.search_content_margin_right_sm'),
      $r('app.float.search_content_margin_right_md'), $r('app.float.search_content_margin_right_lg'))
      .getValue(this.currentBreakpoint) })
  }

  @Builder
  searchDiscovery() {
    Row() {
      Text(SearchConstants.SEARCH_SUB_TITLES[2])
        .fontSize($r('app.float.search_history_title_font'))
        .fontWeight(CommonConstants.FONT_WEIGHT_500)
      Blank()
      Image($r('app.media.ic_public_rotate'))
        .height($r('app.float.search_discovery_img_size'))
        .width($r('app.float.search_discovery_img_size'))
        .margin({ right: $r('app.float.search_discovery_img_margin') })
        .fillColor($r('app.color.type_tabs_font_selected'))
    }
    .height($r('app.float.search_discovery_row_height'))
    .width(CommonConstants.FULL_PERCENT)
    .margin({ top: $r('app.float.search_discovery_img_margin') })

    List() {
      ForEach(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? SearchConstants.SEARCH_DISCOVERY_LARGE :
        SearchConstants.SEARCH_DISCOVERY_LARGE.slice(0, 6), (item: string, index: number) => {
        ListItem() {
          Column() {
            Text(item)
              .fontSize($r('app.float.search_discovery_list_font'))
              .fontWeight(CommonConstants.FONT_WEIGHT_500)
          }
          .padding({ right: this.getDividerPadding(this.currentBreakpoint, index) })
          .height($r('app.float.search_discovery_list_column_height'))
          .width(CommonConstants.FULL_PERCENT)
          .margin({ top: $r('app.float.search_discovery_list_column_margin') })
          .alignItems(HorizontalAlign.Start)
        }
      }, (item: string, index: number) => index + JSON.stringify(item))
    }
    .width(CommonConstants.FULL_PERCENT)
    .lanes(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? SearchConstants.SEARCH_LIST_LANES[0] :
      SearchConstants.SEARCH_LIST_LANES[1])
  }

  @Builder
  searchHotTrending() {
    List({ space: new BreakpointType(SearchConstants.HOT_TRENDING_LIST_SPACES[0],
      SearchConstants.HOT_TRENDING_LIST_SPACES[1], SearchConstants.HOT_TRENDING_LIST_SPACES[2])
      .getValue(this.currentBreakpoint) }) {
      ForEach(SearchConstants.SEARCH_TABS, (item: string, index: number) => {
        ListItem() {
          Column() {
            Text(item)
              .fontSize($r('app.float.hot_trending_font'))
              .lineHeight($r('app.float.hot_trending_line'))
              .fontWeight(CommonConstants.FONT_WEIGHT_500)
              .fontColor(index === this.currentIndex ? $r('app.color.type_tabs_font_selected') : Color.Black)
              .opacity(index !== this.currentIndex ? CommonConstants.TEXT_OPACITY[2] : CommonConstants.TEXT_OPACITY[3])
              .margin({ top: $r('app.float.tabs_font_margin') })

            Divider()
              .strokeWidth(SearchConstants.TYPE_TABS_DIVIDER_STROKE_WIDTH)
              .width($r('app.float.tab_divider_width'))
              .color($r('app.color.type_tabs_font_selected'))
              .visibility(index === this.currentIndex ? Visibility.Visible : Visibility.None)
              .margin({ top: $r('app.float.tabs_divider_margin') })
              .lineCap(LineCapStyle.Round)
          }
          .height($r('app.float.hot_trending_tab_height'))
          .justifyContent(FlexAlign.Start)
        }
        .onClick(() => {
          this.currentIndex = index;
        })
      })
    }
    .margin({ top: $r('app.float.tab_list_margin') })
    .listDirection(Axis.Horizontal)
    .scrollBar(BarState.Off)

    List() {
      ForEach(this.searchVideoList, (item: SearchVideoImg, index: number) => {
        ListItem() {
          Row() {
            Image(item.getImgSrc())
              .height($r('app.float.hot_video_img_size'))
              .width($r('app.float.hot_video_img_size'))
              .margin({ right: $r('app.float.hot_video_img_margin') })

            Column() {
              Text(item.getTitle())
                .fontSize($r('app.float.hot_video_title_font'))
                .fontWeight(CommonConstants.FONT_WEIGHT_500)
                .lineHeight($r('app.float.hot_video_title_line'))
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .margin({ top: $r('app.float.hot_video_title_margin') })
              Text(item.getContent())
                .fontSize($r('app.float.hot_video_content_font'))
                .fontWeight(FontWeight.Normal)
                .lineHeight($r('app.float.hot_video_content_line'))
                .opacity(CommonConstants.TEXT_OPACITY[0])
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .margin({ top: $r('app.float.hot_video_content_margin') })
              Divider()
                .strokeWidth(SearchConstants.DIVIDER_STROKE_WIDTH)
                .width(CommonConstants.FULL_PERCENT)
                .opacity(CommonConstants.DIVIDER_OPACITY)
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)
          }
          .width(CommonConstants.FULL_PERCENT)
          .height(CommonConstants.FULL_PERCENT)
        }
        .height($r('app.float.hot_video_row_height'))
      }, (item: SearchVideoImg, index: number) => index + JSON.stringify(item))
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(this.currentBreakpoint !== BreakpointConstants.BREAKPOINT_LG ? $r('app.float.hot_video_list_height_sm') :
      $r('app.float.hot_video_list_height'))
    .lanes(new BreakpointType(SearchConstants.SEARCH_LIST_LANES[2], SearchConstants.SEARCH_LIST_LANES[1],
      SearchConstants.SEARCH_LIST_LANES[0]).getValue(this.currentBreakpoint), $r('app.float.hot_video_list_lane_space'))
    .padding({
      top: $r('app.float.hot_video_list_padding'),
      bottom: $r('app.float.hot_video_list_padding')
    })
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.None)
  }

  getDividerPadding(breakpoint: string, index: number): string {
    if (breakpoint === BreakpointConstants.BREAKPOINT_LG) {
      if (index % SearchConstants.SEARCH_LIST_LANES[0] !== 2) {
        return SearchConstants.SEARCH_RECOMMEND_DIVIDER_PADDING;
      }
    } else {
      if (index % SearchConstants.SEARCH_LIST_LANES[1] === 0) {
        return SearchConstants.SEARCH_RECOMMEND_DIVIDER_PADDING;
      }
    }
    return '0';
  }
}