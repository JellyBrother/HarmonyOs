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

import { BreakpointUtil, BusinessInfo, CommonConstants, RouterConstants } from '@ohos/basic';
import { HomeConstants } from '../constants/HomeConstants';
import HomeViewModel from '../viewmodel/HomeViewModel';

@Component
export struct HomeComponent {
  @Prop currentPoint: string = CommonConstants.BREAK_POINT_SM;
  @Link scrollY: number;
  @StorageLink('pageIndexInfos') pageIndexInfos: NavPathStack = new NavPathStack();
  private offsetValue: number = 0;

  build() {
    Row() {
      Column() {
        Row({ space: HomeConstants.TITLE_ROW_SPACE }) {
          Row({ space: HomeConstants.GPS_ROW_SPACE }) {
            Image($r('app.media.ic_public_gps'))
              .width($r('app.float.common_image_width'))
              .height($r('app.float.common_image_height'))
              .fillColor(this.scrollY < HomeConstants.LIST_SLIDING_OFFSET ||
                (this.currentPoint === CommonConstants.BREAK_POINT_LG &&
                  this.scrollY < HomeConstants.LIST_SLIDING_OFFSET_LG) ? Color.Black : Color.White)
            Text($r('app.string.gps_location'))
              .fontSize($r('app.float.location_size'))
              .fontColor(this.scrollY < HomeConstants.LIST_SLIDING_OFFSET ||
                (this.currentPoint === CommonConstants.BREAK_POINT_LG &&
                  this.scrollY < HomeConstants.LIST_SLIDING_OFFSET_LG) ? Color.Black : Color.White)
              .lineHeight($r('app.float.location_text_height'))
              .fontWeight(FontWeight.Normal)
          }
          .width($r('app.float.gps_width'))

          Blank()

          Search({ placeholder: $r('app.string.search_placeholder') })
            .width(this.currentPoint === CommonConstants.BREAK_POINT_SM ?
              $r('app.float.search_width_sm') : $r('app.float.search_width'))
            .borderColor(this.scrollY < HomeConstants.LIST_SLIDING_OFFSET ||
              (this.currentPoint === CommonConstants.BREAK_POINT_LG &&
                this.scrollY < HomeConstants.LIST_SLIDING_OFFSET_LG) ?
              $r('app.color.five_percent_black') : $r('app.color.five_percent_white'))
            .placeholderColor(this.scrollY < HomeConstants.LIST_SLIDING_OFFSET ||
              (this.currentPoint === CommonConstants.BREAK_POINT_LG &&
                this.scrollY < HomeConstants.LIST_SLIDING_OFFSET_LG) ?
                $r('app.color.sixty_percent_black_home') : $r('app.color.sixty_percent_white_home'))
            .enableKeyboardOnFocus(false)
            .searchIcon({
              color: this.scrollY < HomeConstants.LIST_SLIDING_OFFSET ||
                (this.currentPoint === CommonConstants.BREAK_POINT_LG &&
                  this.scrollY < HomeConstants.LIST_SLIDING_OFFSET_LG) ?
                  $r('app.color.sixty_percent_black_home') : $r('app.color.sixty_percent_white_home')
            })

          Image($r('app.media.ic_public_comments'))
            .width($r('app.float.common_image_width'))
            .height($r('app.float.common_image_height'))
            .fillColor(this.scrollY < HomeConstants.LIST_SLIDING_OFFSET ||
              (this.currentPoint === CommonConstants.BREAK_POINT_LG &&
                this.scrollY < HomeConstants.LIST_SLIDING_OFFSET_LG) ? Color.Black : Color.White)

          Image($r('app.media.ic_public_add_norm'))
            .width($r('app.float.common_image_width'))
            .height($r('app.float.common_image_height'))
            .fillColor(this.scrollY < HomeConstants.LIST_SLIDING_OFFSET ||
              (this.currentPoint === CommonConstants.BREAK_POINT_LG &&
                this.scrollY < HomeConstants.LIST_SLIDING_OFFSET_LG) ? Color.Black : Color.White)
        }
        .width(CommonConstants.FULL_WIDTH_PERCENT)

        Scroll() {
          Column() {
            this.buildMainBusiness()

            Column() {
              if (this.currentPoint === CommonConstants.BREAK_POINT_SM) {
                this.buildButtonBusiness(HomeViewModel.getPhoneBusiness().slice(HomeConstants.BUSINESS_DATA_COUNT_START,
                    HomeConstants.BUSINESS_DATA_COUNT_SM))
                this.buildButtonBusiness(HomeViewModel.getPhoneBusiness().slice(HomeConstants.BUSINESS_DATA_COUNT_SM))
              }
              if (this.currentPoint === CommonConstants.BREAK_POINT_MD) {
                this.buildButtonBusiness(HomeViewModel.getFoldBusiness().slice(HomeConstants.BUSINESS_DATA_COUNT_START,
                  HomeConstants.BUSINESS_DATA_COUNT_MD))
                this.buildButtonBusiness(HomeViewModel.getFoldBusiness().slice(HomeConstants.BUSINESS_DATA_COUNT_MD))
              }
              if (this.currentPoint === CommonConstants.BREAK_POINT_LG) {
                this.buildButtonBusiness(HomeViewModel.getTabletBusiness().slice(HomeConstants.BUSINESS_DATA_COUNT_START,
                  HomeConstants.BUSINESS_DATA_COUNT_LG))
                this.buildButtonBusiness(HomeViewModel.getTabletBusiness().slice(HomeConstants.BUSINESS_DATA_COUNT_LG))
              }
            }
            .backgroundColor(Color.White)
            .width(CommonConstants.FULL_WIDTH_PERCENT)
            .justifyContent(FlexAlign.SpaceBetween)
            .borderRadius($r('app.float.business_border_radius'))
            .padding(this.currentPoint === CommonConstants.BREAK_POINT_LG ?
              $r('app.float.business_padding_lg') : $r('app.float.business_padding'))
            .margin({
              top: $r('app.float.business_margin_top'),
              bottom: this.currentPoint === CommonConstants.BREAK_POINT_LG ?
                $r('app.float.business_margin_bottom_lg') : $r('app.float.business_margin_bottom')
            })
            .height(new BreakpointUtil({
              sm: $r('app.float.business_width_sm'),
              md: $r('app.float.business_width_md'),
              lg: $r('app.float.business_width_lg')
            }).getValue(this.currentPoint))

            Swiper() {
              ForEach(HomeViewModel.getSwiperBusiness(), (item: BusinessInfo) => {
                Image(item.icon)
                  .width(CommonConstants.FULL_WIDTH_PERCENT)
                  .borderRadius($r('app.float.swiper_image_border_radius'))
                  .height(new BreakpointUtil({
                    sm: $r('app.float.swiper_image_height_sm'),
                    md: $r('app.float.swiper_image_height_md'),
                    lg: $r('app.float.swiper_image_height_lg')
                  }).getValue(this.currentPoint))
              }, (item: BusinessInfo, index: number) => index + JSON.stringify(item))
            }
            .autoPlay(true)
            .loop(true)
            .itemSpace(new BreakpointUtil({
              sm: HomeConstants.SWIPER_SPACE_SM,
              md: HomeConstants.SWIPER_SPACE_MD,
              lg: HomeConstants.SWIPER_SPACE_LG
            }).getValue(this.currentPoint))
            .displayCount(new BreakpointUtil({
              sm: HomeConstants.SWIPER_DISPLAY_COUNT_SM,
              md: HomeConstants.SWIPER_DISPLAY_COUNT_MD,
              lg: HomeConstants.SWIPER_DISPLAY_COUNT_LG
            }).getValue(this.currentPoint))
            .indicator(this.currentPoint === CommonConstants.BREAK_POINT_SM ? true : false)

            Row() {
              Text($r('app.string.home_fortune_picks'))
                .fontColor($r('app.color.pick_text'))
                .fontSize($r('app.float.pick_size'))
                .lineHeight($r('app.float.pick_text_height'))
                .fontWeight(CommonConstants.FONT_WEIGHT_500)
                .fontFamily(CommonConstants.FONT_FAMILY_HEI_TI)
            }
            .justifyContent(FlexAlign.Start)
            .width(CommonConstants.FULL_WIDTH_PERCENT)
            .margin({
              top: $r('app.float.pick_margin_top'),
              bottom: $r('app.float.pick_margin_bottom')
            })

            List({ space: HomeConstants.LIST_SPACE }) {
              ForEach(HomeViewModel.getListBusiness(), (item: BusinessInfo) => {
                ListItem() {
                  Image(item.icon)
                    .height(new BreakpointUtil({
                      sm: $r('app.float.list_image_height_sm'),
                      md: $r('app.float.list_image_height_md'),
                      lg: $r('app.float.list_image_height_lg')
                    }).getValue(this.currentPoint))
                    .width(CommonConstants.FULL_WIDTH_PERCENT)
                    .borderRadius($r('app.float.list_image_radius'))
                    .onClick(() => {
                      this.pageIndexInfos.pushPathByName(RouterConstants.FUNDING_URL, null);
                    })
                }
              }, (item: BusinessInfo, index: number) => index + JSON.stringify(item))
            }
            .width(CommonConstants.FULL_WIDTH_PERCENT)
            .lanes(new BreakpointUtil({
              sm: HomeConstants.LIST_LANES_COUNT_SM,
              md: HomeConstants.LIST_LANES_COUNT_MD,
              lg: HomeConstants.LIST_LANES_COUNT_LG
            }).getValue(this.currentPoint), $r('app.float.list_lanes_space'))
          }
        }
        .padding({
          top: $r('app.float.scroll_margin_top'),
          bottom: $r('app.float.common_height')
        })
        .scrollBar(BarState.Off)
        .onWillScroll((xOffset: number, yOffset: number) => {
          this.offsetValue = this.offsetValue - yOffset;
          if (this.offsetValue > 0) {
            this.offsetValue = 0;
          }
          this.scrollY = vp2px(this.offsetValue);
        })
      }
      .height(CommonConstants.FULL_HEIGHT_PERCENT)
    }
    .alignItems(VerticalAlign.Top)
    .padding({
      top: $r('app.float.content_padding_top'),
      left: $r('app.float.padding_common'),
      right: $r('app.float.padding_common')
    })
  }

  @Builder
  buildMainBusiness() {
    Row() {
      ForEach(HomeViewModel.getMainBusiness(), (item: BusinessInfo) => {
        if (this.currentPoint === CommonConstants.BREAK_POINT_SM) {
          Column({ space: HomeConstants.MAIN_ROW_SPACE }) {
            Image(item.icon)
              .width($r('app.float.main_image'))
              .height($r('app.float.main_image'))
            Text(item.text)
              .fontSize($r('app.float.main_business_size'))
              .fontColor(Color.White)
          }
          .onClick(() => {
            if (item.router) {
              this.pageIndexInfos.pushPathByName(item.router, null);
            }
          })
        } else {
          Row() {
            Image(item.iconBig)
              .width($r('app.float.main_image_big'))
              .height($r('app.float.main_image_big'))
            Text(item.text)
              .fontSize($r('app.float.main_business_size'))
              .fontColor(Color.White)
              .margin({
                left: new BreakpointUtil({
                  md: HomeConstants.BUSINESS_ROW_SPACE_MD,
                  lg: HomeConstants.BUSINESS_ROW_SPACE_LG
                }).getValue(this.currentPoint)
              })
          }
          .width(HomeConstants.MAIN_BUSINESS_WIDTH)
          .height(new BreakpointUtil({
            md: $r('app.float.business_row_height_md'),
            lg: $r('app.float.business_row_height_lg')
          }).getValue(this.currentPoint))
          .alignSelf(ItemAlign.Center)
          .justifyContent(FlexAlign.Center)
          .borderRadius($r('app.float.business_row_radius'))
          .backgroundColor($r('app.color.business_background'))
          .onClick(() => {
            if (item.router) {
              this.pageIndexInfos.pushPathByName(item.router, null);
            }
          })
        }
      }, (item: BusinessInfo, index: number) => index + JSON.stringify(item))
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({
      left: new BreakpointUtil({
        sm: $r('app.float.main_padding_left_sm'),
        md: $r('app.float.main_padding_left_md'),
        lg: $r('app.float.main_padding_left_lg')
      }).getValue(this.currentPoint),
      right: new BreakpointUtil({
        sm: $r('app.float.main_padding_left_sm'),
        md: $r('app.float.main_padding_left_md'),
        lg: $r('app.float.main_padding_left_lg')
      }).getValue(this.currentPoint)
    })
    .width(CommonConstants.FULL_WIDTH_PERCENT)
  }

  @Builder
  buildButtonBusiness(list: BusinessInfo[]) {
    Row() {
      ForEach(list, (item: BusinessInfo) => {
        Column({ space: HomeConstants.BUTTON_ROW_SPACE }) {
          Image(item.icon)
            .width($r('app.float.common_image_width'))
            .height($r('app.float.common_image_height'))
          Text(item.text)
            .fontSize($r('app.float.button_text_size'))
            .fontColor(Color.Black)
        }
        .width($r('app.float.button_business_width'))
      }, (item: BusinessInfo, index?: number) => index + JSON.stringify(item))
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width(CommonConstants.FULL_WIDTH_PERCENT)
  }
}