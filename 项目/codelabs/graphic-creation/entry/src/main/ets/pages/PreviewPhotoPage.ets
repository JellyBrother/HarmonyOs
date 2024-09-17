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
import { router } from '@kit.ArkUI'
import { CommonConstants } from '../common/CommonConstants';
import { BreakpointType } from '../utils/BreakpointSystem';
import { FileUtils } from '../utils/FileUtils';
import { UIUtils } from '../utils/UIUtils';

@Entry
@Component
struct PreviewPhotoPage {
  @StorageLink(CommonConstants.BREAKPOINT_NAME) currentBreakpoint: string = CommonConstants.BREAKPOINT_SM;
  @State pixelMap: PixelMap | undefined = undefined;
  private photoUriArr: string[] = [];
  private photoUri: string = '';

  aboutToAppear(): void {
    UIUtils.setWindowBackGroundColor(getContext(this), CommonConstants.BLACK_COLOR);
    let params: object = router.getParams();
    if (params !== undefined) {
      this.photoUri = params[CommonConstants.KEY_PARAMS_URI] as string;
      this.photoUriArr = params[CommonConstants.KEY_PARAMS_DATA] as string[];
      FileUtils.createPixelMapFromUri(this.photoUri).then(value => {
        this.pixelMap = value;
      });
      if (this.photoUriArr === undefined) {
        this.photoUriArr = Array<string>();
      }
    }
  }

  build() {
    Flex({
      direction: new BreakpointType(
        {
          sm: FlexDirection.Column,
          md: FlexDirection.Column,
          lg: FlexDirection.Row,
        }
      ).getValue(this.currentBreakpoint),
      wrap: FlexWrap.NoWrap,
      justifyContent: FlexAlign.Start,
      alignItems: ItemAlign.Center,
      alignContent: FlexAlign.Center
    }) {
      this.setActions();

      Image(this.pixelMap)
        .width($r('app.string.full_screen'))
        .objectFit(ImageFit.Contain)
        .dynamicRangeMode(DynamicRangeMode.HIGH)
        .margin(new BreakpointType(
          {
            sm: {bottom: $r('app.float.margin_24')} as Margin,
            md: {bottom: $r('app.float.margin_24')} as Margin,
            lg: {right: $r('app.float.margin_24')} as Margin
          }
        ).getValue(this.currentBreakpoint))

    }
    .backgroundColor(Color.Black)
    .width($r('app.string.full_screen'))
    .height($r('app.string.full_screen'))
  }

  @Builder
  setActions() {
    Flex({
      direction: new BreakpointType(
        {
          sm: FlexDirection.Row,
          md: FlexDirection.Row,
          lg: FlexDirection.Column,
        }
      ).getValue(this.currentBreakpoint),
      wrap: FlexWrap.NoWrap,
      justifyContent: FlexAlign.SpaceBetween,
      alignItems: ItemAlign.Start,
      alignContent: FlexAlign.Start
    }) {
      this.addImage();
    }
    .width(new BreakpointType(
      {
        sm: $r('app.string.full_screen'),
        md: $r('app.string.full_screen'),
        lg: $r('app.float.navigation_height_lg'),
      }
    ).getValue(this.currentBreakpoint))
    .height(new BreakpointType(
      {
        sm: $r('app.float.icon_size_24'),
        md: $r('app.float.icon_size_24'),
        lg: $r('app.string.full_screen'),
      }
    ).getValue(this.currentBreakpoint))
    .padding(
      new BreakpointType(
        {
          sm: { left: $r('app.float.margin_24'), right: $r('app.float.margin_24') } as Padding,
          md: { left: $r('app.float.margin_24'), right: $r('app.float.margin_24') } as Padding,
          lg: { bottom: $r('app.float.margin_36'), top: $r('app.float.margin_36') } as Padding,
        }
      ).getValue(this.currentBreakpoint))
    .margin(new BreakpointType(
      {
        sm: {
          bottom: $r('app.float.margin_24'),
          top: $r('app.float.navigation_height_sm')
        } as Padding,
        md: {
          bottom: $r('app.float.margin_24'),
          top: $r('app.float.navigation_height_sm')
        } as Padding,
        lg: { left: $r('app.float.margin_24'), right: $r('app.float.margin_24') } as Padding,
      }
    ).getValue(this.currentBreakpoint));
  }

  @Builder
  addImage() {
    Image($r('app.media.cancel'))
      .width($r('app.float.icon_size_24'))
      .height($r('app.float.icon_size_24'))
      .objectFit(ImageFit.Cover)
      .onClick(() => {
        router.back({
          url: "pages/ImageEditPage"
        });
      })

    Image($r('app.media.selected'))
      .width($r('app.float.icon_size_24'))
      .height($r('app.float.icon_size_24'))
      .objectFit(ImageFit.Cover)
      .onClick(() => {
        if (this.photoUri !== '') {
          this.photoUriArr.unshift(this.photoUri);
          FileUtils.unshiftFiles(this.photoUri);
          FileUtils.sendCloudFile(getContext(this), [this.photoUri]);
        }
        router.replaceUrl({
          url: 'pages/GraphicCreationPage',
          params: this.photoUriArr
        });
      })
  }
}