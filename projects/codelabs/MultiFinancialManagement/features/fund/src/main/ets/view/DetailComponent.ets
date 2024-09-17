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

import { LineChart, LineChartModel } from '@ohos/mpchart';
import { BreakpointUtil, CommonConstants, FundDetail, RouterConstants } from '@ohos/basic';
import ChartViewModel from '../viewmodel/ChartViewModel';
import FundingViewModel from '../viewmodel/FundingViewModel';
import { FundConstants } from '../constants/FundConstants';
import { ChartLegendComponent } from './ChartLegendComponent';

@Component
export struct DetailComponent {
  @State currentPoint: string = CommonConstants.BREAK_POINT_LG;
  @State lineChartModel: LineChartModel = ChartViewModel.getLineChartModel();
  @State showChart: boolean = true;
  @State indexList: number = 0;
  @State tabBarIndex: number = 0;
  @State fundInfo: FundDetail[] = FundingViewModel.getAllFundInfo();
  @StorageLink('pageInfo') pageInfo: NavPathStack = new NavPathStack();
  @StorageLink('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack();
  private controller: TabsController = new TabsController();

  build() {
    NavDestination() {
      GridRow({
        breakpoints: {
          value: CommonConstants.BREAK_POINTS_VALUE,
          reference: BreakpointsReference.ComponentSize
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
                  this.pageIndexInfos.pop();
                })
              Text($r('app.string.funding_title'))
                .fontSize($r('app.float.title_text_size'))
                .fontColor($r('sys.color.mask_secondary'))
              Image($r('app.media.ic_public_share'))
                .width($r('app.float.common_image'))
                .height($r('app.float.common_image'))
            }
            .width(CommonConstants.FULL_WIDTH_PERCENT)
            .height($r('app.float.title_height'))
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .backgroundColor(Color.White)
            .padding({
              left: $r('app.float.padding_common'),
              right: $r('app.float.padding_common')
            })

            Scroll() {
              Column() {
                Column() {
                  Row() {
                    Text(this.fundInfo[this.indexList].name)
                      .fontSize($r('app.float.common_font_size'))
                      .fontColor($r('app.color.name_text'))
                      .lineHeight($r('app.float.common_line_height'))
                      .fontWeight(CommonConstants.FONT_WEIGHT_500)
                    Text($r('app.string.funding_code'))
                      .fontSize($r('app.float.code_size'))
                      .fontColor($r('app.color.forty_percent_white'))
                  }
                  .justifyContent(FlexAlign.SpaceBetween)
                  .width(CommonConstants.FULL_WIDTH_PERCENT)

                  Row({ space: FundConstants.ROW_SPACE }) {
                    Text($r('app.string.currency_type'))
                      .buildTextStyle()
                    Text($r('app.string.medium_risk'))
                      .buildTextStyle()
                    Text($r('app.string.purchase_rmb'))
                      .buildTextStyle()
                  }
                  .width(CommonConstants.FULL_WIDTH_PERCENT)
                  .justifyContent(FlexAlign.Start)
                  .margin({
                    top: $r('app.float.type_margin_top'),
                    bottom: $r('app.float.type_margin_bottom')
                  })

                  Row() {
                    Column({ space: FundConstants.COLUMN_SPACE }) {
                      Text(this.fundInfo[this.indexList].amplitude)
                        .fontSize($r('app.float.amplitude_size'))
                        .fontColor($r('app.color.amplitude_text'))
                        .fontWeight(CommonConstants.FONT_WEIGHT_700)
                      Text($r('app.string.one_year_amplitude'))
                        .fontSize($r('app.float.amplitude_time_size'))
                        .fontColor($r('app.color.forty_percent_white'))
                    }

                    Column({ space: FundConstants.COLUMN_SPACE }) {
                      Text($r('app.string.one_day_amplitude_data'))
                        .fontSize($r('app.float.amplitude_date_size'))
                        .fontColor($r('app.color.amplitude_date'))
                        .fontWeight(CommonConstants.FONT_WEIGHT_500)
                      Text($r('app.string.one_day_amplitude'))
                        .fontSize($r('app.float.amplitude_time_size'))
                        .fontColor($r('app.color.forty_percent_white'))
                    }

                    Column({ space: FundConstants.COLUMN_SPACE }) {
                      Text($r('app.string.last_net_value_data'))
                        .fontSize($r('app.float.amplitude_date_size'))
                        .fontColor(Color.Black)
                        .fontWeight(CommonConstants.FONT_WEIGHT_500)
                      Text($r('app.string.last_net_value'))
                        .fontSize($r('app.float.amplitude_time_size'))
                        .fontColor($r('app.color.forty_percent_white'))
                    }
                  }
                  .width(CommonConstants.FULL_WIDTH_PERCENT)
                  .justifyContent(FlexAlign.SpaceBetween)
                  .alignItems(VerticalAlign.Bottom)

                  Row() {
                    Text($r('app.string.last_net_value'))
                      .fontSize($r('app.float.value_size'))
                      .fontColor($r('app.color.forty_percent_white'))
                    Text($r('app.string.last_net_not_show'))
                      .fontSize($r('app.float.value_size'))
                      .fontColor($r('app.color.forty_percent_white'))
                      .margin({
                        left: $r('app.float.last_net_margin_left')
                      })
                  }
                  .width(CommonConstants.FULL_WIDTH_PERCENT)
                  .justifyContent(FlexAlign.Start)
                  .margin({
                    top: $r('app.float.last_net_margin_tb'),
                    bottom: $r('app.float.last_net_margin_tb')
                  })

                  Row() {
                    Text($r('app.string.three_year_rating'))
                      .fontSize($r('app.float.value_size'))
                      .fontColor($r('app.color.forty_percent_white'))
                      .margin({
                        right: $r('app.float.rating_margin_right')
                      })
                    Rating()
                      .height($r('app.float.rating_height'))
                  }
                  .width(CommonConstants.FULL_WIDTH_PERCENT)
                  .justifyContent(FlexAlign.Start)
                }
                .backgroundColor(Color.White)
                .padding({
                  left: $r('app.float.padding_common'),
                  right: $r('app.float.scroll_column_padding_right'),
                  top: $r('app.float.scroll_column_padding_top'),
                  bottom: $r('app.float.scroll_column_padding_bottom')
                })
                .margin({
                  top: $r('app.float.scroll_column_margin'),
                  bottom: $r('app.float.scroll_column_margin')
                })

                Column() {
                  Row() {
                    Row({ space: FundConstants.BOTTOM_ROW_SPACE }) {
                      Text($r('app.string.performance_trends'))
                        .fontSize($r('app.float.tab_text_size_fund'))
                        .lineHeight($r('app.float.common_line_height'))
                        .fontColor(this.tabBarIndex === 0 ? $r('app.color.harmony_blue') : Color.Black)
                        .border({
                          width: {
                            bottom: $r('app.float.tab_bar_border')
                          },
                          color: this.tabBarIndex === 0 ? $r('app.color.harmony_blue') : $r('app.color.transparent_color')
                        })
                        .padding({
                          bottom: $r('app.float.tab_bar_padding_bottom')
                        })
                        .onClick(() => {
                          this.tabBarIndex = 0;
                          this.controller.changeIndex(this.tabBarIndex);
                        })
                      Text($r('app.string.unit_net_value'))
                        .fontSize($r('app.float.tab_text_size_fund'))
                        .lineHeight($r('app.float.common_line_height'))
                        .fontColor(this.tabBarIndex === 1 ? $r('app.color.harmony_blue') : Color.Black)
                        .border({
                          width: {
                            bottom: $r('app.float.tab_bar_border')
                          },
                          color: this.tabBarIndex === 1 ? $r('app.color.harmony_blue') : $r('app.color.transparent_color')
                        })
                        .padding({
                          bottom: $r('app.float.tab_bar_padding_bottom')
                        })
                        .onClick(() => {
                          this.tabBarIndex = 1;
                          this.controller.changeIndex(this.tabBarIndex);
                        })
                    }
                    Image($r('app.media.ic_public_enlarge'))
                      .width($r('app.float.common_image'))
                      .height($r('app.float.common_image'))
                      .onClick(() => {
                        this.pageIndexInfos.pushPathByName(RouterConstants.TRENDS_PAGE_URL,
                          { 'name': this.fundInfo[this.indexList].name } as Record<string, string>);
                      })
                  }
                  .width(CommonConstants.FULL_WIDTH_PERCENT)
                  .justifyContent(FlexAlign.SpaceBetween)
                  .margin({
                    bottom: $r('app.float.tab_bar_top')
                  })
                  Tabs({ controller: this.controller }) {
                    TabContent() {
                      Column() {
                        Row() {
                          ChartLegendComponent({
                            name: $r('app.string.the_fund'),
                            color: $r('app.color.fund_chart'),
                            value: $r('app.string.the_fund_value')
                          })
                          ChartLegendComponent({
                            name: $r('app.string.same_average'),
                            color: $r('app.color.same_average_chart'),
                            value: $r('app.string.same_average_value')
                          })
                          ChartLegendComponent({
                            name: $r('app.string.other_funding'),
                            color: $r('app.color.other_funding_chart'),
                            value: $r('app.string.other_funding_value')
                          })
                        }
                        .width(CommonConstants.FULL_WIDTH_PERCENT)
                        .justifyContent(FlexAlign.SpaceBetween)

                        Row() {
                          LineChart({ model: this.lineChartModel })
                        }
                        .width(CommonConstants.FULL_WIDTH_PERCENT)
                        .layoutWeight(1)

                        Row() {
                          Button($r('app.string.near_month', 1))
                            .fontSize($r('app.float.chart_button_size'))
                            .fontColor($r('app.color.harmony_blue'))
                            .fontWeight(CommonConstants.FONT_WEIGHT_500)
                            .backgroundColor($r('app.color.five_percent_white_fund'))
                            .height($r('app.float.chart_button_height'))
                            .width(new BreakpointUtil({
                              sm: $r('app.float.chart_button_min_width'),
                              md: $r('app.float.chart_button_max_width'),
                              lg: $r('app.float.chart_button_max_width')
                            }).getValue(this.currentPoint))
                          Button($r('app.string.near_month', 3))
                            .chartButtonStyle()
                          Button($r('app.string.near_month', 6))
                            .chartButtonStyle()
                          Button($r('app.string.near_year', 1))
                            .chartButtonStyle()
                          Button($r('app.string.near_year', 3))
                            .chartButtonStyle()
                        }
                        .width(CommonConstants.FULL_WIDTH_PERCENT)
                        .height('30vp')
                        .justifyContent(FlexAlign.SpaceBetween)
                        .margin({
                          top: $r('app.float.chart_button_margin')
                        })
                      }
                      .height(CommonConstants.FULL_HEIGHT_PERCENT)
                    }
                    .tabBar($r('app.string.performance_trends'))

                    TabContent() {

                    }
                    .tabBar($r('app.string.unit_net_value'))
                  }
                  .barMode(BarMode.Scrollable, { margin: $r('app.float.tab_bar_margin')})
                  .barHeight(0)
                  .scrollable(false)
                  .layoutWeight(1)
                }
                .backgroundColor(Color.White)
                .layoutWeight(1)
                .padding({
                  top: $r('app.float.image_enlarge_margin'),
                  left: $r('app.float.padding_common'),
                  right: $r('app.float.padding_common')
                })
              }
              .justifyContent(FlexAlign.Start)
            }
            .align(Alignment.TopStart)
            .layoutWeight(1)
            .scrollBar(BarState.Off)

            Row() {
              Row({ space: FundConstants.BOTTOM_ROW_SPACE }) {
                Column({ space: FundConstants.COLLECT_COLUMN_SPACE }) {
                  Image($r('app.media.ic_public_copy_fund'))
                    .width($r('app.float.common_image'))
                    .height($r('app.float.common_image'))
                  Text($r('app.string.funding_contrasts'))
                    .fontSize($r('app.float.contrasts_size'))
                }
                .onClick(() => {
                  this.pageInfo.pushPath({ name: CommonConstants.PATH_COMPARISON })
                })
                Column({ space: FundConstants.COLLECT_COLUMN_SPACE }) {
                  Image($r('app.media.ic_public_collect_fund'))
                    .width($r('app.float.common_image'))
                    .height($r('app.float.common_image'))
                  Text($r('app.string.funding_concerned'))
                    .fontSize($r('app.float.contrasts_size'))
                }
              }
              Row({ space: FundConstants.BOTTOM_ROW_SPACE }) {
                Button($r('app.string.fixed_investment_button'))
                  .width(new BreakpointUtil({
                    sm: $r('app.float.bottom_button_width'),
                    md: $r('app.float.bottom_button_width_md'),
                    lg: $r('app.float.bottom_button_width_md')
                  }).getValue(this.currentPoint))
                  .height($r('app.float.bottom_button_height'))
                  .backgroundColor($r('app.color.five_percent_white_fund'))
                  .fontColor($r('app.color.bottom_button'))
                  .fontSize($r('app.float.common_font_size'))
                  .fontWeight(CommonConstants.FONT_WEIGHT_500)
                Button($r('app.string.buying_button'))
                  .width(new BreakpointUtil({
                    sm: $r('app.float.bottom_button_width'),
                    md: $r('app.float.bottom_button_width_md'),
                    lg: $r('app.float.bottom_button_width_md')
                  }).getValue(this.currentPoint))
                  .height($r('app.float.bottom_button_height'))
                  .backgroundColor($r('app.color.harmony_blue'))
                  .fontColor(Color.White)
                  .fontSize($r('app.float.common_font_size'))
                  .fontWeight(CommonConstants.FONT_WEIGHT_500)
                  .onClick(() => {
                    this.pageInfo.pushPath({ name: CommonConstants.PATH_BUYING, param: this.indexList });
                  })
              }
            }
            .width(CommonConstants.FULL_WIDTH_PERCENT)
            .justifyContent(FlexAlign.SpaceBetween)
            .padding({
              top: $r('app.float.bottom_padding_tb'),
              bottom: $r('app.float.bottom_padding_tb'),
              left: $r('app.float.padding_common'),
              right: $r('app.float.padding_common')
            })
          }
          .height(CommonConstants.FULL_HEIGHT_PERCENT)
          .justifyContent(FlexAlign.SpaceBetween)
        }
      }
      .onBreakpointChange((breakpoints: string) => {
        this.currentPoint = breakpoints;
      })
    }
    .hideTitleBar(true)
    .backgroundColor($r('app.color.common_background'))
    .onBackPressed(() => {
      this.pageIndexInfos.pop();
      return true;
    })
  }
}

@Extend(Button)
function chartButtonStyle() {
  .fontSize($r('app.float.chart_button_size'))
  .fontColor($r('sys.color.mask_secondary'))
  .fontWeight(CommonConstants.FONT_WEIGHT_500)
  .backgroundColor(Color.White)
  .height($r('app.float.chart_button_height'))
  .constraintSize({
    minWidth: $r('app.float.chart_button_min_width'),
    maxWidth: $r('app.float.chart_button_max_width')
  })
}

@Extend(Text)
function buildTextStyle() {
  .fontSize($r('app.float.currency_size'))
  .fontColor($r('app.color.currency_font'))
  .border({
    width: $r('app.float.common_divider'),
    color: $r('app.color.currency_border'),
    radius: $r('app.float.currency_border_radius')
  })
  .padding({
    top: $r('app.float.currency_padding_tb'),
    bottom: $r('app.float.currency_padding_tb'),
    left: $r('app.float.currency_padding_lr'),
    right: $r('app.float.currency_padding_lr')
  })
}
