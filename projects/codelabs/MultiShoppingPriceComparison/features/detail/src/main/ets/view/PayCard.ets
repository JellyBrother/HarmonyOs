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
import { BreakpointConstants, CommonConstants, ResourceUtil } from '@ohos/commons';
import { DetailConstants } from '../constants/DetailConstants';
import { PayCardViewModel, SelectProjectItem, SelectItem } from '../viewmodel/PayCardViewModel';

@Component
export struct PayCard {
  @StorageLink('currentBreakpoint') realBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @Prop currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @Link isOpen: boolean;
  @Link detailType: string;
  private payCardSelectList: SelectProjectItem[] = new PayCardViewModel().getPayCardSelectList();
  private dialogController?: CustomDialogController;

  build() {
    Column(){
      Scroll(){
        Column() {
          Row() {
            Image($r('app.media.pay_main_shop'))
              .height(ResourceUtil.getCommonImgSize()[4])
              .width(ResourceUtil.getCommonImgSize()[4])
              .margin({ right: $r('app.float.pay_card_product_margin') })
            Text(DetailConstants.CUSTOMER_SERVICE_CONTENTS[1])
              .fontColor($r('app.color.service_font_color'))
              .fontSize($r('app.float.pay_card_price_font'))
            Blank()
            Image($r('app.media.icon_close_1'))
              .width(ResourceUtil.getCommonImgSize()[0])
              .height(ResourceUtil.getCommonImgSize()[0])
              .onClick(() => {
                if (this.detailType === CommonConstants.BIND_SHEET_PAGE_TYPES[3]) {
                  if (this.dialogController !== undefined) {
                    this.dialogController.close();
                  }
                } else {
                  this.detailType = CommonConstants.BIND_SHEET_PAGE_TYPES[0];
                }
              })
              .alignSelf(ItemAlign.Start)
              .margin({ top: $r('app.float.pay_card_icon_margin') })
              .visibility(this.realBreakpoint === BreakpointConstants.BREAKPOINT_SM ? Visibility.None :
                Visibility.Visible)
            Image($r('app.media.icon_close_2'))
              .width(ResourceUtil.getCommonImgSize()[5])
              .height(ResourceUtil.getCommonImgSize()[5])
              .onClick(() => {
                if (this.detailType === CommonConstants.BIND_SHEET_PAGE_TYPES[3]) {
                  this.isOpen = false;
                } else {
                  this.detailType = CommonConstants.BIND_SHEET_PAGE_TYPES[0];
                }
              })
              .alignSelf(ItemAlign.Start)
              .margin({ top: $r('app.float.pay_card_icon_margin') })
              .visibility(this.realBreakpoint !== BreakpointConstants.BREAKPOINT_SM ? Visibility.None :
                Visibility.Visible)
          }
          .width(CommonConstants.FULL_PERCENT)
          .margin({ bottom: $r('app.float.pay_card_top_margin') })

          Row() {
            Image($r('app.media.icon_position'))
              .height(ResourceUtil.getCommonImgSize()[5])
              .width(ResourceUtil.getCommonImgSize()[5])
              .margin({ right: $r('app.float.pay_position_margin') })
            Column() {
              Text(DetailConstants.PAY_INFO[0])
                .fontSize($r('app.float.pay_address_font'))
                .fontWeight(CommonConstants.FONT_WEIGHT_500)
                .width(CommonConstants.FULL_PERCENT)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .margin({ bottom: $r('app.float.pay_address_margin') })
              Text(DetailConstants.PAY_INFO[1])
                .fontSize($r('app.float.pay_contact_font'))
                .fontColor($r('app.color.pay_contact_color'))
                .width(CommonConstants.FULL_PERCENT)
                .maxLines(1)
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)
          }
          .margin({ bottom: $r('app.float.pay_info_margin') })
          .width(CommonConstants.FULL_PERCENT)
          .backgroundColor(Color.White)
          .borderRadius(ResourceUtil.getCommonBorderRadius()[6])
          .padding({
            top: $r('app.float.pay_info_padding_top_bottom'),
            bottom: $r('app.float.pay_info_padding_top_bottom'),
            left: $r('app.float.pay_info_padding_left_right'),
            right: $r('app.float.pay_info_padding_left_right')
          })

          Column() {
            ForEach(this.payCardSelectList, (item: SelectProjectItem, index: number) => {
              Column() {
                Text(item.getName())
                  .fontSize($r('app.float.pay_config_title_font'))
                  .alignSelf(ItemAlign.Start)
                  .margin({ bottom: $r('app.float.pay_config_title_margin') })
                  .lineHeight($r('app.float.pay_config_title_line'))
                  .fontWeight(CommonConstants.FONT_WEIGHT_500)
                Flex({
                  wrap: FlexWrap.Wrap,
                  justifyContent: FlexAlign.Start
                }) {
                  ForEach(item.getSelectItemList(), (selectItem: SelectItem, selectIndex: number) => {
                    Row() {
                      Image(selectItem.getImage())
                        .height(ResourceUtil.getCommonImgSize()[1])
                        .width(ResourceUtil.getCommonImgSize()[1])
                        .visibility(selectItem.getImage() === null ? Visibility.None : Visibility.Visible)
                      Text(selectItem.getName())
                        .fontColor(selectIndex === 0 ? $r('app.color.service_font_color') : Color.Black)
                        .fontSize($r('app.float.pay_config_name_font'))
                        .textAlign(TextAlign.Center)
                        .margin({
                          left: $r('app.float.pay_config_name_margin'),
                          right: $r('app.float.pay_config_name_margin')
                        })
                    }
                    .backgroundColor(selectIndex === 0 ? $r('app.color.pay_config_background_selected') :
                      ResourceUtil.getCommonBackgroundColor()[2])
                    .border({
                      color: selectIndex === 0 ? $r('app.color.service_font_color') :
                        ResourceUtil.getCommonBackgroundColor()[2],
                      width: index === 0 ? $r('app.float.pay_config_border_width') : 0,
                      radius: ResourceUtil.getCommonBorderRadius()[3]
                    })
                    .height($r('app.float.pay_config_height'))
                    .margin({
                      right: $r('app.float.pay_config_margin'),
                      bottom: $r('app.float.pay_config_margin')
                    })
                  }, (selectItem: SelectItem, selectIndex: number) => JSON.stringify(selectItem) + selectIndex)
                }
                .width(CommonConstants.FULL_PERCENT)
              }
              .margin({ top: $r('app.float.pay_config_col_margin_top') })
              .width(CommonConstants.FULL_PERCENT)
            }, (item: SelectProjectItem, index: number) => JSON.stringify(item) + index)
          }
          .width(CommonConstants.FULL_PERCENT)
          .margin({ bottom: $r('app.float.pay_config_col_margin_bottom') })
          .backgroundColor(Color.White)
          .borderRadius(ResourceUtil.getCommonBorderRadius()[6])
          .padding({
            left: $r('app.float.pay_config_col_padding'),
            right: $r('app.float.pay_config_col_padding')
          })

          Row() {
            Image($r('app.media.icon_pay'))
              .height(ResourceUtil.getCommonImgSize()[5])
              .width(ResourceUtil.getCommonImgSize()[5])
              .margin({ right: $r('app.float.pay_wallet_icon_margin') })
            Text(DetailConstants.PAY_INFO[2])
              .fontSize($r('app.float.pay_wallet_font'))
              .fontWeight(CommonConstants.FONT_WEIGHT_500)
            Blank()
            Checkbox()
              .selectedColor($r('app.color.util_button_2'))
              .shape(CheckBoxShape.CIRCLE)
              .width($r('app.float.checkbox_width'))
          }
          .padding({
            top: $r('app.float.wallet_row_padding_1'),
            left: $r('app.float.wallet_row_padding_2'),
            bottom: $r('app.float.wallet_row_padding_1'),
            right: $r('app.float.wallet_row_padding_2')
          })
          .margin({ bottom: $r('app.float.wallet_row_margin') })
          .borderRadius(ResourceUtil.getCommonBorderRadius()[6])
          .backgroundColor(Color.White)
          .width(CommonConstants.FULL_PERCENT)
        }
        .width(CommonConstants.FULL_PERCENT)
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .align(Alignment.Top)
      .width(CommonConstants.FULL_PERCENT)

      Button(DetailConstants.PAY_INFO[3])
        .width(CommonConstants.FULL_PERCENT)
        .backgroundColor($r('app.color.util_button_2'))
        .height($r('app.float.pay_button_height'))
        .margin({
          top: $r('app.float.pay_button_margin_top'),
          bottom: deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[0] ? $r('app.float.pay_button_margin_bottom') :
            CommonConstants.BOTTOM_RECT_HEIGHT
        })
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(CommonConstants.FULL_PERCENT)
    .padding({
      left: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint),
      right: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint)
    })
  }
}