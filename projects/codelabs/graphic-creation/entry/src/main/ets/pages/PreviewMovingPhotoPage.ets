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
import { photoAccessHelper } from '@kit.MediaLibraryKit';
import { MovingPhotoView, MovingPhotoViewController, MovingPhotoViewAttribute } from '@ohos.multimedia.movingphotoview';
import { emitter } from '@kit.BasicServicesKit';
import { CommonConstants } from '../common/CommonConstants';
import { router } from '@kit.ArkUI';
import { UIUtils } from '../utils/UIUtils';
import { BreakpointType } from '../utils/BreakpointSystem';
import { FileUtils } from '../utils/FileUtils';
import { image } from '@kit.ImageKit';

const PHOTO_SELECT_EVENT_ID: number = 80001;
let context = getContext(this);

@Entry
@Component
struct PreviewMovingPhotoPage {
  @StorageLink(CommonConstants.BREAKPOINT_NAME) currentBreakpoint: string = CommonConstants.BREAKPOINT_SM;
  @StorageLink(CommonConstants.KEY_MOVING_DATA) src: photoAccessHelper.MovingPhoto | undefined = undefined;
  @State isMuted: boolean = false;
  private controller: MovingPhotoViewController = new MovingPhotoViewController();
  private photoUriArr: string[] = [];
  private photoUri: string = '';

  async aboutToAppear(): Promise<void> {
    UIUtils.setWindowBackGroundColor(getContext(this), CommonConstants.BLACK_COLOR);
    let params: object = router.getParams();
    if (params !== undefined) {
      this.photoUri = params[CommonConstants.KEY_PARAMS_URI] as string;
      this.photoUriArr = params[CommonConstants.KEY_PARAMS_DATA] as string[];
      if (this.photoUriArr === undefined) {
        this.photoUriArr = Array<string>();
      }
    }
    this.requestMovingPhoto();
  }

  aboutToDisappear(): void {
    emitter.off(PHOTO_SELECT_EVENT_ID);
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
      alignItems: ItemAlign.Start,
      alignContent: FlexAlign.Start
    }) {
      this.setActions();
      MovingPhotoView({
        movingPhoto: this.src,
        controller: this.controller
      })
        .width($r('app.string.full_screen'))
        .objectFit(ImageFit.Contain)
        .muted(this.isMuted)
        .margin(new BreakpointType(
          {
            sm: { bottom: $r('app.float.margin_190') } as Padding,
            md: { bottom: $r('app.float.margin_190') } as Padding,
            lg: { right: $r('app.float.margin_24') } as Padding,
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

  private requestMovingPhoto() {
    let photoAsset: photoAccessHelper.PhotoAsset =
      AppStorage.get(CommonConstants.KEY_PHOTO_ASSET) as photoAccessHelper.PhotoAsset;
    if (photoAsset === undefined) {
      return;
    }
    let requestOptions: photoAccessHelper.RequestOptions = {
      deliveryMode: photoAccessHelper.DeliveryMode.FAST_MODE,
    }
    photoAccessHelper.MediaAssetManager.requestMovingPhoto(context, photoAsset, requestOptions,
      new MediaDataHandlerMovingPhoto());
  }
}

class MediaDataHandlerMovingPhoto implements photoAccessHelper.MediaAssetDataHandler<photoAccessHelper.MovingPhoto> {
  async onDataPrepared(movingPhoto: photoAccessHelper.MovingPhoto): Promise<void> {
    AppStorage.setOrCreate(CommonConstants.KEY_MOVING_DATA, movingPhoto);
  }
}