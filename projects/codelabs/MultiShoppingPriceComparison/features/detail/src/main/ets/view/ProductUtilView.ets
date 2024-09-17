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
import { ClassifyConstants } from '@ohos/home';
import { BreakpointConstants, CommonConstants, ResourceUtil } from '@ohos/commons';
import { DetailConstants } from '../constants/DetailConstants';
import { PayCard } from './PayCard';
import { UtilIcon } from './CommonView';

@Component
export struct ProductUtilView {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @StorageLink('isShowingSidebar') isShowingSidebar: boolean = false;
  @StorageLink('isSplitMode') isSplitMode: boolean = false;
  @Link isMoreDetail: boolean;
  @Link isShoppingBag: boolean;
  @Link isCustomerService: boolean;
  @State isDialogOpen: boolean = false;
  @State detailType: string = CommonConstants.BIND_SHEET_PAGE_TYPES[3];
  @Consume('pageInfos') pageInfos: NavPathStack;
  private isLivePage: boolean = false;
  private dialogController: CustomDialogController | null = new CustomDialogController({
    builder: PayCardDialog(),
    customStyle: true
  });

  aboutToDisappear(): void {
    this.dialogController = null;
  }

  @Builder
  PayCardBuilder() {
    Column() {
      PayCard({
        isOpen: $isDialogOpen,
        detailType: $detailType,
        currentBreakpoint: this.currentBreakpoint
      })
    }
    .padding({ top: $r('app.float.util_pay_padding') })
    .width(CommonConstants.FULL_PERCENT)
    .height(CommonConstants.FULL_PERCENT)
  }

  build() {
    GridRow({
      columns: {
        sm: BreakpointConstants.GRID_ROW_COLUMNS[0],
        md: BreakpointConstants.GRID_ROW_COLUMNS[1],
        lg: BreakpointConstants.GRID_ROW_COLUMNS[2]
      }
    }) {
      GridCol({
        span: {
          sm: BreakpointConstants.GRID_COLUMN_SPANS[2],
          md: BreakpointConstants.GRID_COLUMN_SPANS[3],
          lg: BreakpointConstants.GRID_COLUMN_SPANS[4]
        }
      }) {
        Row() {
          UtilIcon({ isMoreDetail: $isMoreDetail, iconImg: $r('app.media.tab_home') })
            .displayPriority(3)
          UtilIcon({ isMoreDetail: $isMoreDetail, iconImg: $r('app.media.ic_public_comments') })
            .displayPriority(3)
            .onClick(() => {
              this.isShowingSidebar = false;
              if (this.isMoreDetail) {
                this.isCustomerService = true;
                this.isShoppingBag = false;
              } else {
                this.pageInfos.pushPathByName(ClassifyConstants.PAGE_INFO_LIST[1],
                  new NavParams(DetailConstants.PARAM_STRING_LIST[1]));
              }
            })
          UtilIcon({ isMoreDetail: $isMoreDetail, iconImg: $r('app.media.tab_shopping_bag') })
            .displayPriority(3 )
            .onClick(() => {
              this.isShowingSidebar = false;
              if (this.isMoreDetail) {
                this.isShoppingBag = true;
                this.isCustomerService = false;
              } else {
                this.pageInfos.pushPathByName(ClassifyConstants.PAGE_INFO_LIST[1],
                  new NavParams(DetailConstants.PARAM_STRING_LIST[0]));
              }
            })
          Blank()
            .displayPriority(1)
          Button(DetailConstants.BUTTON_NAMES[0])
            .fontSize($r('app.float.util_button_font'))
            .fontColor($r('app.color.util_button_2'))
            .fontWeight(CommonConstants.FONT_WEIGHT_500)
            .layoutWeight(this.isMoreDetail ? (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? 1 : 2) :
              (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM ? 2 : 1))
            .height($r('app.float.util_button_height'))
            .borderRadius(ResourceUtil.getCommonBorderRadius()[7])
            .backgroundColor($r('app.color.util_button_1'))
            .margin({ right: $r('app.float.util_button_margin') })
            .displayPriority(2)
          Button(DetailConstants.BUTTON_NAMES[1])
            .fontSize($r('app.float.util_button_font'))
            .fontColor(Color.White)
            .fontWeight(CommonConstants.FONT_WEIGHT_500)
            .layoutWeight(1)
            .height($r('app.float.util_button_height'))
            .borderRadius(ResourceUtil.getCommonBorderRadius()[7])
            .backgroundColor($r('app.color.util_button_2'))
            .displayPriority(4)
            .bindSheet($$this.isDialogOpen,
              this.PayCardBuilder(), {
                height: $r('app.float.pay_bind_sheet_height'),
                preferType: SheetType.CENTER,
                dragBar: false,
                enableOutsideInteractive: true,
                onDisappear: () => { this.isDialogOpen = false },
                showClose: false,
                backgroundColor: $r('app.color.pay_bind_sheet_background')
              })
            .onClick(() => {
              if (this.isLivePage || this.isSplitMode) {
                return;
              }
              if (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM) {
                this.isDialogOpen = true;
              } else {
                if (this.dialogController === null) {
                  return;
                }
                this.dialogController.open();
                this.isDialogOpen = false;
              }
            })
        }
        .backgroundColor($r('app.color.products_info'))
        .height(deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[0] ? CommonConstants.TAB_BAR_HEIGHT :
          CommonConstants.TAB_BAR_HEIGHT + CommonConstants.BOTTOM_RECT_HEIGHT)
        .width(CommonConstants.FULL_PERCENT)
        .padding({
          left: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint),
          right: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint),
          bottom: deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[0] ? 0 : CommonConstants.BOTTOM_RECT_HEIGHT
        })
      }
    }
    .onBreakpointChange((breakPoints) => {
      if (breakPoints === BreakpointConstants.BREAKPOINT_LG) {
        if (this.dialogController === null) {
          return;
        }
        this.dialogController.close();
      } else {
        this.isShowingSidebar = false;
        if (this.dialogController === null) {
          return;
        }
        this.dialogController.close();
        this.isDialogOpen = false;
      }
    })
  }
}

@CustomDialog
struct PayCardDialog {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @State isDialogOpen: boolean = false;
  @State detailType: string = CommonConstants.BIND_SHEET_PAGE_TYPES[3];
  private dialogController?: CustomDialogController;

  build() {
    Column() {
      PayCard({
        isOpen: $isDialogOpen,
        detailType: $detailType,
        currentBreakpoint: this.currentBreakpoint,
        dialogController: this.dialogController
      })
    }
    .backgroundColor(ResourceUtil.getCommonBackgroundColor()[0])
    .padding({ top: $r('app.float.pay_dialog_padding') })
    .width(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? $r('app.float.pay_dialog_width_lg') :
      $r('app.float.pay_dialog_width'))
    .height(DetailConstants.EIGHTY_PERCENT)
    .borderRadius(ResourceUtil.getCommonBorderRadius()[8])
  }
}

export class NavParams {
  viewName: string = '';

  constructor(viewName: string) {
    this.viewName = viewName;
  }
}