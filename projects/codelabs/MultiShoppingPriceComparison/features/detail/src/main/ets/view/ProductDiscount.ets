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

import { BreakpointType, CommonConstants, ResourceUtil } from '@ohos/commons';
import { DetailConstants } from '../constants/DetailConstants';
import { RightArrow } from './CommonView';

@Component
export struct ProductDiscount {
  @Prop pageBreakpoint: string;

  build() {
    Column() {
      Text(DetailConstants.PRODUCT_DISCOUNT_NAMES[0])
        .fontSize($r('app.float.discount_text_font_1'))
        .lineHeight($r('app.float.discount_text_line'))
        .fontWeight(CommonConstants.FONT_WEIGHT_500)
        .margin({ bottom: $r('app.float.discount_text_margin_1') })
      Text(DetailConstants.PRODUCT_DISCOUNT_NAMES[1])
        .fontSize($r('app.float.discount_text_font_2'))
        .fontColor($r('app.color.products_info_text'))
        .lineHeight($r('app.float.discount_text_line'))
        .fontWeight(FontWeight.Normal)
        .margin({ bottom: $r('app.float.discount_text_margin_2') })
      Row() {
        Text(DetailConstants.PRODUCT_DISCOUNT_NAMES[2])
          .fontSize($r('app.float.discount_text_font_2'))
          .fontColor($r('app.color.products_info_text'))
          .fontWeight(FontWeight.Normal)
          .margin({ right: $r('app.float.discount_text_margin_3') })
        Text(DetailConstants.PRODUCT_DISCOUNT_NAMES[3])
          .layoutWeight(1)
          .fontSize($r('app.float.discount_text_font_2'))
          .fontWeight(FontWeight.Normal)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Blank()
        RightArrow()
      }
      .padding({
        left: $r('app.float.discount_row_padding'),
        right: $r('app.float.discount_row_padding')
      })
      .borderRadius(ResourceUtil.getCommonBorderRadius()[5])
      .backgroundColor($r('app.color.products_info_background_1'))
      .width(CommonConstants.FULL_PERCENT)
    }
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(Color.White)
    .width(CommonConstants.FULL_PERCENT)
    .borderRadius(ResourceUtil.getCommonBorderRadius()[6])
    .padding($r('app.float.discount_col_padding'))
    .margin({ bottom: new BreakpointType($r('app.float.discount_col_margin_sm'), $r('app.float.discount_col_margin_md'),
      $r('app.float.discount_col_margin_lg')).getValue(this.pageBreakpoint) })
  }
}