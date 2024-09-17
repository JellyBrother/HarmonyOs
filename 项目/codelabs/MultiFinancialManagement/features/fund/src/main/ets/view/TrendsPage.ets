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

import { Callback } from '@kit.BasicServicesKit';
import { display } from '@kit.ArkUI';
import { window } from '@kit.ArkUI';
import { LineChart, LineChartModel } from '@ohos/mpchart';
import { BreakpointUtil, CommonConstants, logger } from '@ohos/basic/';
import ChartViewModel from '../viewmodel/ChartViewModel';
import { ChartLegendComponent } from './ChartLegendComponent';
import { FundConstants } from '../constants/FundConstants';

@Component
export struct TrendsPage {
  @State showChart: boolean = true;
  @State lineChartModel: LineChartModel = ChartViewModel.getLineChartModel();
  @State tabBarIndex: number = 0;
  @State name: string = '';
  @State currentPoint: string = CommonConstants.BREAK_POINT_MD;
  @StorageProp('breakPoint') breakPoint: string = CommonConstants.BREAK_POINT_MD;
  @StorageProp('avoidArea') areaLeft: number = 0;
  @State isLandScape: boolean = false;
  @StorageLink('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack();
  private controller: TabsController = new TabsController();
  private callback: Callback<display.FoldDisplayMode> = (data: display.FoldDisplayMode) => {
    if (this.isLandScape && data === display.FoldDisplayMode.FOLD_DISPLAY_MODE_FULL) {
      window.getLastWindow(getContext(this)).then((stage: window.Window) => {
        stage.setPreferredOrientation(window.Orientation.PORTRAIT);
      });
    }
    if (data === display.FoldDisplayMode.FOLD_DISPLAY_MODE_MAIN) {
      window.getLastWindow(getContext(this)).then((stage: window.Window) => {
        stage.setPreferredOrientation(window.Orientation.LANDSCAPE)
      });
      this.isLandScape = true;
    }
  };

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
          Row() {
            Row() {
              Text(this.name)
                .fontSize($r('app.float.common_font_size'))
                .fontColor($r('app.color.name_text'))
                .lineHeight($r('app.float.common_line_height'))
                .fontWeight(CommonConstants.FONT_WEIGHT_500)
              Text($r('app.string.funding_code'))
                .fontSize($r('app.float.code_size'))
                .fontColor($r('app.color.forty_percent_white'))
                .margin({
                  left: $r('app.float.code_margin_left')
                })
            }
            .alignItems(VerticalAlign.Bottom)

            Image($r('app.media.ic_public_reduce'))
              .width($r('app.float.common_image'))
              .height($r('app.float.common_image'))
              .onClick(() => {
                this.pageIndexInfos.pop();
              })
          }
          .width(CommonConstants.FULL_WIDTH_PERCENT)
          .justifyContent(FlexAlign.SpaceBetween)
        }

        GridCol({
          span: {
            sm: CommonConstants.COLUMN_SM,
            md: CommonConstants.COLUMN_MD,
            lg: CommonConstants.COLUMN_LG
          }
        }) {
          Column() {
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
            .width(CommonConstants.FULL_WIDTH_PERCENT)
            .justifyContent(FlexAlign.Start)
            .alignItems(VerticalAlign.Center)
            .margin({
              bottom: $r('app.float.tab_bar_top')
            })
            .height($r('app.float.title_height'))

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
                  .padding({
                    left: new BreakpointUtil({
                      sm: $r('app.float.legend_padding_lr'),
                      md: $r('app.float.legend_padding_lr'),
                      lg: $r('app.float.legend_padding_lr_lg')
                    }).getValue(this.currentPoint),
                    right: new BreakpointUtil({
                      sm: $r('app.float.legend_padding_lr'),
                      md: $r('app.float.legend_padding_lr'),
                      lg: $r('app.float.legend_padding_lr_lg')
                    }).getValue(this.currentPoint)
                  })

                  Row() {
                    if (this.showChart) {
                      LineChart({ model: this.lineChartModel })
                    } else {
                      LineChart({ model: this.lineChartModel })
                    }
                  }
                  .width(CommonConstants.FULL_WIDTH_PERCENT)
                  .layoutWeight(1)
                  .onAreaChange(() => {
                    this.lineChartModel = ChartViewModel.getLineChartModel();
                    this.showChart = !this.showChart;
                  })

                  Row() {
                    Button($r('app.string.near_month', 1))
                      .fontSize($r('app.float.chart_button_size'))
                      .fontColor($r('app.color.harmony_blue'))
                      .fontWeight(CommonConstants.FONT_WEIGHT_500)
                      .backgroundColor($r('app.color.five_percent_white_fund'))
                      .height($r('app.float.chart_button_height'))
                      .width(new BreakpointUtil({
                        sm: $r('app.float.near_button_width'),
                        md: $r('app.float.near_button_width'),
                        lg: $r('app.float.near_button_width_lg')
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
            .barMode(BarMode.Scrollable, { margin: $r('app.float.tab_bar_margin') })
            .barHeight(0)
            .scrollable(false)
            .layoutWeight(1)
            .focusable(false)
          }
        }
      }
      .width(CommonConstants.FULL_WIDTH_PERCENT)
      .height(CommonConstants.FULL_HEIGHT_PERCENT)
      .padding({
        left: $r('app.float.padding_common'),
        right: this.isLandScape ? this.areaLeft : $r('app.float.padding_common'),
        bottom: $r('app.float.padding_common'),
        top: this.currentPoint === CommonConstants.BREAK_POINT_LG ? $r('app.float.trends_padding_top') : 0
      })
      .onBreakpointChange((breakpoints: string) => {
        this.currentPoint = breakpoints;
      })
    }
    .hideTitleBar(true)
    .onAppear(() => {
      window.getLastWindow(getContext(this)).then((windowStage: window.Window) => {
        windowStage.setWindowLayoutFullScreen(false);
      })
      if (!this.isLandScape && this.breakPoint === CommonConstants.BREAK_POINT_SM) {
        window.getLastWindow(getContext(this)).then((stage: window.Window) => {
          stage.setPreferredOrientation(window.Orientation.LANDSCAPE);
          this.isLandScape = true;
        });
      }
      try {
        display.on('foldDisplayModeChange', this.callback);
      } catch (exception) {
        logger.error('Failed to register callback. Code: ' + JSON.stringify(exception));
      }
    })
    .onWillDisappear(() => {
      window.getLastWindow(getContext(this)).then((windowStage: window.Window) => {
        windowStage.setWindowLayoutFullScreen(true);
      })
      if (this.isLandScape) {
        window.getLastWindow(getContext(this)).then((stage: window.Window) => {
          stage.setPreferredOrientation(window.Orientation.PORTRAIT);
        });
        this.isLandScape = false;
      }
      try {
        display.off('foldDisplayModeChange', this.callback);
      } catch (exception) {
        logger.error('Failed to register callback. Code: ' + JSON.stringify(exception));
      }
    })
  }
}

@Extend(Button)
function chartButtonStyle() {
  .fontSize($r('app.float.chart_button_size'))
  .fontColor($r('app.color.sixty_percent_white'))
  .fontWeight(CommonConstants.FONT_WEIGHT_500)
  .backgroundColor(Color.White)
  .height($r('app.float.chart_button_height'))
  .constraintSize({
    minWidth: $r('app.float.chart_button_min_width'),
    maxWidth: $r('app.float.chart_button_max_width')
  })
}