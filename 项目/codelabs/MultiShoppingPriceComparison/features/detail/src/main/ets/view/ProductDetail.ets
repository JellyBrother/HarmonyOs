/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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

import { BusinessError, deviceInfo } from '@kit.BasicServicesKit';
import { AbilityConstant, common, StartOptions, Want } from '@kit.AbilityKit';
import { ClassifyConstants } from '@ohos/home';
import { BreakpointConstants, BreakpointType, CommonConstants, Logger, PipWindowUtil, ResourceUtil } from '@ohos/commons';
import { DetailConstants } from '../constants/DetailConstants';
import { ProductPrice } from './ProductPrice';
import { ProductDiscount } from './ProductDiscount';
import { ProductConfig, UserComments } from './ProductConfig';

@Component
export struct ProductPicture {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @StorageLink('topRectHeight') topRectHeight: number = 0;
  @StorageLink('isSplitMode') isSplitMode: boolean = false;
  @State currentSwiperIndex: number = 0;
  @Prop pageBreakpoint: string;
  @Link isMoreLiveDetail: boolean;
  @Consume('pageInfos') pageInfos: NavPathStack;
  private pipWindowUtil: PipWindowUtil | undefined = PipWindowUtil.getPipWindowUtil();
  private abilityName: string = (getContext(this) as common.UIAbilityContext).abilityInfo.name;

  @Builder
  PictureIndicator(text: string) {
    Text(text)
      .fontSize($r('app.float.picture_indicator_font'))
      .fontWeight(FontWeight.Normal)
      .margin({ right: $r('app.float.picture_indicator_margin') })
  }

  build() {
    Column() {
      Stack({ alignContent: this.pageBreakpoint === BreakpointConstants.BREAKPOINT_LG ? Alignment.TopEnd :
        Alignment.End }) {
        Swiper() {
          ForEach(DetailConstants.PRODUCT_DETAIL_RESOURCES, (item: Resource) => {
            Image(item)
              .width(CommonConstants.FULL_PERCENT)
          }, (item: Resource, index: number) => index + JSON.stringify(item))
        }
        .align(Alignment.Center)
        .indicator(false)
        .displayCount(1)
        .nextMargin(this.pageBreakpoint === BreakpointConstants.BREAKPOINT_MD ? $r('app.float.product_swiper_margin') :
          0)
        .prevMargin(this.pageBreakpoint === BreakpointConstants.BREAKPOINT_MD ? $r('app.float.product_swiper_margin') :
          0)
        .height(CommonConstants.FULL_PERCENT)
        .width(CommonConstants.FULL_PERCENT)
        .onChange((index: number) => {
          this.currentSwiperIndex = index;
        })

        Row() {
          Image($r('app.media.ic_back'))
            .height(ResourceUtil.getCommonImgSize()[1])
            .width(ResourceUtil.getCommonImgSize()[1])
            .margin({ right: $r('app.float.picture_icon_margin') })
            .onClick(() => {
              if (this.isMoreLiveDetail) {
                this.isMoreLiveDetail = false;
              } else {
                this.pageInfos.pop();
              }
            })
          Image($r('app.media.ic_zoom_out'))
            .height(ResourceUtil.getCommonImgSize()[1])
            .width(ResourceUtil.getCommonImgSize()[1])
            .visibility(this.pageBreakpoint === BreakpointConstants.BREAKPOINT_LG ? Visibility.Visible :
              Visibility.None)
          Blank()
          Image(this.isSplitMode ? $r('app.media.icon_split') : $r('app.media.ic_mate_pad_2'))
            .height(ResourceUtil.getCommonImgSize()[1])
            .width(ResourceUtil.getCommonImgSize()[1])
            .margin({ right: this.pageBreakpoint === BreakpointConstants.BREAKPOINT_SM ?
              $r('app.float.picture_icon_margin_sm') : $r('app.float.picture_icon_margin') })
            .onClick(() => {
              if (deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[0]) {
                return;
              }
              if (!this.isSplitMode) {
                let want: Want = {
                  bundleName: 'com.huawei.multishoppingpricecomparison',
                  abilityName: 'SecondAbility'
                };
                let option: StartOptions = { windowMode: AbilityConstant.WindowMode.WINDOW_MODE_SPLIT_PRIMARY };
                (getContext(this) as common.UIAbilityContext).startAbility(want, option);
              } else {
                (getContext(this) as common.UIAbilityContext).terminateSelf();
              }
            })
            .visibility(this.pageBreakpoint === BreakpointConstants.BREAKPOINT_MD || this.isSplitMode ?
              Visibility.Visible : Visibility.None)
          Image($r('app.media.ic_more'))
            .height(ResourceUtil.getCommonImgSize()[1])
            .width(ResourceUtil.getCommonImgSize()[1])
            .visibility(this.pageBreakpoint === BreakpointConstants.BREAKPOINT_LG ? Visibility.None :
              Visibility.Visible)
        }
        .width(CommonConstants.FULL_PERCENT)
        .position({ x: 0, y: DetailConstants.LIVE_ROW_Y_POSITION })
        .padding({
          left: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint),
          right: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint)
        })

        Column() {
          Image($r('app.media.ic_public_living'))
            .width(ResourceUtil.getCommonImgSize()[0])
            .height(ResourceUtil.getCommonImgSize()[0])
            .borderRadius(ResourceUtil.getCommonBorderRadius()[4])
          Text(DetailConstants.LIVING)
            .fontSize($r('app.float.picture_live_font'))
            .lineHeight($r('app.float.picture_live_line'))
            .fontWeight(FontWeight.Normal)
        }
        .onClick(() => {
          if (this.isMoreLiveDetail) {
            return;
          }
          if (deviceInfo.deviceType !== CommonConstants.DEVICE_TYPES[0]) {
            if (this.pipWindowUtil === undefined) {
              return;
            }
            if (this.pipWindowUtil.getIsShowingPip()) {
              this.pipWindowUtil.stopPip().then(() => {
                this.pageInfos.pushPath({ name: ClassifyConstants.PAGE_INFO_LIST[0] });
              }).catch((err: BusinessError) => {
                Logger.error(`Failed to stop pip. Cause: ${err.code}, message: ${err.message}`);
              });
            } else {
              this.pageInfos.pushPath({ name: ClassifyConstants.PAGE_INFO_LIST[0] });
            }
          } else {
            this.pageInfos.pushPath({ name: ClassifyConstants.PAGE_INFO_LIST[0] });
          }
        })
        .margin({
          top: this.pageBreakpoint === BreakpointConstants.BREAKPOINT_LG ? $r('app.float.picture_live_col_margin_lg') :
            0,
          right: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint)
        })
        .borderWidth(1)
        .borderRadius(ResourceUtil.getCommonBorderRadius()[3])
        .borderColor($r('app.color.living_border_color'))
        .backgroundColor($r('app.color.living_background'))
        .justifyContent(FlexAlign.SpaceEvenly)
        .height($r('app.float.picture_live_col_height'))
        .width($r('app.float.picture_live_col_width'))
        .visibility(this.abilityName === 'SecondAbility' ? Visibility.None : Visibility.Visible)
      }
      .width(CommonConstants.FULL_PERCENT)
      .layoutWeight(this.pageBreakpoint === BreakpointConstants.BREAKPOINT_LG ? 1 : -1)
      .aspectRatio(new BreakpointType(DetailConstants.LIVE_STACK_ASPECT_RATIO[0],
        DetailConstants.LIVE_STACK_ASPECT_RATIO[1], -1).getValue(this.pageBreakpoint))

      Row() {
        Column() {
          Text(JSON.stringify(this.currentSwiperIndex + 1) + DetailConstants.PICTURE_INDICATOR[0])
            .fontSize($r('app.float.picture_number_font'))
            .fontWeight(FontWeight.Normal)
            .fontColor(Color.White)
        }
        .width($r('app.float.picture_number_row_width'))
        .height($r('app.float.picture_number_row_height'))
        .backgroundColor($r('app.color.swiper_indicator_background'))
        .borderRadius(ResourceUtil.getCommonBorderRadius()[3])
        .justifyContent(FlexAlign.Center)
      }
      .width(CommonConstants.FULL_PERCENT)
      .justifyContent(FlexAlign.End)
      .padding({ right: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint) })

      Row() {
        this.PictureIndicator(DetailConstants.PICTURE_INDICATOR[1])
        Image(ResourceUtil.getArrowRight())
          .width($r('app.float.picture_arrow_width'))
          .height($r('app.float.picture_arrow_height'))
          .margin({ right: $r('app.float.picture_arrow_margin') })
        this.PictureIndicator(DetailConstants.PICTURE_INDICATOR[2])
        Image(ResourceUtil.getArrowRight())
          .width($r('app.float.picture_arrow_width'))
          .height($r('app.float.picture_arrow_height'))
      }
      .padding({
        left: $r('app.float.picture_indicator_row_padding_left'),
        right: $r('app.float.picture_indicator_row_padding_right')
      })
      .backgroundColor($r('app.color.products_compare'))
      .width($r('app.float.picture_indicator_row_width'))
      .height($r('app.float.picture_indicator_row_height'))
      .borderRadius(ResourceUtil.getCommonBorderRadius()[4])
      .margin({ top: $r('app.float.picture_indicator_row_margin') })

      Row() {
        List({ space: new BreakpointType(DetailConstants.PICTURE_LIST_SPACES[0], DetailConstants.PICTURE_LIST_SPACES[1],
          DetailConstants.PICTURE_LIST_SPACES[2]).getValue(this.pageBreakpoint) }) {
          ForEach(DetailConstants.PRODUCT_SMALL_RESOURCES, (item: Resource, index: number) => {
            ListItem() {
              Image(item)
                .width(this.pageBreakpoint === BreakpointConstants.BREAKPOINT_LG ? ResourceUtil.getCommonImgSize()[3] :
                  ResourceUtil.getCommonImgSize()[2])
                .height(this.pageBreakpoint === BreakpointConstants.BREAKPOINT_LG ? ResourceUtil.getCommonImgSize()[3] :
                  ResourceUtil.getCommonImgSize()[2])
                .borderRadius(ResourceUtil.getCommonBorderRadius()[3])
                .borderWidth(index === this.currentSwiperIndex ? 1 : 0)
            }
          }, (item: Resource, index: number) => JSON.stringify(item) + index)
        }
        .scrollBar(BarState.Off)
        .listDirection(Axis.Horizontal)
        .margin({
          top: $r('app.float.small_picture_margin'),
          bottom: $r('app.float.small_picture_margin')
        })
      }
      .height(this.pageBreakpoint === BreakpointConstants.BREAKPOINT_LG ? $r('app.float.small_picture_height_lg') :
        $r('app.float.small_picture_height'))
      .width(CommonConstants.FULL_PERCENT)
      .padding({
        left: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint),
        right: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint)
      })
    }
    .backgroundColor(Color.White)
    .alignItems(HorizontalAlign.Center)
    .padding({
      bottom: deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[1] ? CommonConstants.BOTTOM_RECT_HEIGHT : 0
    })
  }
}

@Component
export struct ProductInfo {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @Prop pageBreakpoint: string;

  build() {
    Column() {
      ProductPrice({ pageBreakpoint: this.pageBreakpoint })
      ProductDiscount({ pageBreakpoint: this.pageBreakpoint })
      ProductConfig({ pageBreakpoint: this.pageBreakpoint })
      UserComments()
    }
    .backgroundColor($r('app.color.products_info'))
    .width(CommonConstants.FULL_PERCENT)
    .padding({
      left: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint),
      right: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint),
      bottom: $r('app.float.product_info_padding_bottom')
    })
  }
}