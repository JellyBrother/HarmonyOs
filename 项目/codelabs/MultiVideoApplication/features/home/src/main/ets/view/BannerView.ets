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
import { HomeConstants } from '../constants/HomeConstants';
import { Banner, BannerViewModel } from '../viewmodel/BannerViewModel';
import { getTabIndex } from './CommonView';

class BannerDataSource implements IDataSource {
  private bannerImgList: Banner[] = [];

  constructor(bannerImgList: Banner[]) {
    this.bannerImgList = bannerImgList;
  }

  totalCount(): number {
    return this.bannerImgList.length;
  }

  getData(index: number): Banner {
    return this.bannerImgList[index];
  }

  registerDataChangeListener(listener: DataChangeListener): void {
  }

  unregisterDataChangeListener() {
  }
}

@Component
export struct BannerView {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @StorageLink('windowWidth') windowWidth: number = 0;
  @StorageLink('currentTopIndex') currentTopIndex: number = 0;
  private bannerImgList: Banner[] = new BannerViewModel().getBannerList();
  private bannerDataSource: BannerDataSource = new BannerDataSource([]);

  aboutToAppear(): void {
    this.bannerDataSource = new BannerDataSource(this.bannerImgList);
  }

  @Styles focusedStyles(): void {
    .border({
      width: $r('app.float.focus_radius_width'),
      color: $r('app.color.focus_radius_color'),
      radius: $r('app.float.banner_focus_radius')
    })
  }

  @Styles normalStyles(): void {
    .border({
      width: 0,
      radius: $r('app.float.banner_focus_radius')
    })
  }

  build() {
    Column() {
      // Banner layout.
      Row() {
        Swiper() {
          LazyForEach(this.bannerDataSource, (item: Banner, index: number) => {
            Stack() {
              Image(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM ? item.getBannerImg().getImgSrcSm() :
                item.getBannerImg().getImgSrc())
                .objectFit(ImageFit.Fill)
                .borderRadius($r('app.float.banner_img_border_radius'))
                .height(CommonConstants.FULL_PERCENT)
                .width(CommonConstants.FULL_PERCENT)
                .focusable(true)
                .groupDefaultFocus(index === 0 ? true : false)
                .stateStyles({
                  normal: this.normalStyles,
                  focused: this.focusedStyles
                })

              Column() {
                Text(item.getDescription().getIsLeftCenter().getValue(this.currentBreakpoint) ?
                  item.getDescription().getDescription()[0] + item.getDescription().getDescription()[1] :
                  item.getDescription().getDescription()[0])
                  .fontSize(item.getDescription().getFontSize().getValue(this.currentBreakpoint)[0])
                  .fontWeight(item.getDescription().getFontWeight()[0])
                  .lineHeight(item.getDescription().getLineHeight().getValue(this.currentBreakpoint)[0])
                  .fontColor(Color.White)
                  .letterSpacing(HomeConstants.BANNER_TEXT_LETTER_SPACES[2])
                  .maxLines(1)

                Text(item.getDescription().getDescription()[1])
                  .fontSize(item.getDescription().getFontSize().getValue(this.currentBreakpoint)[0])
                  .fontWeight(item.getDescription().getFontWeight()[0])
                  .lineHeight(item.getDescription().getLineHeight().getValue(this.currentBreakpoint)[0])
                  .fontColor(Color.White)
                  .letterSpacing(HomeConstants.BANNER_TEXT_LETTER_SPACES[2])
                  .maxLines(1)
                  .visibility(item.getDescription().getIsLeftCenter().getValue(this.currentBreakpoint) ?
                    Visibility.None : Visibility.Visible)

                Text(item.getDescription().getDescription()[2])
                  .fontSize(item.getDescription().getFontSize().getValue(this.currentBreakpoint)[1])
                  .fontWeight(item.getDescription().getFontWeight()[1])
                  .lineHeight(item.getDescription().getLineHeight().getValue(this.currentBreakpoint)[1])
                  .fontColor(Color.White)
                  .margin({
                    top: item.getDescription().getTopPosition().getValue(this.currentBreakpoint)[1]
                  })
                  .letterSpacing(HomeConstants.BANNER_TEXT_LETTER_SPACES[1])
                  .maxLines(1)
              }
              .padding({
                left: !item.getDescription().getIsLeftCenter().getValue(this.currentBreakpoint) ?
                item.getDescription().getLeftPosition().getValue(this.currentBreakpoint)[0] : '0',
                top: !item.getDescription().getIsTopCenter().getValue(this.currentBreakpoint) ?
                item.getDescription().getTopPosition().getValue(this.currentBreakpoint)[0] : '0'
              })
              .alignItems(item.getDescription().getIsLeftCenter().getValue(this.currentBreakpoint) ?
                HorizontalAlign.Center : HorizontalAlign.Start)
              .justifyContent(!item.getDescription().getIsTopCenter().getValue(this.currentBreakpoint) ?
                FlexAlign.Start : FlexAlign.Center)
              .height(CommonConstants.FULL_PERCENT)
              .width(CommonConstants.FULL_PERCENT)
            }
            .height(item.getBannerImg().getHeight().getValue(this.currentBreakpoint))
            .width(CommonConstants.FULL_PERCENT)
            // The width and height vary with the container assembly and the aspect ratio remains unchanged.
            .aspectRatio(new BreakpointType(HomeConstants.BANNER_RATIOS[0], HomeConstants.BANNER_RATIOS[1],
              HomeConstants.BANNER_RATIOS[2]).getValue(this.currentBreakpoint))
          }, (item: Banner, index: number) => index + JSON.stringify(item))
        }
        .tabIndex(getTabIndex(HomeConstants.DIRECTION_LIST[2]))
        .index(2)
        .displayCount(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM ? 1 : HomeConstants.TWO)
        // Interval between banner images
        .itemSpace(HomeConstants.SWIPER_ITEM_SPACE)
        // Setting the navigation point Style of the swiper.
        .indicator(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM ? Indicator.dot()
          .itemWidth($r('app.float.swiper_item_size'))
          .itemHeight($r('app.float.swiper_item_size'))
          .selectedItemWidth($r('app.float.swiper_selected_item_width'))
          .selectedItemHeight($r('app.float.swiper_item_size'))
          .color($r('app.color.swiper_indicator'))
          .selectedColor(Color.White) : false
        )
        .loop(true)
        .width(CommonConstants.FULL_PERCENT)
        .visibility((this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG) && (this.currentTopIndex === 1) ?
          Visibility.None : Visibility.Visible)
        .effectMode(EdgeEffect.None)
        // The sizes of the front and rear banners on the MD and LG devices are different.
        .prevMargin(new BreakpointType($r('app.float.swiper_prev_next_margin_sm'),
          $r('app.float.swiper_prev_next_margin_md'), $r('app.float.swiper_prev_next_margin_lg'))
          .getValue(this.currentBreakpoint))
        .nextMargin(new BreakpointType($r('app.float.swiper_prev_next_margin_sm'),
          $r('app.float.swiper_prev_next_margin_md'), $r('app.float.swiper_prev_next_margin_lg'))
          .getValue(this.currentBreakpoint))

        // Switch the tab to switch the banner display effect.
        Row({ space: HomeConstants.BANNER_ROW_SPACE }) {
          BannerText({
            banner: this.bannerImgList[2],
            index: 0
          })
            .layoutWeight(CommonConstants.FOUR)
            .height(CommonConstants.FULL_PERCENT)

          BannerText({
            banner: this.bannerImgList[1],
            index: 1
          })
            .layoutWeight(CommonConstants.FOUR)
            .height(CommonConstants.FULL_PERCENT)

          Column() {
            BannerText({
              banner: this.bannerImgList[0],
              index: 2
            })
              .margin({ bottom: $r('app.float.new_banner_3_margin') })
              .layoutWeight(1)

            BannerText({
              banner: this.bannerImgList[4],
              index: 3
            })
              .margin({ top: $r('app.float.new_banner_3_margin') })
              .layoutWeight(1)
          }
          .layoutWeight(CommonConstants.THREE)
        }
        .height(this.getBannerNewHeight(this.windowWidth))
        .width(CommonConstants.FULL_PERCENT)
        .visibility((this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG) && (this.currentTopIndex === 1) ?
          Visibility.Visible : Visibility.None)
        .padding({
          left: $r('app.float.banner_padding_sm'),
          right: $r('app.float.banner_padding_sm')
        })
      }
      .width(CommonConstants.FULL_PERCENT)
      .margin({
        top: $r('app.float.banner_margin'),
        bottom: $r('app.float.banner_margin')
      })
      .padding({
        left: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM ? $r('app.float.banner_padding_sm') : '0',
        right: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM ? $r('app.float.banner_padding_sm') : '0'
      })
      .visibility(this.currentTopIndex === 2 ? Visibility.None : Visibility.Visible)

      Row() {
        // Immersive layout.
        Column() {
          Text(this.bannerImgList[2].getDescription().getIsLeftCenter().getValue(this.currentBreakpoint) ?
            this.bannerImgList[2].getDescription().getDescription()[0] +
            this.bannerImgList[2].getDescription().getDescription()[1] :
            this.bannerImgList[2].getDescription().getDescription()[0])
            .fontSize(new BreakpointType($r('app.float.immersive_text_1_font_sm'),
              $r('app.float.immersive_text_1_font_md'), $r('app.float.immersive_text_1_font_lg'))
              .getValue(this.currentBreakpoint))
            .fontWeight(this.bannerImgList[2].getDescription().getFontWeight()[0])
            .lineHeight(new BreakpointType($r('app.float.immersive_text_1_line_sm'),
              $r('app.float.immersive_text_1_line_md'), $r('app.float.immersive_text_1_line_lg'))
              .getValue(this.currentBreakpoint))
            .fontColor(Color.White)
            .letterSpacing(HomeConstants.BANNER_TEXT_LETTER_SPACES[2])
            .maxLines(1)

          Text(this.bannerImgList[2].getDescription().getDescription()[1])
            .fontSize(new BreakpointType($r('app.float.immersive_text_1_font_sm'),
              $r('app.float.immersive_text_1_font_md'), $r('app.float.immersive_text_1_font_lg'))
              .getValue(this.currentBreakpoint))
            .fontWeight(this.bannerImgList[2].getDescription().getFontWeight()[0])
            .lineHeight(new BreakpointType($r('app.float.immersive_text_1_line_sm'),
              $r('app.float.immersive_text_1_line_md'), $r('app.float.immersive_text_1_line_lg'))
              .getValue(this.currentBreakpoint))
            .fontColor(Color.White)
            .letterSpacing(HomeConstants.BANNER_TEXT_LETTER_SPACES[2])
            .maxLines(1)
            .visibility(this.bannerImgList[2].getDescription().getIsLeftCenter().getValue(this.currentBreakpoint) ?
              Visibility.None : Visibility.Visible)

          Text(this.bannerImgList[2].getDescription().getDescription()[2])
            .fontSize(new BreakpointType($r('app.float.immersive_text_2_font_sm'),
              $r('app.float.immersive_text_2_font_md'), $r('app.float.immersive_text_2_font_lg'))
              .getValue(this.currentBreakpoint))
            .fontWeight(this.bannerImgList[2].getDescription().getFontWeight()[1])
            .lineHeight(new BreakpointType($r('app.float.immersive_text_2_line_sm'),
              $r('app.float.immersive_text_2_line_md'), $r('app.float.immersive_text_2_line_lg'))
              .getValue(this.currentBreakpoint))
            .fontColor(Color.White)
            .margin({
              top: this.bannerImgList[2].getDescription().getTopPosition().getValue(this.currentBreakpoint)[1]
            })
            .letterSpacing(HomeConstants.BANNER_TEXT_LETTER_SPACES[1])
            .maxLines(1)
        }
        .padding({
          left: new BreakpointType($r('app.float.immersive_col_padding_left_sm'),
            $r('app.float.immersive_col_padding_left_md'), $r('app.float.immersive_col_padding_left_lg'))
            .getValue(this.currentBreakpoint),
          top: new BreakpointType($r('app.float.immersive_col_padding_top_sm'),
            $r('app.float.immersive_col_padding_top_md'), $r('app.float.immersive_col_padding_top_lg'))
            .getValue(this.currentBreakpoint)
        })
        .height(CommonConstants.FULL_PERCENT)
        .width(CommonConstants.FULL_PERCENT)
        .alignItems(new BreakpointType(true, false, false).getValue(this.currentBreakpoint) ?
          HorizontalAlign.Center : HorizontalAlign.Start)
        .justifyContent(!this.bannerImgList[2].getDescription().getIsTopCenter().getValue(this.currentBreakpoint) ?
          FlexAlign.Start : FlexAlign.Center)
      }
      .margin({
        top: $r('app.float.immersive_col_margin')
      })
      .padding({
        left: $r('app.float.home_content_padding'),
        right: $r('app.float.home_content_padding')
      })
      .height(new BreakpointType($r('app.float.immersive_banner_height_sm'), $r('app.float.immersive_banner_height_md'),
        $r('app.float.immersive_banner_height_lg')).getValue(this.currentBreakpoint))
      .width(CommonConstants.FULL_PERCENT)
      .visibility(this.currentTopIndex === 2 ? Visibility.Visible : Visibility.None)
    }
    .width(CommonConstants.FULL_PERCENT)
    .padding({ left: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG && this.currentTopIndex === 2 ?
      $r('app.float.side_bar_width') : 0 })
  }

  getBannerNewHeight(windowWidth: number): string {
    // Obtain the window width and subtract the blank parts on both sides.
    let result: number = px2vp(windowWidth) - new BreakpointType(HomeConstants.VIDEO_GRID_MARGIN[0],
      HomeConstants.VIDEO_GRID_MARGIN[1], HomeConstants.VIDEO_GRID_MARGIN[2]).getValue(this.currentBreakpoint) -
      HomeConstants.LG_SIDEBAR_WIDTH;
    // Calculate the width of a single image based on the percent.
    result = (result - HomeConstants.VIDEO_GRID_ITEM_SPACE * HomeConstants.TWO) * CommonConstants.FOUR /
      HomeConstants.ELEVEN;
    // Calculate the total height of the grid layout.
    return result / HomeConstants.NEW_BANNER_ASPECT_RATIO + HomeConstants.HEIGHT_UNIT;
  }
}

@Component
struct BannerText {
  private banner: Banner = new BannerViewModel().getBannerList()[0];
  private currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  private index: number = 0;

  build() {
    Stack() {
      Image(((this.index === 0) || (this.index === 1)) ? this.banner.getBannerImg().getImgSrcSm() :
        this.banner.getBannerImg().getImgSrc())
        .width(CommonConstants.FULL_PERCENT)
        .height(CommonConstants.FULL_PERCENT)
        .objectFit(ImageFit.Fill)
        .borderRadius($r('app.float.banner_img_border_radius'))

      Column() {
        Text(this.banner.getDescription().getIsLeftCenter().getValue(this.currentBreakpoint) ?
          this.banner.getDescription().getDescription()[0] + this.banner.getDescription().getDescription()[1] :
          this.banner.getDescription().getDescription()[0])
          .fontSize(this.banner.getDescription().getFontSize().getValue(this.currentBreakpoint)[0])
          .fontWeight(this.banner.getDescription().getFontWeight()[0])
          .lineHeight(this.banner.getDescription().getLineHeight().getValue(this.currentBreakpoint)[0])
          .fontColor(Color.White)
          .letterSpacing(HomeConstants.BANNER_TEXT_LETTER_SPACES[2])
          .maxLines(1)

        Text(this.banner.getDescription().getDescription()[1])
          .fontSize(this.banner.getDescription().getFontSize().getValue(this.currentBreakpoint)[0])
          .fontWeight(this.banner.getDescription().getFontWeight()[0])
          .lineHeight(this.banner.getDescription().getLineHeight().getValue(this.currentBreakpoint)[0])
          .fontColor(Color.White)
          .letterSpacing(HomeConstants.BANNER_TEXT_LETTER_SPACES[2])
          .maxLines(1)
          .visibility(this.banner.getDescription().getIsLeftCenter().getValue(this.currentBreakpoint) ?
            Visibility.None : Visibility.Visible)

        Text(this.banner.getDescription().getDescription()[2])
          .fontSize(this.banner.getDescription().getFontSize().getValue(this.currentBreakpoint)[1])
          .fontWeight(this.banner.getDescription().getFontWeight()[1])
          .lineHeight(this.banner.getDescription().getLineHeight().getValue(this.currentBreakpoint)[1])
          .fontColor(Color.White)
          .margin({
            top: this.banner.getDescription().getTopPosition().getValue(this.currentBreakpoint)[1]
          })
          .letterSpacing(HomeConstants.BANNER_TEXT_LETTER_SPACES[1])
          .maxLines(1)
      }
      .padding({
        left: !this.banner.getDescription().getIsLeftCenter().getValue(this.currentBreakpoint) ?
          this.banner.getDescription().getLeftPosition().getValue(this.currentBreakpoint)[0] : '0',
        top: !this.banner.getDescription().getIsTopCenter().getValue(this.currentBreakpoint) ?
          this.banner.getDescription().getTopPosition().getValue(this.currentBreakpoint)[0] : '0'
      })
      .alignItems(this.banner.getDescription().getIsLeftCenter().getValue(this.currentBreakpoint) ?
        HorizontalAlign.Center : HorizontalAlign.Start)
      .justifyContent(!this.banner.getDescription().getIsTopCenter().getValue(this.currentBreakpoint) ?
        FlexAlign.Start : FlexAlign.Center)
      .width(CommonConstants.FULL_PERCENT)
      .height(CommonConstants.FULL_PERCENT)
    }
  }
}