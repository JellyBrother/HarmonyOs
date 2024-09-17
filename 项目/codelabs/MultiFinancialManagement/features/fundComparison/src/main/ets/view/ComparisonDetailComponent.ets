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

import { CommonConstants, RouterConstants } from '@ohos/basic';
import { ComparisonConstants } from '../constants/ComparisonConstants';
import { ComparisonInfo } from '../viewmodel/ComparisonInfo';
import FundComparisonViewModel from '../viewmodel/FundComparisonViewModel';

@Component
export struct ComparisonDetailComponent {
  @State chooseComparison: ComparisonInfo[] = FundComparisonViewModel.getFundComparisonList();
  @State isListScroll: boolean = true;
  @State isScroll: boolean = true;
  @StorageLink('pageInfo') pageInfo: NavPathStack = new NavPathStack();
  @State isPage: Boolean = false;
  @StorageProp('breakPoint') currentPoint: string = CommonConstants.BREAK_POINT_SM;
  @StorageLink('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack();
  private nameColorArr: ResourceColor[] = [
    $r('app.color.name_color_1'),
    $r('app.color.name_color_2'),
    $r('app.color.name_color_3')
  ];
  scroller: Scroller = new Scroller();
  scrollerList: Scroller = new Scroller();

  build() {
    Column() {
      Row() {
        Row() {
          Image($r('app.media.ic_public_back'))
            .width($r('app.float.common_image'))
            .height($r('app.float.common_image'))
            .margin({
              right: $r('app.float.image_margin_right')
            })
            .onClick(() => {
              if (this.isPage) {
                this.pageIndexInfos.pop();
              } else {
                this.pageInfo.pop();
              }
            })
          if (this.currentPoint === CommonConstants.BREAK_POINT_LG) {
            if (this.isPage) {
              Image($r('app.media.ic_public_reduce'))
                .width($r('app.float.common_image'))
                .height($r('app.float.common_image'))
                .onClick(() => {
                  this.pageIndexInfos.pop();
                })
            } else {
              Image($r('app.media.ic_public_enlarge'))
                .width($r('app.float.common_image'))
                .height($r('app.float.common_image'))
                .onClick(() => {
                  this.pageIndexInfos.pushPathByName(RouterConstants.COMPARISON_PAGE_URL,
                    { 'chooseComparison': this.chooseComparison } as Record<string, ComparisonInfo[]>);
                })
            }
          }
        }
        Text($r('app.string.funding_comparison_title'))
          .fontSize($r('app.float.title_text_size'))
          .fontColor($r('app.color.sixty_percent_white'))
        Image($r('app.media.ic_public_cancel'))
          .width($r('app.float.common_image'))
          .height($r('app.float.common_image'))
          .onClick(() => {
            if (this.isPage) {
              this.pageIndexInfos.pop();
            } else {
              this.pageInfo.pop();
            }
          })
      }
      .width(CommonConstants.FULL_WIDTH_PERCENT)
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({
        top: $r('app.float.title_padding_top'),
        left: $r('app.float.padding_common'),
        right: $r('app.float.padding_common')
      })

      Tabs() {
        TabContent() {
          Column() {
            Row() {
              Row() {
                Text($r('app.string.table_fund_name'))
                  .fontSize($r('app.float.fund_name_size'))
                  .lineHeight($r('app.float.fund_name_line_height'))
                  .fontColor($r('app.color.sixty_percent_white'))
              }
              .width($r('app.float.fund_name_width'))
              .height($r('app.float.fund_name_height'))
              .alignItems(VerticalAlign.Center)
              .justifyContent(FlexAlign.Center)

              List({ space: ComparisonConstants.FUND_NAME_ROW_SPACE, scroller: this.scrollerList }) {
                ForEach(this.chooseComparison, (item: ComparisonInfo, index: number) => {
                  ListItem() {
                    Column() {
                      Row() {
                        Image($r('app.media.ic_fixing'))
                          .width($r('app.float.fixing_width'))
                          .height($r('app.float.fixing_height'))
                        Image($r('app.media.ic_public_cancel'))
                          .width($r('app.float.cancel_width'))
                          .height($r('app.float.cancel_height'))
                      }
                      .width(CommonConstants.FULL_WIDTH_PERCENT)
                      .justifyContent(FlexAlign.SpaceBetween)
                      .padding({
                        left: $r('app.float.fixing_image_padding'),
                        right: $r('app.float.fixing_image_padding'),
                        bottom: $r('app.float.fixing_image_padding')
                      })

                      Row() {
                        Divider()
                          .vertical(true)
                          .width($r('app.float.divider_fixing_width'))
                          .height($r('app.float.divider_fixing_height'))
                          .color(this.nameColorArr[index % this.nameColorArr.length])
                          .borderRadius($r('app.float.divider_fixing_radius'))
                        Text(item.name)
                          .fontSize($r('app.float.list_fund_name_size'))
                          .lineHeight($r('app.float.list_name_line_height'))
                          .textOverflow({ overflow: TextOverflow.Ellipsis })
                          .margin({
                            left: $r('app.float.list_name_margin_left')
                          })
                      }
                      .width(CommonConstants.FULL_WIDTH_PERCENT)
                    }
                  }
                  .width($r('app.float.list_name_width'))
                  .height($r('app.float.list_name_height'))
                  .backgroundColor($r('app.color.background'))
                  .borderRadius($r('app.float.list_name_radius'))
                })
              }
              .scrollBar(BarState.Off)
              .listDirection(Axis.Horizontal)
              .edgeEffect(EdgeEffect.None)
              .onScroll((scrollOffset: number) => {
                if (this.isScroll) {
                  let offset = this.scrollerList.currentOffset().xOffset;
                  this.scroller.scrollTo({ xOffset: offset, yOffset: 0 });
                }
              })
              .onScrollFrameBegin((offset: number) => {
                this.isListScroll = false;
                return { offsetRemain: offset }
              })
              .onScrollStop(() => {
                this.isListScroll = true;
              })
              .layoutWeight(1)
            }
            .height($r('app.float.list_name_height'))

            Divider()
              .width(CommonConstants.FULL_WIDTH_PERCENT)
              .height($r('app.float.common_divider'))
              .backgroundColor($r('app.color.divider_background'))
              .margin({
                top: $r('app.float.divider_margin_top'),
                bottom: $r('app.float.divider_margin_bottom')
              })
            Text($r('app.string.base_info'))
              .fontSize($r('app.float.common_font_size'))
              .lineHeight($r('app.float.common_line_height'))
              .fontWeight(CommonConstants.FONT_WEIGHT_500)
              .fontColor($r('app.color.info_text'))
              .margin({
                left: $r('app.float.info_margin_left')
              })
            Scroll() {
              Row() {
                List() {
                  ForEach(FundComparisonViewModel.getComparisonCategory(), (item: ResourceStr) => {
                    ListItem() {
                      Text(item)
                        .fontSize($r('app.float.list_head_size'))
                        .lineHeight($r('app.float.list_head_line_height'))
                        .fontColor($r('app.color.sixty_percent_white'))
                        .width($r('app.float.list_head_text_width'))
                    }
                    .height($r('app.float.list_head_height'))
                    .width($r('app.float.list_head_width'))
                  })
                }
                .border({
                  width: {
                    top: $r('app.float.list_head_border'),
                    bottom: $r('app.float.list_head_border')
                  },
                  color: $r('app.color.ten_percent_white')
                })
                .width($r('app.float.list_head_width'))
                .divider({
                  strokeWidth: $r('app.float.common_divider'),
                  color: $r('app.color.ten_percent_white')
                })

                Scroll(this.scroller) {
                  Row() {
                    ForEach(this.chooseComparison, (item: ComparisonInfo) => {
                      List() {
                        ListItem() {
                          Text(item.code)
                            .buildScrollListText()
                        }
                        .listStyle()

                        ListItem() {
                          Text(item.type)
                            .buildScrollListText()
                        }
                        .listStyle()

                        ListItem() {
                          Text(item.establishedTime)
                            .buildScrollListText()
                        }
                        .listStyle()

                        ListItem() {
                          Text(`${item.scale}`)
                            .buildScrollListText()
                        }
                        .listStyle()

                        ListItem() {
                          Text(item.risksLevel)
                            .buildScrollListText()
                        }
                        .listStyle()

                        ListItem() {
                          Text(`${item.rating}`)
                            .buildScrollListText()
                        }
                        .listStyle()

                        ListItem() {
                          Text(`${item.dividends}`)
                            .buildScrollListText()
                        }
                        .listStyle()

                        ListItem() {
                          Text(`${item.dividendsCount}`)
                            .buildScrollListText()
                        }
                        .listStyle()

                        ListItem() {
                          Text(item.fundManager)
                            .buildScrollListText()
                        }
                        .listStyle()
                      }
                      .divider({
                        strokeWidth: $r('app.float.common_divider'),
                        color: $r('app.color.ten_percent_white')
                      })
                      .width($r('app.float.scroll_list_width'))
                      .border({
                        width: $r('app.float.common_divider'),
                        color: $r('app.color.ten_percent_white')
                      })
                    })
                  }
                  .justifyContent(FlexAlign.Start)
                }
                .scrollable(ScrollDirection.Horizontal)
                .scrollBar(BarState.Off)
                .edgeEffect(EdgeEffect.None)
                .onScroll((scrollOffset: number) => {
                  if (this.isListScroll) {
                    let offset = this.scroller.currentOffset().xOffset;
                    this.scrollerList.scrollTo({ xOffset: offset, yOffset: 0 });
                  }
                })
                .onScrollStop(() => {
                  this.isScroll = true;
                })
                .onScrollFrameBegin((offset: number) => {
                  this.isScroll = false;
                  return { offsetRemain: offset };
                })
                .layoutWeight(1)
                .align(Alignment.Start)
              }
              .justifyContent(FlexAlign.Start)
              .alignItems(VerticalAlign.Top)
            }
            .layoutWeight(1)
            .align(Alignment.Top)
          }
          .height(CommonConstants.FULL_HEIGHT_PERCENT)
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.Start)
        }
        .tabBar($r('app.string.no_currency', this.chooseComparison.length))

        TabContent() {

        }
        .tabBar($r('app.string.currency_bar', 0))
      }
      .barMode(BarMode.Fixed)
      .barWidth($r('app.float.choose_tab_width'))
      .layoutWeight(1)
    }
  }

  @Styles
  listStyle() {
    .height($r('app.float.list_style_height'))
    .width($r('app.float.list_style_width'))
  }
}

@Extend(Text)
function buildScrollListText() {
  .fontSize($r('app.float.list_text_size'))
  .lineHeight($r('app.float.list_text_line_height'))
  .fontColor($r('app.color.sixty_percent_white'))
  .width($r('app.float.list_text_width'))
  .textAlign(TextAlign.Center)
}
