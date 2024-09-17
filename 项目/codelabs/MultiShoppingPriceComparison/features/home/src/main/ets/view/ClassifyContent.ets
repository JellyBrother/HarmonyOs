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
import { BreakpointConstants, BreakpointType, CommonConstants, ResourceUtil } from '@ohos/commons';
import { ClassifyHeader } from './ClassifyHeader';
import { ClassifyConstants } from '../constants/ClassifyConstants';
import { ClassifyNavDestination } from './ClassifyNavdestinationPhone';

@Component
export struct ClassifyContent {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @Provide('pageInfo') pageInfo: NavPathStack = new NavPathStack();
  @State currentClassifyIndex: number = 0;

  @Builder
  PageMap(name: string) {
    if (name === ClassifyConstants.NAV_ROUTER_LIST[0]) {
      ClassifyNavDestination({ name: name })
    } else {
      NavDestination()
        .hideTitleBar(true)
    }
  }

  aboutToAppear(): void {
    this.pageInfo.pushPath({ name: ClassifyConstants.NAV_ROUTER_LIST[0] }, false);
  }

  build() {
    Column() {
      ClassifyHeader()

      Navigation(this.pageInfo) {
        List() {
          ForEach(ClassifyConstants.NAV_ROUTER_LIST, (item: string, index: number) => {
            ListItem() {
              Stack({ alignContent: Alignment.Start }) {
                Row() {
                  Text(item)
                    .fontSize($r('app.float.classify_navigation_font_size'))
                    .lineHeight($r('app.float.classify_navigation_line_height'))
                    .fontWeight(FontWeight.Normal)
                    .fontColor(this.currentClassifyIndex === index ? $r('app.color.classify_indicator_selected_color') :
                      $r('app.color.classify_navigation_font_color'))
                }
                .width(CommonConstants.FULL_PERCENT)
                .height(CommonConstants.FULL_PERCENT)
                .justifyContent(FlexAlign.Start)
                .padding({ left: ResourceUtil.getPageColPadding().getValue(this.currentBreakpoint) })
                .onClick(() =>{
                  this.currentClassifyIndex = index;
                  this.pageInfo.pushPath({ name: item }, false);
                })

                Divider()
                  .vertical(true)
                  .strokeWidth(ClassifyConstants.SWIPER_DIVIDER_WIDTH)
                  .height($r('app.float.classify_navigation_line_height'))
                  .color($r('app.color.classify_navigation_divider_color'))
                  .visibility(index === this.currentClassifyIndex ? Visibility.Visible : Visibility.None)
              }
              .width(CommonConstants.FULL_PERCENT)
              .height($r('app.float.classify_navigation_bar_height'))
              .margin({ bottom: deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[1] && index ===
                ClassifyConstants.NAV_ROUTER_LIST.length - 1 ? CommonConstants.BOTTOM_RECT_HEIGHT : 0 })
            }
          }, (item: string, index: number) => item + index)
        }
        .scrollBar(BarState.Off)
      }
      .layoutWeight(1)
      // Setting the double column view of the navigation.
      .mode(NavigationMode.Split)
      // Initialize the width of the navigation bar.
      .navBarWidth(new BreakpointType($r('app.float.classify_navigation_bar_width_sm'),
        $r('app.float.classify_navigation_bar_width_md'), $r('app.float.classify_navigation_bar_width_lg'))
        .getValue(this.currentBreakpoint))
      // Set the minimum width and maximum width of the navigation bar under different breakpoints to be the same.
      .navBarWidthRange([new BreakpointType($r('app.float.classify_navigation_bar_width_sm'),
        $r('app.float.classify_navigation_bar_width_md'), $r('app.float.classify_navigation_bar_width_lg'))
        .getValue(this.currentBreakpoint), new BreakpointType($r('app.float.classify_navigation_bar_width_sm'),
        $r('app.float.classify_navigation_bar_width_md'), $r('app.float.classify_navigation_bar_width_lg'))
        .getValue(this.currentBreakpoint)])
      .hideToolBar(true)
      .hideTitleBar(true)
      .navDestination(this.PageMap)
    }
    .backgroundColor(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM ?
      $r('app.color.classify_navigation_content_color_sm') : $r('app.color.classify_navigation_content_color'))
    .height(CommonConstants.FULL_PERCENT)
  }
}