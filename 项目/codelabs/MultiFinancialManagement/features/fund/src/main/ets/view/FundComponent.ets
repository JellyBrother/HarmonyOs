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

import { BreakpointUtil, BusinessInfo, CommonConstants, FundDetail, RouterConstants } from '@ohos/basic';
import { FundConstants } from '../constants/FundConstants';
import FundingViewModel from '../viewmodel/FundingViewModel';

@Component
export struct FundComponent {
  @State currentPoint: string = CommonConstants.BREAK_POINT_SM;
  @State tabBarIndex: number = 0;
  @State backgroundX: number = 0;
  @StorageProp('avoidArea') topHeight: number = 0;
  @StorageProp('bottom') bottom: number = 0;
  @StorageLink('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack();
  private controller: TabsController = new TabsController();

  build() {
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
        Row() {
          Image($r('app.media.ic_public_back'))
            .width($r('app.float.common_image'))
            .height($r('app.float.common_image'))
            .fillColor(Color.Black)
            .onClick(() => {
              this.pageIndexInfos.pop();
            })

          Search({ placeholder: $r('app.string.search_placeholder') })
            .visibility(this.currentPoint === CommonConstants.BREAK_POINT_SM ? Visibility.Visible : Visibility.None)
            .enableKeyboardOnFocus(false)
            .placeholderColor($r('sys.color.mask_secondary'))
            .borderColor($r('app.color.five_percent_white_fund'))
            .searchIcon({
              color: $r('sys.color.mask_secondary')
            })
            .width(this.currentPoint === CommonConstants.BREAK_POINT_SM ?
              $r('app.float.search_width_sm') : $r('app.float.search_width'))
            .margin({
              left: $r('app.float.common_margin'),
              right: $r('app.float.common_margin')
            })

          Row() {
            Search({ placeholder: $r('app.string.search_placeholder') })
              .visibility(this.currentPoint === CommonConstants.BREAK_POINT_SM ? Visibility.None : Visibility.Visible)
              .enableKeyboardOnFocus(false)
              .placeholderColor($r('sys.color.mask_secondary'))
              .borderColor($r('app.color.five_percent_white_fund'))
              .searchIcon({
                color: $r('sys.color.mask_secondary')
              })
              .width(this.currentPoint === CommonConstants.BREAK_POINT_SM ?
                $r('app.float.search_width_sm') : $r('app.float.search_width'))
              .margin({
                left: $r('app.float.common_margin'),
                right: $r('app.float.common_margin')
              })
            Image($r('app.media.ic_public_comments'))
              .width($r('app.float.common_image'))
              .height($r('app.float.common_image'))
              .fillColor(Color.Black)
          }
        }
        .width(CommonConstants.FULL_WIDTH_PERCENT)
        .backgroundColor(Color.White)
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({
          left: $r('app.float.padding_common'),
          right: $r('app.float.padding_common'),
          top: $r('app.float.title_padding_tb'),
          bottom: $r('app.float.title_padding_tb')
        })
        .margin({
          top: this.topHeight
        })
      }

      GridCol({
        span: {
          sm: CommonConstants.COLUMN_SM,
          md: CommonConstants.COLUMN_MD,
          lg: CommonConstants.COLUMN_LG
        }
      }) {
        Column() {
          Scroll() {
            Column() {
              this.buildMyFundingInfo()

              this.buildSwiperButton()

              this.buildSteadyGrowth()

              Column() {
                Row() {
                  Image($r('app.media.ic_pursue_profit'))
                    .width($r('app.float.common_image'))
                    .height($r('app.float.common_image'))
                  Text($r('app.string.pursue_profit'))
                    .fontSize($r('app.float.common_font_size'))
                    .fontColor($r('app.color.pursue_text'))
                    .lineHeight($r('app.float.common_line_height'))
                    .fontWeight(FontWeight.Regular)
                    .margin({
                      left: $r('app.float.pursue_margin_left')
                    })
                }
                .width(CommonConstants.FULL_WIDTH_PERCENT)
                .justifyContent(FlexAlign.Start)

                Row({ space: FundConstants.TAB_ROW_SPACE }) {
                  this.buildTabBarText($r('app.string.common_stock'), 0)
                  this.buildTabBarText($r('app.string.partial_stock_mix'), 1)
                  this.buildTabBarText($r('app.string.flexible_configuration'), 2)
                  this.buildTabBarText($r('app.string.index_funds'), 3)
                }
                .width(CommonConstants.FULL_WIDTH_PERCENT)
                .justifyContent(FlexAlign.Start)
                .alignItems(VerticalAlign.Center)
                .height($r('app.float.title_height'))

                Tabs({ barPosition: BarPosition.Start, controller: this.controller }) {
                  TabContent(){
                    Row() {
                      List() {
                        ForEach(new BreakpointUtil({
                          sm: FundingViewModel.getAllFundInfo(0, 2),
                          md: FundingViewModel.getAllFundInfo(0, 4),
                          lg: FundingViewModel.getAllFundInfo(0, 6)
                        }).getValue(this.currentPoint), (item: FundDetail) => {
                          ListItem() {
                            Row() {
                              Text(item.amplitude)
                                .fontSize($r('app.float.amplitude_text_size'))
                                .fontColor($r('app.color.amplitude_text_font'))
                                .fontWeight(CommonConstants.FONT_WEIGHT_700)
                              Text(item.name)
                                .fontSize($r('app.float.common_font_size'))
                                .fontWeight(CommonConstants.FONT_WEIGHT_500)
                                .fontFamily(CommonConstants.FONT_FAMILY_HEI_TI)
                                .margin({
                                  left: $r('app.float.margin_text_left')
                                })
                            }
                            .justifyContent(FlexAlign.SpaceAround)
                          }
                        })
                      }
                      .lanes(new BreakpointUtil({
                        sm: 1,
                        md: 2,
                        lg: 3
                      }).getValue(this.currentPoint))
                      .width(CommonConstants.FULL_WIDTH_PERCENT)
                      .scrollBar(BarState.Off)
                    }
                    .height(CommonConstants.FULL_HEIGHT_PERCENT)
                    .alignItems(VerticalAlign.Top)
                  }
                  .tabBar($r('app.string.common_stock'))
                  TabContent(){
                  }
                  .tabBar($r('app.string.partial_stock_mix'))
                  TabContent(){
                  }
                  .tabBar($r('app.string.flexible_configuration'))
                  TabContent(){
                  }
                  .tabBar($r('app.string.index_funds'))
                }
                .barHeight(0)
                .scrollable(false)
                .barMode(BarMode.Scrollable)
                .barWidth(CommonConstants.FULL_WIDTH_PERCENT)
                .height($r('app.float.profit_tab_height'))
              }
              .backgroundColor(Color.White)
              .padding($r('app.float.bottom_padding'))
              .margin({
                top: $r('app.float.bottom_margin_top')
              })
            }
          }
          .scrollBar(BarState.Off)
        }
        .margin({
          top: $r('app.float.scroll_margin_top'),
          bottom: this.bottom
        })
      }
      .backgroundColor($r('app.color.common_background'))
      .padding({
        left: $r('app.float.padding_common'),
        right: $r('app.float.padding_common')
      })
    }
    .onBreakpointChange((breakpoints: string) => {
      this.currentPoint = breakpoints;
    })
  }

  @Builder
  buildTabBarText(text: ResourceStr, index: number) {
    Text(text)
      .fontSize($r('app.float.tab_text_size_fund'))
      .lineHeight($r('app.float.common_line_height'))
      .fontColor(this.tabBarIndex === index ? $r('app.color.harmony_blue') : Color.Black)
      .border({
        width: {
          bottom: $r('app.float.tab_bar_border')
        },
        color: this.tabBarIndex === index ? $r('app.color.harmony_blue') : $r('app.color.transparent_color')
      })
      .padding({
        bottom: $r('app.float.tab_bar_padding_bottom')
      })
      .onClick(() => {
        this.tabBarIndex = index;
        this.controller.changeIndex(this.tabBarIndex);
      })
  }

  @Builder
  buildSteadyGrowth() {
    Column() {
      Row() {
        Image($r('app.media.ic_steady_growth'))
          .width($r('app.float.common_image'))
          .height($r('app.float.common_image'))
        Text($r('app.string.steady_growth'))
          .fontSize($r('app.float.common_font_size'))
          .fontColor($r('app.color.steady_font'))
          .lineHeight($r('app.float.common_line_height'))
          .fontWeight(FontWeight.Regular)
          .margin({
            left: $r('app.float.steady_margin_left')
          })
      }
      .width(CommonConstants.FULL_WIDTH_PERCENT)
      .justifyContent(FlexAlign.Start)

      List() {
        ForEach(new BreakpointUtil({
          sm: FundingViewModel.getAllFundInfo(FundConstants.FUND_COUNT_START, FundConstants.FUND_COUNT_SM),
          md: FundingViewModel.getAllFundInfo(FundConstants.FUND_COUNT_START, FundConstants.FUND_COUNT_MD),
          lg: FundingViewModel.getAllFundInfo(FundConstants.FUND_COUNT_START, FundConstants.FUND_COUNT_LG)
        }).getValue(this.currentPoint), (item: FundDetail, index: number) => {
          ListItem() {
            Column() {
              Text(item.name)
                .fontSize($r('app.float.common_font_size'))
                .fontWeight(CommonConstants.FONT_WEIGHT_500)
                .fontFamily(CommonConstants.FONT_FAMILY_HEI_TI)
              Text(item.amplitude)
                .fontSize($r('app.float.amplitude_text_size'))
                .fontColor($r('app.color.amplitude_text_font'))
                .fontWeight(CommonConstants.FONT_WEIGHT_700)
              Text($r('app.string.one_year_amplitude'))
                .fontSize($r('app.float.year_text_size'))
                .fontColor($r('app.color.forty_percent_white'))
            }
            .height($r('app.float.list_item_height'))
            .width($r('app.float.list_item_width'))
            .justifyContent(FlexAlign.SpaceAround)
            .onClick(() => {
              this.pageIndexInfos.pushPathByName(RouterConstants.FUNDING_DETAIL_URL,
                { 'listIndex': index } as Record<string, number>);
            })
          }
          .width(CommonConstants.FULL_WIDTH_PERCENT)
        })
      }
      .lanes(new BreakpointUtil({
        sm: FundConstants.LIST_LANES_SM,
        md: FundConstants.LIST_LANES_MD,
        lg: FundConstants.LIST_LANES_LG
      }).getValue(this.currentPoint),
        this.currentPoint === CommonConstants.BREAK_POINT_SM ?
          $r('app.float.list_space_sm') : $r('app.float.list_space'))
      .width(CommonConstants.FULL_WIDTH_PERCENT)
      .margin({
        top: $r('app.float.common_margin'),
        bottom: $r('app.float.list_margin_bottom')
      })
    }
    .backgroundColor(Color.White)
    .padding($r('app.float.list_padding'))
  }

  @Builder
  buildSwiperButton() {
    Swiper() {
      Row() {
        ForEach(new BreakpointUtil({
          sm: FundingViewModel.getFundingButtonBusiness(FundConstants.FUND_COUNT_START, FundConstants.BUTTON_COUNT_SM),
          md: FundingViewModel.getFundingButtonBusiness(FundConstants.FUND_COUNT_START, FundConstants.BUTTON_COUNT_MD),
          lg: FundingViewModel.getFundingButtonBusiness(FundConstants.FUND_COUNT_START)
        }).getValue(this.currentPoint), (item: BusinessInfo) => {
          Column() {
            Image(item.icon)
              .width($r('app.float.common_image'))
              .height($r('app.float.common_image'))
            Text(item.text)
              .fontSize($r('app.float.button_text_size'))
              .fontWeight(FontWeight.Normal)
              .margin({
                top: $r('app.float.button_text_margin_top')
              })
          }
        }, (item: BusinessInfo, index?: number) => index + JSON.stringify(item))
      }
      .height($r('app.float.swiper_height'))
      .width(CommonConstants.FULL_WIDTH_PERCENT)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Top)
      if (this.currentPoint !== CommonConstants.BREAK_POINT_LG) {
        Row() {
          ForEach(new BreakpointUtil({
            sm: FundingViewModel.getFundingButtonBusiness(FundConstants.BUTTON_COUNT_SM),
            md: FundingViewModel.getFundingButtonBusiness(FundConstants.BUTTON_COUNT_MD)
          }).getValue(this.currentPoint), (item: BusinessInfo) => {
            Column() {
              Image(item.icon)
                .width($r('app.float.common_image'))
                .height($r('app.float.common_image'))
              Text(item.text)
                .fontSize($r('app.float.button_text_size'))
                .fontWeight(FontWeight.Normal)
                .margin({
                  top: $r('app.float.button_text_margin_top')
                })
            }
          }, (item: BusinessInfo, index?: number) => index + JSON.stringify(item))

          ForEach(new BreakpointUtil({
            sm: FundingViewModel.getFundingButtonBusiness(FundConstants.FUND_COUNT_START, FundConstants.COLUMN_COUNT_SM),
            md: FundingViewModel.getFundingButtonBusiness(FundConstants.FUND_COUNT_START, FundConstants.COLUMN_COUNT_MD)
          }).getValue(this.currentPoint), () => {
            Column() {
            }
            .width($r('app.float.column_swiper_width'))
          }, (item: BusinessInfo, index?: number) => index + JSON.stringify(item))
        }
        .height($r('app.float.swiper_height'))
        .width(CommonConstants.FULL_WIDTH_PERCENT)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Top)
      }
    }
    .height(this.currentPoint === CommonConstants.BREAK_POINT_LG ?
      $r('app.float.swiper_build_height_lg') : $r('app.float.swiper_build_height'))
    .indicator(this.currentPoint === CommonConstants.BREAK_POINT_LG ? false : true)
    .margin({
      top: $r('app.float.swiper_build_margin_top')
    })
  }

  @Builder
  buildMyFundingInfo() {
    Column() {
      Column() {
        Column() {
          Row() {
            Text($r('app.string.my_funding'))
              .fontWeight(FontWeight.Normal)
              .fontColor(Color.White)
              .fontSize($r('app.float.my_fund_size'))
            Row() {
              Text($r('app.string.my_concern'))
                .fontWeight(FontWeight.Normal)
                .fontColor(Color.White)
                .fontSize($r('app.float.my_fund_size'))
                .margin({
                  right: $r('app.float.concern_margin_right')
                })
              Image($r('app.media.ic_public_arrow_right'))
                .width($r('app.float.arrow_width'))
                .height($r('app.float.common_image'))
                .fillColor(Color.White)
            }
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .width(CommonConstants.FULL_WIDTH_PERCENT)

          Text($r('app.string.my_amount'))
            .fontSize($r('app.float.amount_text_size'))
            .fontColor(Color.White)
            .fontWeight(CommonConstants.FONT_WEIGHT_700)
            .margin({
              top: $r('app.float.amount_margin_top')
            })
        }
        .alignItems(HorizontalAlign.Start)

        Row() {
          Image($r('app.media.ic_public_sound'))
            .width($r('app.float.common_image'))
            .height($r('app.float.common_image'))
            .fillColor($r('app.color.sixty_percent_black'))
          Text($r('app.string.funding_news'))
            .fontSize($r('app.float.news_text_size'))
            .fontColor($r('sys.color.font_on_secondary'))
            .fontWeight(FontWeight.Normal)
            .textOverflow({
              overflow: TextOverflow.Ellipsis
            })
            .maxLines(1)
            .layoutWeight(1)
            .margin({
              left: $r('app.float.sixty_margin_left')
            })
        }
        .width(CommonConstants.FULL_WIDTH_PERCENT)
      }
      .width(CommonConstants.FULL_WIDTH_PERCENT)
      .height(CommonConstants.FULL_HEIGHT_PERCENT)
      .backgroundImage($r('app.media.ic_fund_background'))
      .backgroundImageSize({
        width: $r('app.float.ic_background_image_width'),
        height: $r('app.float.ic_background_image_height')
      })
      .backgroundImagePosition({
        x: this.backgroundX,
        y: this.currentPoint === CommonConstants.BREAK_POINT_LG ?
          $r('app.float.ic_background_position_lg') : $r('app.float.ic_background_position')
      })
      .padding({
        top: $r('app.float.padding_common'),
        bottom: $r('app.float.info_padding_bottom'),
        left: new BreakpointUtil({
          sm: $r('app.float.info_padding_left'),
          md: $r('app.float.padding_common'),
          lg: $r('app.float.padding_common')
        }).getValue(this.currentPoint),
        right: new BreakpointUtil({
          sm: $r('app.float.info_padding_right_sm'),
          md: $r('app.float.info_padding_right_md'),
          lg: $r('app.float.info_padding_right_lg')
        }).getValue(this.currentPoint)
      })
    }
    .height($r('app.float.funding_info_height'))
    .width(CommonConstants.FULL_WIDTH_PERCENT)
    .linearGradient({
      direction: GradientDirection.Right,
      colors: [['#0954EA', 0], ['#6193F6', 0.91], ['#88AFFC', 1]]
    })
    .justifyContent(FlexAlign.SpaceBetween)
    .borderRadius($r('app.float.info_radius'))
    .onAreaChange((oldVale: Area, newVale: Area) => {
      let width = newVale.width;
      if (typeof width === 'number') {
        if (this.currentPoint === CommonConstants.BREAK_POINT_LG) {
          this.backgroundX = width - FundConstants.CALCULATE_POSITION_LG;
        } else {
          this.backgroundX = width - FundConstants.CALCULATE_POSITION;
        }
      }
      this.backgroundX = vp2px(this.backgroundX)
    })
  }
}