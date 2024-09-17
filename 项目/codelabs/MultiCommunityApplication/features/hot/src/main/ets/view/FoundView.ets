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
import { CommentBarView, MircoBlogView } from '@ohos/detail';
import { CardArrayViewModel, CardArray } from '@ohos/detail';
import { CardItem } from '@ohos/detail';
import { CommonConstants as Common } from '../constants/CommonConstants';
import { HotColumnView } from '../view/HotColumnView';

@Component
export struct FoundView {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = Breakpoint.BREAKPOINT_SM;
  @StorageLink('cardArrayViewModel') cardArrayViewModel: CardArray = CardArrayViewModel.getInstance();
  @StorageLink('pageInfos') pageInfos: NavPathStack = new NavPathStack();
  @State tabIndexSelected: number = 0;

  jumpDetail() {
    this.pageInfos.pushPath({name : 'detailPage'});
  }

  @Builder
  TitleBarBuilder() {
    Row() {
      List({
        space: new BreakpointType(Common.WINDOW_PADDING_SM, Common.WINDOW_PADDING_MD,
          Common.WINDOW_PADDING_LG).getValue(this.currentBreakpoint)
      }) {
        ForEach(BaseCommon.RANK_TITLE_LIST, (item: string, index: number) => {
          ListItem() {
            Text(item)
              .fontSize($r('app.float.rank_name_fs'))
              .fontWeight(BaseCommon.FONT_WEIGHT_500)
              .fontColor(this.tabIndexSelected === index ? $r('app.color.tab_selected') : $r('app.color.tab_normal'))
              .height($r('app.float.rank_name_height'))
              .onClick(() => {
                this.tabIndexSelected = index;
              })
          }
        }, (item: string, index: number) => index + JSON.stringify(item))
      }
      .listDirection(Axis.Horizontal)
      .height($r('app.float.rank_title_height'))
      .alignListItem(ListItemAlign.Center)
      .scrollBar(BarState.Off)
    }
    .width(BaseCommon.FULL_PERCENT)
    .justifyContent(this.currentBreakpoint !== Breakpoint.BREAKPOINT_SM ? FlexAlign.SpaceBetween : FlexAlign.Start)
    .padding({
      left: new BreakpointType($r('app.float.window_padding_left_sm'), $r('app.float.window_padding_left_md'),
        $r('app.float.window_padding_left_lg')).getValue(this.currentBreakpoint),
      right: new BreakpointType($r('app.float.window_padding_left_sm'), $r('app.float.window_padding_left_md'),
        $r('app.float.window_padding_left_lg')).getValue(this.currentBreakpoint),
      top: $r('app.float.tab_bar_padding_top')
    })
  }

  build() {
    Scroll() {
      Column() {
        this.TitleBarBuilder()

        Tabs({ index: this.tabIndexSelected, barPosition: BarPosition.Start }) {
          ForEach(BaseCommon.RANK_TITLE_LIST, (item: string) => {
            TabContent() {
              HotColumnView({
                tab_index: this.tabIndexSelected
              })
            }
          }, (item: string) => JSON.stringify(item))
        }
        .barMode(BarMode.Scrollable, { margin: $r('app.float.tab_bar_mode_margin') })
        .barHeight($r('app.float.tab_bar_height'))
        .animationDuration(Common.TAB_ANIMATION_DURATION)
        .scrollable(false)
        .barHeight($r('app.float.zero'))
        .height($r('app.float.rank_list_height'))
        .padding({
          left: new BreakpointType($r('app.float.window_padding_left_sm'), $r('app.float.window_padding_left_md'),
            $r('app.float.window_padding_left_lg')).getValue(this.currentBreakpoint),
          right: new BreakpointType($r('app.float.window_padding_left_sm'), $r('app.float.window_padding_left_md'),
            $r('app.float.window_padding_left_lg')).getValue(this.currentBreakpoint)
        })

        Blank()
          .width(BaseCommon.FULL_PERCENT)
          .height($r('app.float.blank_height'))
          .visibility(this.currentBreakpoint === Breakpoint.BREAKPOINT_LG ? Visibility.Hidden : Visibility.Visible)

        WaterFlow() {
          ForEach(this.cardArrayViewModel.cardArray, (item: CardItem, index: number) => {
            FlowItem() {
              Column() {
                MircoBlogView({
                  cardItem: item,
                  index: index,
                  jumpDetail: () => {
                    AppStorage.setOrCreate('selectCardIndex', index);
                    this.jumpDetail();
                  }
                })
                  .padding({
                    left: new BreakpointType($r('app.float.window_padding_left_sm'),
                      $r('app.float.window_padding_left_md'), $r('app.float.window_padding_left_sm'))
                      .getValue(this.currentBreakpoint),
                    right: new BreakpointType($r('app.float.window_padding_left_sm'),
                      $r('app.float.window_padding_left_md'), $r('app.float.window_padding_left_sm'))
                      .getValue(this.currentBreakpoint),
                    top: new BreakpointType($r('app.float.zero'), $r('app.float.zero'),
                      $r('app.float.card_margin_top_lg')).getValue(this.currentBreakpoint)
                  })

                CommentBarView({
                  isShowInput: false,
                  jumpDetail: () => {
                    AppStorage.setOrCreate('selectCardIndex', index);
                    this.jumpDetail();
                  }
                })
              }
              .borderRadius(this.currentBreakpoint === Breakpoint.BREAKPOINT_LG ?
                $r('app.float.water_flow_br') : $r('app.float.zero'))
              .backgroundColor($r('app.color.white'))
              .margin(this.currentBreakpoint === Breakpoint.BREAKPOINT_LG ?
                $r('app.float.water_flow_margin') : $r('app.float.zero'))
            }
          }, (item: CardItem, index: number) => index + JSON.stringify(item))
        }
        .backgroundColor(this.currentBreakpoint === Breakpoint.BREAKPOINT_LG ?
        $r('app.color.water_flow_bgc_lg') : $r('app.color.water_flow_bgc'))
        .linearGradient({
          angle: Common.LINEAR_GRADIENT_ANGEL,
          colors: [
            [Common.LINEAR_GRADIENT_FROM_COLOR, 0],
            [Common.LINEAR_GRADIENT_TO_COLOR, Common.LINEAR_GRADIENT_TO_AREA]
          ]
        })
        .rowsGap(this.currentBreakpoint === Breakpoint.BREAKPOINT_LG ?
        $r('app.float.zero') : $r('app.float.water_flow_rows_gap'))
        .nestedScroll({
          scrollForward: NestedScrollMode.PARENT_FIRST,
          scrollBackward: NestedScrollMode.SELF_FIRST
        })
        .columnsTemplate(this.currentBreakpoint !== Breakpoint.BREAKPOINT_LG ?
        Common.WATER_FLOW_COLUMNS_TEMPLATE_NORMAL : Common.WATER_FLOW_COLUMNS_TEMPLATE_LG)
        .padding({
          left: this.currentBreakpoint === Breakpoint.BREAKPOINT_LG ? $r('app.float.water_flow_padding_lg') :
          $r('app.float.zero'),
          right: this.currentBreakpoint === Breakpoint.BREAKPOINT_LG ? $r('app.float.water_flow_padding_lg') :
          $r('app.float.zero'),
          top: this.currentBreakpoint === Breakpoint.BREAKPOINT_LG ? $r('app.float.water_flow_padding_top_lg') :
          $r('app.float.zero')
        })
      }
    }
    .scrollBar(BarState.Off)
    .layoutWeight(1)
  }
}