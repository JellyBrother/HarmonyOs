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
import { router } from '@kit.ArkUI';
import { CommonConstants } from '../common/CommonConstants';
import { WaterFlowData, WaterFlowDataSource } from '../model/WaterFlowDataSource';
import { BreakpointSystem, BreakpointType } from '../utils/BreakpointSystem';
import { NavigationBarView } from '../view/NavigationBarView';
import { HomeView } from '../view/HomeView';

@Entry
@Component
struct Index {
  @State dataSource: WaterFlowDataSource = new WaterFlowDataSource();
  @StorageLink(CommonConstants.BREAKPOINT_NAME) currentBreakpoint: string = CommonConstants.BREAKPOINT_SM;
  @StorageLink(CommonConstants.KEY_PAGE_CHANGE) isPageChange: boolean = false;
  private breakpointSystem: BreakpointSystem = new BreakpointSystem();
  private swiperController: SwiperController = new SwiperController();
  private data = [0, 1, 2, 3];

  aboutToAppear(): void {
    this.breakpointSystem.register();
  }

  aboutToDisappear(): void {
    this.breakpointSystem.unregister();
  }

  onPageShow(): void {
    let flowData = router.getParams() as WaterFlowData;
    let index = this.dataSource.dataList.indexOf(flowData);
    if (this.isPageChange && flowData && index === -1) {
      AppStorage.setOrCreate(CommonConstants.KEY_PAGE_CHANGE, false);
      this.dataSource.onDataAdd(flowData);
    }
  }

  build() {
    Flex({
      direction: new BreakpointType(
        {
          sm: FlexDirection.Column,
          md: FlexDirection.Row,
          lg: FlexDirection.Row,
        }
      ).getValue(this.currentBreakpoint),
      wrap: FlexWrap.NoWrap,
      justifyContent: FlexAlign.Start,
      alignItems: ItemAlign.Start,
      alignContent: FlexAlign.Start
    }) {
      Column() {
        Swiper(this.swiperController) {
          ForEach(this.data, (item: number) => {
            if (item === 0) {
              HomeView({dataSource: this.dataSource});
            } else {
              Blank()
              .width($r('app.string.full_screen'))
              .height($r('app.string.full_screen'));
            }
          })
        }
        .indicator(false)
        .disableSwipe(true)
      }
      .width($r('app.string.full_screen'))
      .height($r('app.string.full_screen'));

      NavigationBarView({ swiperController: this.swiperController});
    }
    .direction(
      new BreakpointType(
        {
          sm: Direction.Auto,
          md: Direction.Rtl,
          lg: Direction.Rtl,
        }
      ).getValue(this.currentBreakpoint)
    )
    .width($r('app.string.full_screen'))
    .height($r('app.string.full_screen'))
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
  }
}