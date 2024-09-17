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

import { BreakpointConstants, CommonConstants, ResourceUtil } from '@ohos/commons';
import { LiveViewModel, LiveProduct } from '../viewmodel/LiveViewModel';
import { LiveConstants } from '../constants/LiveConstants';

@Component
export struct LiveShopList {
  @StorageLink('currentBreakpoint') realBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @State currentProductIndex: number = 0;
  @Prop @Watch('getLiveProductList') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @State liveProductList: LiveProduct[] = new LiveViewModel().getProductList().reverse();
  @Link detailType: string;
  @Link isMoreDetail: boolean;
  private scroller: Scroller = new Scroller();

  aboutToAppear(): void {
    this.getLiveProductList();
  }

  getLiveProductList(): void {
    if (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG) {
      this.liveProductList = new LiveViewModel().getProductList().reverse();
      this.currentProductIndex = this.liveProductList.length - 1;
    } else {
      this.liveProductList = new LiveViewModel().getProductList();
      this.currentProductIndex = 0;
    }
    this.scroller.scrollToIndex(this.currentProductIndex);
  }

  build() {
    List({
      space: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? LiveConstants.SHOPPING_LIST_SPACE[0] :
      LiveConstants.SHOPPING_LIST_SPACE[1],
      initialIndex: this.currentProductIndex,
      scroller: this.scroller
    }) {
      ForEach(this.liveProductList, (item: LiveProduct, index: number) => {
        ListItem() {
          Row() {
            Image(item.getImage())
              .width(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
                $r('app.float.shop_list_image_size_lg') : $r('app.float.shop_list_image_size'))
              .aspectRatio(1)
              .borderRadius(ResourceUtil.getCommonBorderRadius()[3])
            Column() {
              Text(item.getName())
                .fontSize($r('app.float.shop_list_text_font_size'))
                .lineHeight($r('app.float.shop_list_text_line_height'))
                .fontWeight(CommonConstants.FONT_WEIGHT_500)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .margin({
                  bottom: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
                    $r('app.float.shop_list_text_margin_lg') : $r('app.float.shop_list_text_margin')
                })
              Text(item.getPrice())
                .fontSize($r('app.float.shop_list_text_font_size'))
                .lineHeight($r('app.float.shop_list_text_line_height'))
                .fontWeight(CommonConstants.FONT_WEIGHT_500)
                .fontColor($r('app.color.shop_price_color'))
            }
            .alignItems(HorizontalAlign.Start)
            .visibility(index === this.currentProductIndex ? Visibility.Visible : Visibility.None)
            .padding({
              top: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
                $r('app.float.shop_text_padding_top_lg') : $r('app.float.shop_text_padding_top'),
              bottom: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
                $r('app.float.shop_text_padding_bottom_lg') : $r('app.float.shop_text_padding_bottom'),
              left: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
                $r('app.float.shop_text_padding_left_lg') : 0
            })
            .layoutWeight(1)
            .height(CommonConstants.FULL_PERCENT)
          }
          .borderRadius(ResourceUtil.getCommonBorderRadius()[3])
          .backgroundColor(Color.White)
          .width(index === this.currentProductIndex ? (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
            $r('app.float.shop_width_index0_lg') : $r('app.float.shop_width_index0')) :
            (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? $r('app.float.shop_width_lg') :
            $r('app.float.shop_width')))
          .height(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? $r('app.float.shop_width_lg') :
            $r('app.float.shop_width'))
          .onClick(() => {
            if (this.realBreakpoint !== BreakpointConstants.BREAKPOINT_SM) {
              this.isMoreDetail = true;
              this.detailType = CommonConstants.BIND_SHEET_PAGE_TYPES[2];
            }
          })
        }
      }, (item: LiveProduct, index: number) => index + JSON.stringify(item))
    }
    .edgeEffect(EdgeEffect.Fade)
    .alignListItem(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? ListItemAlign.End :
      ListItemAlign.Start)
    .scrollBar(BarState.Off)
    .height(this.currentBreakpoint !== BreakpointConstants.BREAKPOINT_LG ? $r('app.float.shop_width') :
      CommonConstants.FULL_PERCENT)
    .width(this.currentBreakpoint !== BreakpointConstants.BREAKPOINT_LG ? CommonConstants.FULL_PERCENT :
      $r('app.float.shop_width_index0_lg'))
    .listDirection(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? Axis.Vertical :
      Axis.Horizontal)
  }
}