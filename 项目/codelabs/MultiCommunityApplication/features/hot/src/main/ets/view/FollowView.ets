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
import { CommonConstants as Common } from '../constants/CommonConstants'
import { CardItemView } from './CardItemView';
import { TitleDetailInterface, TITLE_DETAIL_LIST } from '../model/FollowModel';
import { FollowItemInterface, FOLLOW_LIST } from '../model/FollowModel';

@Component
export struct FollowView {
  @StorageLink('currentBreakpoint') @Watch('updateShow') currentBreakpoint: string = Breakpoint.BREAKPOINT_SM;
  @StorageLink('isShowHotTitle') @Watch('updateShow') isShowHotTitle: boolean = true;
  @State @Watch('updateShow') indexSelected: number = 0;
  @State @Watch('updateShow') indexTitleSelected: number = -1;
  @State pageInfo: NavPathStack = new NavPathStack();
  iconList: TitleDetailInterface[] = TITLE_DETAIL_LIST;
  iconTitleList: TitleDetailInterface[] = []
  listScroller: Scroller = new Scroller();
  listTitleScroller: Scroller = new Scroller();

  updateShow() {
    if (this.currentBreakpoint === Breakpoint.BREAKPOINT_SM && this.indexSelected !== 0) {
      this.isShowHotTitle = false;
      return;
    }

    this.isShowHotTitle = true;
  }

  aboutToAppear() {
    TITLE_DETAIL_LIST.forEach((item: TitleDetailInterface, index: number) => {
      if (index !== 0) {
        this.iconTitleList.push(item);
      }
    });
    this.pageInfo.pushPath({ name: '' });
  }

  build() {
    Column() {
      Column() {
        Row() {
          Text($r('app.string.read_total'))
            .fontSize($r('app.float.follow_total_font_size'))
            .fontColor($r('app.color.follow_total_font_color'))
            .fontWeight(BaseCommon.FONT_WEIGHT_500)

          Row() {
            Text($r('app.string.more'))
              .fontSize($r('app.float.follow_more_font_size'))
              .fontColor($r('app.color.follow_more_font_color'))

            Image($r('app.media.ic_public_arrow_right_filled'))
              .width($r('app.float.follow_more_icon_width'))
              .aspectRatio(1)
          }
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width(BaseCommon.FULL_PERCENT)
        .padding({
          left: $r('app.float.follow_more_padding'),
          right: $r('app.float.follow_more_padding')
        })
        .visibility(this.isShowHotTitle ? Visibility.Visible : Visibility.None)

        List({ space: Common.FOLLOW_TITLE_SPACE, scroller: this.listTitleScroller }) {
          ForEach(this.iconTitleList, (item: TitleDetailInterface, index: number) => {
            ListItem() {
              Column() {
                Image(item.icon)
                  .width($r('app.float.follow_title_icon_width'))
                  .aspectRatio(1)
                  .borderRadius($r('app.float.follow_title_icon_br'))
                  .borderWidth(index === this.indexTitleSelected ? $r('app.float.follow_title_icon_bw') :
                    $r('app.float.zero'))
                  .borderColor($r('app.color.follow_title_icon_bc'))

                Text(item.name)
                  .width($r('app.float.follow_title_text_width'))
                  .fontSize($r('app.float.follow_title_text_font_size'))
                  .fontColor(index === this.indexTitleSelected ? $r('app.color.follow_title_select') :
                    $r('app.color.follow_title_normal'))
                  .textAlign(TextAlign.Center)
                  .margin({
                    top: $r('app.float.follow_title_text_mt')
                  })
              }
              .margin({
                left: index === 0 ? $r('app.float.follow_title_margin_left') : $r('app.float.zero'),
                right: index === this.iconTitleList.length - 1 ? $r('app.float.follow_title_margin_left') :
                  $r('app.float.zero')
              })
            }
            .onClick(() => {
              this.indexTitleSelected = index;
              this.indexSelected = index + 1;
              this.listScroller.scrollToIndex(this.indexSelected);
              this.pageInfo.clear();
              this.pageInfo.pushPath(new NavPathInfo(`${index}`, ''), false);
            })
          }, (item: TitleDetailInterface, index: number) => index + JSON.stringify(item))
        }
        .scrollBar(BarState.Off)
        .listDirection(Axis.Horizontal)
        .padding({
          top: $r('app.float.follow_title_list_padding_top')
        })
        .height($r('app.float.follow_title_height'))
        .width(BaseCommon.FULL_PERCENT)
        .margin($r('app.float.zero'))

        if (this.indexTitleSelected !== -1) {
          Row() {
            Text(`${this.iconTitleList[this.indexTitleSelected].name}${Common.FOLLOW_TITLE_CONTENT}`)
              .fontSize($r('app.float.follow_title_content_fs'))
              .fontWeight(BaseCommon.FONT_WEIGHT_500)
              .fontColor($r('app.color.follow_title_content_fc'))

            Image($r('app.media.ic_public_cancel'))
              .width($r('app.float.follow_title_cancel'))
              .aspectRatio(1)
              .onClick(() => {
                this.indexTitleSelected = -1;
                this.indexSelected = 0;
                this.listScroller.scrollToIndex(0);

                this.pageInfo.clear();
                this.pageInfo.pushPath(new NavPathInfo(`${this.indexSelected}`, ''), false);
              })
          }
          .width(BaseCommon.FULL_PERCENT)
          .justifyContent(FlexAlign.SpaceBetween)
          .padding({
            left: $r('app.float.follow_title_message_padding_left'),
            right: $r('app.float.follow_title_message_padding_left')
          })
          .margin({
            top: $r('app.float.follow_title_message_margin_top')
          })
        }
      }
      .padding({
        top: $r('app.float.follow_title_padding_top')
      })
      .width(BaseCommon.FULL_PERCENT)
      .visibility(this.currentBreakpoint === Breakpoint.BREAKPOINT_SM ? Visibility.Visible : Visibility.None)
      .backgroundColor(this.indexTitleSelected === -1 ? Color.White : $r('app.color.follow_title_bgc'))

      Navigation(this.pageInfo) {
        List({ initialIndex: this.indexSelected, scroller: this.listScroller }) {
          ForEach(this.iconList, (item: TitleDetailInterface, index: number) => {
            ListItem() {
              Row() {
                if (item.icon !== undefined) {
                  Image(item.icon)
                    .width($r('app.float.follow_guide_icon_width'))
                    .aspectRatio(1)
                    .borderRadius($r('app.float.follow_guide_icon_br'))
                } else {
                  Row()
                    .width($r('app.float.follow_guide_icon_width'))
                    .aspectRatio(1)
                    .borderRadius($r('app.float.follow_guide_icon_br'))
                    .backgroundColor($r('app.color.follow_guide_icon_color'))
                }

                Column() {
                  Text(item.name)
                    .fontSize($r('app.float.follow_guide_name_fs'))
                    .fontWeight(BaseCommon.FONT_WEIGHT_500)
                    .fontColor($r('app.color.follow_guide_name_fc'))

                  Text(item?.content)
                    .fontSize($r('app.float.follow_guide_content_fs'))
                    .fontColor($r('app.color.follow_guide_content_fc'))
                }
                .margin({
                  left: $r('app.float.follow_guide_name_ml')
                })
                .alignItems(HorizontalAlign.Start)
              }
              .width(BaseCommon.FULL_PERCENT)
              .height($r('app.float.follow_guide_item_height'))
              .backgroundColor(this.indexSelected === index ? $r('app.color.follow_guide_selected_bgc') : Color.White)
              .padding({
                left: $r('app.float.follow_guide_item_pl')
              })
              .onClick(() => {
                this.indexSelected = index;
                this.indexTitleSelected = index - 1;
                this.listTitleScroller.scrollToIndex(this.indexTitleSelected < 0 ? 0 : this.indexTitleSelected);
                this.pageInfo.clear();
                this.pageInfo.pushPath(new NavPathInfo(`${index}`, ''), false);
              })
            }
          }, (item: TitleDetailInterface, index: number) => index + JSON.stringify(item))
        }
        .scrollBar(BarState.Off)
      }
      .hideTitleBar(true)
      .hideBackButton(true)
      .hideToolBar(true)
      .mode(NavigationMode.Split)
      .navBarWidth(new BreakpointType($r('app.float.zero'), $r('app.float.nav_bar_width_md'),
        $r('app.float.nav_bar_width_lg')).getValue(this.currentBreakpoint))
      .hideNavBar(this.currentBreakpoint === Breakpoint.BREAKPOINT_SM)
      .layoutWeight(1)
      .navDestination(this.pageMap)
    }
    .justifyContent(FlexAlign.Start)
    .backgroundColor($r('app.color.nav_content_bgd'))
    .height(BaseCommon.FULL_PERCENT)
  }

  @Builder
  pageMap(name: string) {
    NavDestination() {
      WaterFlow() {
        ForEach(FOLLOW_LIST, (item: FollowItemInterface) => {
          FlowItem() {
            CardItemView({
              item: item,
              index: this.indexSelected
            })
          }
        }, (item: FollowItemInterface, index: number) => index + JSON.stringify(item))
      }
      .backgroundColor($r('app.color.nav_content_bgd'))
      .padding({
        top: new BreakpointType($r('app.float.follow_water_flow_padding_sm'),
          $r('app.float.follow_water_flow_padding_md'), $r('app.float.follow_water_flow_padding_lg'))
          .getValue(this.currentBreakpoint),
        left: new BreakpointType($r('app.float.follow_water_flow_padding_sm'),
          $r('app.float.follow_water_flow_padding_md'), $r('app.float.follow_water_flow_padding_lg'))
          .getValue(this.currentBreakpoint),
        right: new BreakpointType($r('app.float.follow_water_flow_padding_sm'),
          $r('app.float.follow_water_flow_padding_md'), $r('app.float.follow_water_flow_padding_lg'))
          .getValue(this.currentBreakpoint),
        bottom: new BreakpointType($r('app.float.follow_water_flow_padding_sm'),
          $r('app.float.follow_water_flow_padding_md'), $r('app.float.follow_water_flow_padding_lg'))
          .getValue(this.currentBreakpoint)
      })
      .columnsGap($r('app.float.follow_water_flow_column_gap'))
      .rowsGap(new BreakpointType($r('app.float.follow_water_flow_padding_sm'),
        $r('app.float.follow_water_flow_padding_md'), $r('app.float.follow_water_flow_padding_lg'))
        .getValue(this.currentBreakpoint))
      .columnsTemplate(new BreakpointType(Common.WATER_FLOW_COLUMNS_TEMPLATE_NORMAL,
        Common.WATER_FLOW_COLUMNS_TEMPLATE_NORMAL, Common.WATER_FLOW_COLUMNS_TEMPLATE_LG)
        .getValue(this.currentBreakpoint))
    }
    .width(BaseCommon.FULL_PERCENT)
    .height(BaseCommon.FULL_PERCENT)
    .hideTitleBar(true)
  }
}