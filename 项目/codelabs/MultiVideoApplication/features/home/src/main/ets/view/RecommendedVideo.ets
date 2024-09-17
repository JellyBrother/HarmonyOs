/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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
import { BreakpointConstants, CommonConstants } from '@ohos/commons';
import { BreakpointType, Logger, WindowUtil } from '@ohos/commons';
import { HomeConstants } from '../constants/HomeConstants';
import { VideoImage, VideoImgViewModel } from '../viewmodel/VideoImgViewModel';
import { getTabIndex, VideoContent, VideoImgRating, VideoTitle } from './CommonView';
import { RightClickMenu, VideoDialog } from './VideoDialog';

@Component
export struct RecommendedVideo {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  @StorageLink('videoGridColumn') videoGridColumn: string = CommonConstants.VIDEO_GRID_COLUMNS[0];
  @StorageLink('windowWidth') windowWidth: number = 0;
  @StorageLink('currentTopIndex') currentTopIndex: number = 0;
  @State isShowingRecommendBorder: boolean = false;
  @State currentRecommendFocusIndex: number = 0;
  @State recommendedCurrentVideo: number = -1;
  @State videoImgList: VideoImage[] = new VideoImgViewModel().getVideoImgList();
  private videoDialogController?: CustomDialogController;
  private windowUtil?: WindowUtil;

  @Styles focusedStyles(): void {
    .border({
      width: $r('app.float.focus_radius_width'),
      color: $r('app.color.focus_radius_color'),
      radius: $r('app.float.banner_focus_radius')
    })
  }

  @Styles normalStyles(): void {
    .border({
      width: 0,
      radius: $r('app.float.banner_focus_radius')
    })
  }

  build() {
    Column() {
      // Video grid layout.
      Grid() {
        ForEach(this.videoImgList, (item: VideoImage, index: number) => {
          GridItem() {
            Column() {
              Stack({ alignContent: Alignment.Center }) {
                Image(item.getImgSrc())
                  .focusable(true)
                  .groupDefaultFocus(index === 0 ? true : false)
                  .objectFit(ImageFit.Fill)
                  .width(this.recommendedCurrentVideo === index ? HomeConstants.PERCENT_HUNDRED_AND_FIVE :
                    CommonConstants.FULL_PERCENT)
                  .height(this.recommendedCurrentVideo === index ? HomeConstants.PERCENT_HUNDRED_AND_FIVE :
                    CommonConstants.FULL_PERCENT)
                  .draggable(false)
                  .stateStyles({
                    normal: this.normalStyles,
                    focused: this.focusedStyles
                  })
                  .id(JSON.stringify(item))
                Column() {
                  VideoImgRating({ rating: item.getRating() })
                }
                .width(CommonConstants.FULL_PERCENT)
                .height(CommonConstants.FULL_PERCENT)
                .alignItems(HorizontalAlign.End)
                .justifyContent(FlexAlign.End)
              }
              .width(CommonConstants.FULL_PERCENT)
              // The width and height vary with the container assembly and the aspect ratio remains unchanged.
              .aspectRatio(HomeConstants.VIDEO_DIALOG_ASPECT_RATIO)
              .onHover((isHover: boolean) => {
                if (isHover) {
                  this.recommendedCurrentVideo = index;
                } else {
                  this.recommendedCurrentVideo = -1;
                }
              })
              .gesture(
                LongPressGesture({ repeat: false })
                  .onAction(() => {
                    if (index !== 0) {
                      Logger.info(`Please long press the first image`);
                      return;
                    }
                    // Obtains all attributes of a component.
                    let obj: Record<string, string> = JSON.parse(getInspectorByKey(JSON.stringify(item)));
                    let rectInfo: string[] = JSON.parse(HomeConstants.SQUARE_BRACKETS[0] + obj.$rect +
                      HomeConstants.SQUARE_BRACKETS[1]);
                    // Obtains the height of the component from the top.
                    let rectTop: number = px2vp(JSON.parse(HomeConstants.SQUARE_BRACKETS[0] + rectInfo[0] +
                      HomeConstants.SQUARE_BRACKETS[1])[1]);
                    let rectTop2: number = px2vp(JSON.parse(HomeConstants.SQUARE_BRACKETS[0] + rectInfo[1] +
                      HomeConstants.SQUARE_BRACKETS[1])[1]);
                    // Obtains the width of the component from the left.
                    let rectLeft: number = px2vp(JSON.parse(HomeConstants.SQUARE_BRACKETS[0] + rectInfo[0] +
                      HomeConstants.SQUARE_BRACKETS[1])[0]);
                    let topHeightNeeded: number = new BreakpointType(HomeConstants.VIDEO_DIALOG_HEIGHTS[0],
                      HomeConstants.VIDEO_DIALOG_HEIGHTS[1], HomeConstants.VIDEO_DIALOG_HEIGHTS[2])
                      .getValue(this.currentBreakpoint) + rectTop - rectTop2;
                    if (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM) {
                      topHeightNeeded += HomeConstants.HOME_HEADER_HEIGHT_SM;
                    }
                    let dialogYOffset: number;
                    // Adaptive pop-up window expansion direction.
                    if (topHeightNeeded < rectTop) {
                      dialogYOffset = rectTop2 - new BreakpointType(HomeConstants.VIDEO_DIALOG_HEIGHTS[0],
                        HomeConstants.VIDEO_DIALOG_HEIGHTS[1], HomeConstants.VIDEO_DIALOG_HEIGHTS[2])
                        .getValue(this.currentBreakpoint);
                    } else {
                      dialogYOffset = rectTop;
                    }
                    this.windowUtil = WindowUtil.getInstance();
                    let isLayoutFullScreen: boolean = true;
                    if (this.windowUtil === undefined) {
                      Logger.error(`WindowUtil is undefined`);
                      return;
                    }
                    let mainWindow = this.windowUtil.getMainWindow();
                    if (mainWindow === undefined) {
                      Logger.error(`MainWindow is undefined`);
                      return;
                    }
                    isLayoutFullScreen = mainWindow.getWindowProperties().isLayoutFullScreen;
                    // Subtract the width and height of the window in the 2in1 device.
                    if (deviceInfo.deviceType === CommonConstants.DEVICE_TYPES[0] && !isLayoutFullScreen) {
                      dialogYOffset -= HomeConstants.WINDOW_UNDEFINED_TOP;
                      rectLeft -= HomeConstants.WINDOW_UNDEFINED_LEFT;
                    } else {
                      Logger.info(`No need to subtract extra height`);
                    }
                    this.videoDialogController = new CustomDialogController({
                      builder: VideoDialog(),
                      autoCancel: true,
                      customStyle: true,
                      alignment: DialogAlignment.TopStart,
                      offset: {
                        dx: rectLeft,
                        dy: dialogYOffset
                      }
                    });
                    // Display the customized pop-up window to play the video.
                    this.videoDialogController.open();
                  }))
              .bindContextMenu(RightClickMenu(this.currentBreakpoint), ResponseType.RightClick)

              VideoTitle({ title: item.getTitle() })
              VideoContent({ content: item.getContent() })
            }
            .alignItems(HorizontalAlign.Start)
          }
        }, (item: VideoImage, index: number) => index + JSON.stringify(item))
      }
      .tabIndex(getTabIndex(HomeConstants.DIRECTION_LIST[4]))
      .editMode(false)
      // Sets the number of grid layout columns and evenly divides the width.
      .columnsTemplate(this.videoGridColumn)
      .rowsTemplate(CommonConstants.VIDEO_GRID_COLUMNS[0])
      .width(CommonConstants.FULL_PERCENT)
      .rowsGap($r('app.float.video_grid_gap'))
      .columnsGap($r('app.float.video_grid_gap'))
      // Dynamically calculates the total height based on the following numbers of breakpoints.
      .height(this.getGridHeight(this.videoGridColumn, this.currentBreakpoint, this.windowWidth))
      .padding({
        left: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG && this.currentTopIndex === 2 ?
          new BreakpointType($r('app.float.home_recommended_padding_sm'), $r('app.float.home_recommended_padding_md'),
          $r('app.float.home_recommended_padding_lg')).getValue(this.currentBreakpoint) :
          new BreakpointType($r('app.float.home_content_padding_sm'), $r('app.float.home_content_padding_md'),
          $r('app.float.home_content_padding_lg')).getValue(this.currentBreakpoint),
        right: new BreakpointType($r('app.float.home_content_padding_sm'), $r('app.float.home_content_padding_md'),
          $r('app.float.home_content_padding_lg')).getValue(this.currentBreakpoint),
        top: $r('app.float.recommended_video_padding_top')
      })
    }
    // Zooming and pinching functions of the grid.
    .gesture(PinchGesture({ fingers: 2 }).onActionUpdate((event: GestureEvent) => {
      if (event.scale > 1 && this.currentBreakpoint !== BreakpointConstants.BREAKPOINT_SM) {
        if (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_MD) {
          animateTo({
            duration: HomeConstants.ANIMATION_DURATION
          }, () => {
            this.videoGridColumn = CommonConstants.VIDEO_GRID_COLUMNS[1];
          })
        } else {
          animateTo({
            duration: HomeConstants.ANIMATION_DURATION
          }, () => {
            this.videoGridColumn = CommonConstants.VIDEO_GRID_COLUMNS[2];
          })
        }
      } else if (event.scale < 1 && this.currentBreakpoint !== BreakpointConstants.BREAKPOINT_SM) {
        if (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_MD) {
          animateTo({
            duration: HomeConstants.ANIMATION_DURATION
          }, () => {
            this.videoGridColumn = CommonConstants.VIDEO_GRID_COLUMNS[2];
          })
        } else {
          animateTo({
            duration: HomeConstants.ANIMATION_DURATION
          }, () => {
            this.videoGridColumn = CommonConstants.VIDEO_GRID_COLUMNS[3];
          })
        }
      } else {
        Logger.info(`Two-finger operation is not supported`);
      }
    }))
  }

  getGridHeight(videoGridColumn: string, currentBreakpoint: string, windowWidth: number): string {
    // Obtain the window width and subtract the blank parts on both sides.
    let result: number = px2vp(windowWidth) - new BreakpointType(HomeConstants.VIDEO_GRID_MARGIN[0],
      HomeConstants.VIDEO_GRID_MARGIN[1], HomeConstants.VIDEO_GRID_MARGIN[2]).getValue(this.currentBreakpoint);
    if (currentBreakpoint === BreakpointConstants.BREAKPOINT_LG) {
      result = result - HomeConstants.LG_SIDEBAR_WIDTH;
    }
    // Calculate the width of a single image based on the number of grid columns.
    if (videoGridColumn === CommonConstants.VIDEO_GRID_COLUMNS[0]) {
      result = (result - HomeConstants.VIDEO_GRID_ITEM_SPACE * 1) / HomeConstants.TWO;
    } else if (videoGridColumn === CommonConstants.VIDEO_GRID_COLUMNS[1]) {
      result = (result - HomeConstants.VIDEO_GRID_ITEM_SPACE * 2) / CommonConstants.THREE;
    } else if (videoGridColumn === CommonConstants.VIDEO_GRID_COLUMNS[2]) {
      result = (result - HomeConstants.VIDEO_GRID_ITEM_SPACE * 3) / CommonConstants.FOUR;
    } else {
      result = (result - HomeConstants.VIDEO_GRID_ITEM_SPACE * 4) / HomeConstants.FIVE;
    }
    // Calculate the height of a single image, title, and content, and calculate the total height of the grid layout.
    return result / HomeConstants.VIDEO_DIALOG_ASPECT_RATIO * HomeConstants.TWO +
      HomeConstants.VIDEO_GRID_DESCRIPTION_HEIGHT + HomeConstants.HEIGHT_UNIT;
  }
}

