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

import { deviceInfo } from '@kit.BasicServicesKit';
import { BreakpointConstants, BreakpointType, CommonConstants } from '@ohos/commons';
import { ClassifyShopList } from '../view/ClassifyShopList';
import { BannerList } from '../viewmodel/ShopListViewModel';
import { ClassifyConstants } from '../constants/ClassifyConstants';

@Component
export struct ClassifyNavDestination {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @State name: string = "";
  private scroller: Scroller = new Scroller();

  build() {
    NavDestination() {
      Column() {
        Scroll(this.scroller) {
          Column() {
            Row() {
              ClassifyBanner()
            }
            .width(CommonConstants.FULL_PERCENT)
            .padding({ right: new BreakpointType($r('app.float.classify_banner_padding_right_sm'),
                $r('app.float.classify_banner_padding_right_md'), $r('app.float.classify_banner_padding_right_lg'))
                .getValue(this.currentBreakpoint) })

            ClassifyShopList()
          }
          .padding({ bottom: deviceInfo.deviceType !== CommonConstants.DEVICE_TYPES[1] ? 0 :
            CommonConstants.BOTTOM_RECT_HEIGHT })
        }
        .scrollBarWidth(0)
        .padding({
          top: $r('app.float.classify_destination_padding_top'),
          left: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM ?
            $r('app.float.classify_destination_padding_left_sm') : $r('app.float.classify_destination_padding_left')
        })
      }
    }
    .hideTitleBar(true)
    .backgroundColor(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM ?
      $r('app.color.classify_navigation_content_color_sm'): $r('app.color.classify_navigation_content_color'))
  }
}

@Component
export struct ClassifyBanner {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  private swiperController: SwiperController = new SwiperController();
  private bannerList: Array<Resource> = new BannerList().getBannerList();

  build() {
    Swiper(this.swiperController) {
      ForEach(this.bannerList, (item: Resource) => {
        Image(item)
          .width(CommonConstants.FULL_PERCENT)
          .height($r('app.float.classify_banner_height'))
          .aspectRatio(ClassifyConstants.BANNER_IMAGE_RATIO)
      }, (item: Resource, index: number) => JSON.stringify(item) + index)
    }
    .loop(true)
    .indicator(
      this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM ?
      Indicator.dot()
        .itemWidth($r('app.float.classify_swiper_indicator_width'))
        .itemHeight($r('app.float.classify_swiper_indicator_height'))
        .selectedItemWidth($r('app.float.classify_swiper_indicator_selected_width'))
        .selectedItemHeight($r('app.float.classify_swiper_indicator_selected_height'))
        .color($r('app.color.classify_indicator_color'))
        .selectedColor($r('app.color.classify_indicator_selected_color')) : false
    )
    .displayCount(new BreakpointType(ClassifyConstants.SWIPER_DISPLAY_COUNT[0],
      ClassifyConstants.SWIPER_DISPLAY_COUNT[1], ClassifyConstants.SWIPER_DISPLAY_COUNT[2])
      .getValue(this.currentBreakpoint))
    .nextMargin(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_MD ?
      $r('app.float.classify_swiper_next_margin_md') : 0)
    .itemSpace(new BreakpointType(ClassifyConstants.SWIPER_ITEM_SPACE[0], ClassifyConstants.SWIPER_ITEM_SPACE[1],
      ClassifyConstants.SWIPER_ITEM_SPACE[2]).getValue(this.currentBreakpoint))
  }
}