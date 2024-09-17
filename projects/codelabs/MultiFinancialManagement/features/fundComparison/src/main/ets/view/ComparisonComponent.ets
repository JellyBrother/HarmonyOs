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

import { TreeMap } from '@kit.ArkTS';
import { CommonConstants } from '@ohos/basic';
import { ComparisonInfo } from '../viewmodel/ComparisonInfo';
import FundComparisonViewModel from '../viewmodel/FundComparisonViewModel';
import { ComparisonConstants } from '../constants/ComparisonConstants';

@Component
export struct ComparisonComponent {
  @StorageLink('breakPoint') currentPoint: string = CommonConstants.BREAK_POINT_SM;
  @State chooseComparison: ComparisonInfo[] = [];
  @State map: TreeMap<number, ComparisonInfo> = new TreeMap();
  @State defaultAllComparison: ComparisonInfo[] = FundComparisonViewModel.getFundComparisonList();
  @State indexArray: number[] = [];
  @StorageLink('pageInfo') pageInfo: NavPathStack = new NavPathStack();
  private controller: TabsController = new TabsController();
  @State tabBarIndex: number = 0;

  build() {
    NavDestination() {
      GridRow({
        breakpoints: {
          value: CommonConstants.BREAK_POINTS_VALUE,
          reference: BreakpointsReference.WindowSize
        },
        columns: {
          sm: CommonConstants.COLUMN_SM,
          md: CommonConstants.COLUMN_MD,
          lg: CommonConstants.COLUMN_LG
        },
        direction: GridRowDirection.Row
      }) {
        GridCol({
          span: {
            sm: CommonConstants.COLUMN_SM,
            md: CommonConstants.COLUMN_MD,
            lg: CommonConstants.COLUMN_LG
          }
        }) {
          Column() {
            Row() {
              Image($r('app.media.ic_public_back'))
                .width($r('app.float.common_image'))
                .height($r('app.float.common_image'))
                .onClick(() => {
                  this.pageInfo.pop();
                })
              Text($r('app.string.funding_comparison_title'))
                .fontSize($r('app.float.title_text_size'))
                .fontColor($r('app.color.sixty_percent_white'))
              Image($r('app.media.ic_public_cancel'))
                .width($r('app.float.common_image'))
                .height($r('app.float.common_image'))
                .onClick(() => {
                  this.pageInfo.pop();
                })
            }
            .height($r('app.float.title_height'))
            .width(CommonConstants.FULL_WIDTH_PERCENT)
            .justifyContent(FlexAlign.SpaceBetween)
            .backgroundColor(Color.White)
            .visibility(this.currentPoint === CommonConstants.BREAK_POINT_SM ? Visibility.Visible : Visibility.None)

            Row() {
              Row() {
                Image($r('app.media.ic_public_back'))
                  .width($r('app.float.common_image'))
                  .height($r('app.float.common_image'))
                  .onClick(() => {
                    this.pageInfo.pop();
                  })
                Text($r('app.string.funding_comparison_title'))
                  .fontSize($r('app.float.title_text_size'))
                  .fontColor($r('app.color.sixty_percent_white'))
                  .margin({
                    left: $r('app.float.padding_common')
                  })
              }
              Row() {
                Search({ placeholder: $r('app.string.search_placeholder') })
                  .width($r('app.float.search_width'))
                  .enableKeyboardOnFocus(false)
                  .margin({
                    right: $r('app.float.padding_common')
                  })
                Image($r('app.media.ic_public_cancel'))
                  .width($r('app.float.common_image'))
                  .height($r('app.float.common_image'))
                  .onClick(() => {
                    this.pageInfo.pop();
                  })
              }
            }
            .height($r('app.float.title_height'))
            .width(CommonConstants.FULL_WIDTH_PERCENT)
            .justifyContent(FlexAlign.SpaceBetween)
            .backgroundColor(Color.White)
            .visibility(this.currentPoint === CommonConstants.BREAK_POINT_SM ? Visibility.None : Visibility.Visible)

            Search({ placeholder: $r('app.string.search_placeholder') })
              .margin({
                top: $r('app.float.search_margin_top')
              })
              .enableKeyboardOnFocus(false)
              .visibility(this.currentPoint === CommonConstants.BREAK_POINT_SM ? Visibility.Visible : Visibility.None)

            Tabs() {
              TabContent() {
                List() {
                  ForEach(this.defaultAllComparison, (item: ComparisonInfo, index: number) => {
                    ListItem() {
                      Row() {
                        Checkbox()
                          .shape(CheckBoxShape.ROUNDED_SQUARE)
                          .select(this.indexArray.indexOf(index) != -1)
                          .onChange((value: boolean) => {
                            if (value) {
                              this.map.set(index, item);
                            } else {
                              this.map.remove(index);
                            }
                            this.chooseComparison = Array.from(this.map.values());
                            this.indexArray = Array.from(this.map.keys());
                            if (this.map.length > ComparisonConstants.MAX_COMPARISON_FUND_COUNT) {
                              this.map.remove(index);
                              this.chooseComparison = Array.from(this.map.values());
                              this.indexArray = Array.from(this.map.keys());
                              return;
                            }
                          })
                        Column({ space: ComparisonConstants.COLUMN_SPACE }) {
                          Text(item.name)
                            .fontSize($r('app.float.name_size'))
                            .fontWeight(CommonConstants.FONT_WEIGHT_500)
                            .lineHeight($r('app.float.common_line_height'))
                          Text(item.code)
                            .fontSize($r('app.float.code_size'))
                            .fontColor($r('app.color.sixty_percent_white'))
                        }
                        .layoutWeight(1)
                        .border({
                          width: {
                            bottom: $r('app.float.common_border_width')
                          },
                          color: $r('app.color.five_percent_white_fund')
                        })
                        .alignItems(HorizontalAlign.Start)
                        .padding({
                          bottom: $r('app.float.list_padding_bottom')
                        })
                        .margin({
                          left: $r('app.float.list_margin_left')
                        })
                      }
                    }
                    .height($r('app.float.list_item_height_comparison'))
                  })
                }
                .lanes(this.currentPoint === CommonConstants.BREAK_POINT_SM ? 1 : 2)
              }
              .tabBar($r('app.string.fund_popularity'))

              TabContent() {

              }
              .tabBar($r('app.string.self_selected'))
            }
            .barMode(BarMode.Fixed)
            .barWidth($r('app.float.choose_tab_width'))
            .layoutWeight(1)

            Row() {
              if (this.chooseComparison.length > 0) {
                Column() {
                  Row({ space: ComparisonConstants.CHOOSE_LIST_SPACE }) {
                    Text($r('app.string.no_currency', this.chooseComparison.length))
                      .fontSize($r('app.float.tab_text_size_fund'))
                      .lineHeight($r('app.float.common_line_height'))
                      .fontColor(this.tabBarIndex === 0 ? $r('app.color.harmony_blue') : Color.Black)
                      .onClick(() => {
                        this.tabBarIndex = 0;
                        this.controller.changeIndex(this.tabBarIndex);
                      })
                    Text($r('app.string.currency_bar', 0))
                      .fontSize($r('app.float.tab_text_size_fund'))
                      .lineHeight($r('app.float.common_line_height'))
                      .fontColor(this.tabBarIndex === 1 ? $r('app.color.harmony_blue') : Color.Black)
                      .onClick(() => {
                        this.tabBarIndex = 1;
                        this.controller.changeIndex(this.tabBarIndex);
                      })
                  }
                  .width(CommonConstants.FULL_WIDTH_PERCENT)
                  .justifyContent(FlexAlign.Start)
                  .alignItems(VerticalAlign.Center)
                  .height($r('app.float.title_height'))

                  Tabs({ controller: this.controller }) {
                    TabContent() {
                      List({ space: ComparisonConstants.CHOOSE_LIST_SPACE }) {
                        ForEach(this.chooseComparison, (item: ComparisonInfo) => {
                          ListItem() {
                            Stack() {
                              Row() {
                                Text(item.name)
                                  .fontSize($r('app.float.stack_text_size'))
                              }
                              .backgroundColor($r('app.color.five_percent_white_fund'))
                              .borderRadius($r('app.float.row_border_radius'))
                              .padding({
                                top: $r('app.float.stack_row_padding_top'),
                                bottom: $r('app.float.stack_row_padding_bottom'),
                                left: $r('app.float.stack_row_padding_left'),
                                right: $r('app.float.stack_row_padding_right')
                              })
                              .margin({
                                top: $r('app.float.stack_row_margin_top')
                              })
                              Row() {
                                Image($r('app.media.ic_public_close'))
                                  .width($r('app.float.close_image'))
                                  .height($r('app.float.close_image'))
                                  .fillColor($r('app.color.forty_percent_white'))
                                  .onClick(() => {
                                    for (let i = 0; i < this.defaultAllComparison.length; i++) {
                                      if (item.code === this.defaultAllComparison[i].code) {
                                        this.map.remove(i);
                                        this.indexArray = Array.from(this.map.keys());
                                        this.chooseComparison = Array.from(this.map.values());
                                      }
                                    }
                                  })
                              }
                              .layoutWeight(1)
                              .justifyContent(FlexAlign.End)
                              .alignItems(VerticalAlign.Top)
                            }
                            .align(Alignment.TopEnd)
                          }
                        })
                      }
                      .listDirection(Axis.Horizontal)
                      .height($r('app.float.content_height'))
                      .width(CommonConstants.FULL_WIDTH_PERCENT)
                    }
                    .tabBar($r('app.string.no_currency', this.chooseComparison.length))

                    TabContent() {

                    }
                    .tabBar($r('app.string.currency_bar', 0))
                  }
                  .layoutWeight(1)
                  .barHeight(0)
                  .scrollable(false)

                  Row() {
                    Column() {
                      Text($r('app.string.count_choose', this.chooseComparison.length))
                        .fontSize($r('app.float.choose_count_size'))
                        .lineHeight($r('app.float.common_line_height'))
                        .fontWeight(CommonConstants.FONT_WEIGHT_500)
                      Text($r('app.string.max_count_choose'))
                        .fontSize($r('app.float.choose_hints_size'))
                        .lineHeight($r('app.float.choose_hints_lint_height'))
                        .fontColor($r('app.color.sixty_percent_white'))
                    }

                    Button($r('app.string.start_comparison'))
                      .backgroundColor($r('app.color.start_button_background'))
                      .width(this.currentPoint === CommonConstants.BREAK_POINT_SM ?
                        $r('app.float.start_button_width_sm') : $r('app.float.start_button_width'))
                      .height($r('app.float.start_button_height'))
                      .fontColor(Color.White)
                      .fontSize($r('app.float.common_font_size'))
                      .fontWeight(CommonConstants.FONT_WEIGHT_500)
                      .onClick(() => {
                        this.pageInfo.pushPathByName(CommonConstants.PATH_COMPARISON_DETAIL, this.chooseComparison);
                      })
                  }
                  .width(CommonConstants.FULL_WIDTH_PERCENT)
                  .justifyContent(FlexAlign.SpaceBetween)
                }
              } else {
                Row() {
                  Text($r('app.string.select_fund'))
                    .fontSize($r('app.float.common_font_size'))
                    .lineHeight($r('app.float.common_line_height'))
                    .fontWeight(CommonConstants.FONT_WEIGHT_500)
                  Button($r('app.string.start_comparison'))
                    .backgroundColor($r('app.color.start_comparison_background'))
                    .width(this.currentPoint === CommonConstants.BREAK_POINT_SM ?
                       $r('app.float.start_button_width_sm') : $r('app.float.start_button_width'))
                    .height($r('app.float.start_button_height'))
                    .fontColor(Color.White)
                    .fontSize($r('app.float.common_font_size'))
                    .fontWeight(CommonConstants.FONT_WEIGHT_500)

                }
                .width(CommonConstants.FULL_WIDTH_PERCENT)
                .justifyContent(FlexAlign.SpaceBetween)
              }
            }
            .height(this.chooseComparison.length > 0 ?
              $r('app.float.bottom_choose_height_show') : $r('app.float.bottom_choose_height'))
          }
        }
      }
      .padding({
        left: $r('app.float.comparison_padding_left'),
        right: $r('app.float.comparison_padding_right'),
        bottom: $r('app.float.comparison_padding_bottom')
      })
    }
    .hideTitleBar(true)
  }
}