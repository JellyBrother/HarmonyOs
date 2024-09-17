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

import { BreakpointConstants as Breakpoint, CommonConstants as BaseCommon, BreakpointType } from '@ohos/base/';
import { CardArrayViewModel, CardArray, CommentInputView } from '@ohos/detail/';
import { DetailVertical } from './DetailVerticalView';

const KEY_BACKGROUND: string = 'background';

@Component
export struct PictureDetail {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = Breakpoint.BREAKPOINT_SM;
  @StorageLink('cardArrayViewModel') cardArrayViewModel: CardArray = CardArrayViewModel.getInstance();
  @StorageLink('selectCardIndex') selectCardIndex: number = 0;
  @StorageLink('isDetailPage') isDetailPage: boolean = false;
  @StorageLink('isShowInput') isShowInput: boolean = false;
  @StorageLink('isPictureDetail') isPictureDetail: boolean = true;
  @StorageLink('pageInfos') pageInfos: NavPathStack = new NavPathStack();
  @State picList: Resource[] = [];
  index: number = 0;

  aboutToAppear() {
    this.isPictureDetail = true;
    CardArrayViewModel.cardArray[this.selectCardIndex].pictureArray.forEach((item: Resource) => {
      this.picList.push(item);
    })
  }

  aboutToDisappear(): void {
    this.isPictureDetail = false;
  }

  build() {
    Stack() {
      Row() {
        GridRow({
          columns: {
            sm: Breakpoint.GRID_ROW_COLUMNS[2],
            md: Breakpoint.GRID_ROW_COLUMNS[3],
            lg: Breakpoint.GRID_ROW_COLUMNS[0]
          }
        }) {
          GridCol({
            span: {
              sm: Breakpoint.GRID_COLUMN_SPANS[5],
              md: Breakpoint.GRID_COLUMN_SPANS[4],
              lg: Breakpoint.GRID_COLUMN_SPANS[0]
            }
          }) {
            Stack() {
              Swiper() {
                ForEach(this.picList, (item: Resource, index: number) => {
                  Stack() {
                    Image(item)
                      .width(BaseCommon.FULL_PERCENT)
                      .height(BaseCommon.FULL_PERCENT)
                      .objectFit(ImageFit.Contain)

                    if (this.isDetailPage && index === this.picList.length - 1) {
                      Row() {
                        Button($r('app.string.above'))
                          .width($r('app.float.above_button_width'))
                          .height($r('app.float.button_height'))
                          .visibility(this.selectCardIndex === 0 ? Visibility.Hidden : Visibility.Visible)
                          .onClick(() => {
                            AppStorage.setOrCreate('selectCardIndex', this.selectCardIndex - 1);
                            this.pageInfos.replacePath({ name: 'pictureDetail', param: 0 });
                          })

                        Button($r('app.string.next'))
                          .width($r('app.float.above_button_width'))
                          .height($r('app.float.button_height'))
                          .visibility(this.selectCardIndex === CardArrayViewModel.cardArray.length - 1 ?
                          Visibility.Hidden : Visibility.Visible)
                          .onClick(() => {
                            AppStorage.setOrCreate('selectCardIndex', this.selectCardIndex + 1);
                            this.pageInfos.replacePath({ name: 'pictureDetail', param: 0 });
                          })
                      }
                      .width(BaseCommon.FULL_PERCENT)
                      .padding({
                        left: new BreakpointType($r('app.float.window_padding_left_sm'),
                          $r('app.float.window_padding_left_md'), $r('app.float.window_padding_left_lg'))
                          .getValue(this.currentBreakpoint),
                        right: new BreakpointType($r('app.float.window_padding_left_sm'),
                          $r('app.float.window_padding_left_md'), $r('app.float.window_padding_left_lg'))
                          .getValue(this.currentBreakpoint)
                      })
                      .justifyContent(FlexAlign.SpaceBetween)
                      .margin({ bottom: $r('app.float.button_line_margin_bottom') })
                    }
                  }
                  .alignContent(Alignment.BottomStart)
                }, (item: Resource, index: number) => index + JSON.stringify(item))
              }
              .autoPlay(false)
              .indicator(
                new DigitIndicator()
                  .fontColor($r('app.color.white'))
                  .digitFont({
                    size: $r('app.float.swiper_digit_font_size'),
                    weight: FontWeight.Normal
                  })
                  .selectedFontColor($r('app.color.white'))
                  .bottom($r('app.float.swiper_digit_bottom'))
              )
              .loop(false)
              .index(this.index)
              .onClick(() => {
                if (this.isDetailPage) {
                  this.pageInfos.replacePath({ name: 'detailPage' });
                } else {
                  this.pageInfos.pop();
                }
              })

              Image($r('app.media.ic_public_back'))
                .width($r('app.float.back_width'))
                .aspectRatio(1)
                .onClick(() => {
                  if (this.isDetailPage) {
                    this.pageInfos.replacePath({ name: 'detailPage' });
                  } else {
                    this.pageInfos.pop();
                  }
                })
                .margin({
                  left: new BreakpointType<ResourceStr>($r('app.float.back_margin_left_sm'),
                    $r('app.float.back_margin_left_md'), $r('app.float.back_margin_left_lg'))
                    .getValue(this.currentBreakpoint),
                  top: $r('app.float.back_margin_top')
                })
            }
            .align(Alignment.TopStart)
          }

          GridCol({
            span: {
              sm: Breakpoint.GRID_COLUMN_SPANS[5],
              md: Breakpoint.GRID_COLUMN_SPANS[6],
              lg: Breakpoint.GRID_COLUMN_SPANS[0]
            }
          }) {
            DetailVertical()
          }
          .visibility(this.currentBreakpoint === Breakpoint.BREAKPOINT_LG ? Visibility.None : Visibility.Visible)
        }
        .layoutWeight(1)

        DetailVertical()
          .width($r('app.float.content_with'))
          .visibility(this.currentBreakpoint !== Breakpoint.BREAKPOINT_LG ? Visibility.None : Visibility.Visible)
      }
      .expandSafeArea([SafeAreaType.KEYBOARD, SafeAreaType.SYSTEM])

      if (this.isShowInput) {
        Stack() {
          Column()
            .justifyContent(FlexAlign.End)
            .width(BaseCommon.FULL_PERCENT)
            .height(BaseCommon.FULL_PERCENT)
            .backgroundColor(Color.Black)
            .opacity($r('app.float.text_input_bgc_opacity'))
            .key(KEY_BACKGROUND)
            .onClick(() => {
              AppStorage.setOrCreate('isShowInput', false);
              focusControl.requestFocus(KEY_BACKGROUND);
            })

          CommentInputView()
        }
        .alignContent(Alignment.Bottom)
      }
    }
    .height(BaseCommon.FULL_PERCENT)
    .width(BaseCommon.FULL_PERCENT)
    .backgroundColor(Color.Black)
  }
}