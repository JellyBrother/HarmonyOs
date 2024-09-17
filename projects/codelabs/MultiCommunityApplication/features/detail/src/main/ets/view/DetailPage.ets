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

import { BreakpointConstants as Breakpoint, CommonConstants as Common, BreakpointType } from '@ohos/base';
import { DetailTitleView } from './DetailTitleView';
import { MircoBlogView } from './MircoBlogView';
import { CommentListView } from './CommentListView';
import { CommentBarView } from './CommentBarView';
import { CommentInputView } from './CommentInputView';
import { CardArray } from '../viewmodel/CardArrayViewModel';
import { CardItem } from '../viewmodel/CardViewModel';
import CardArrayViewModel from '../viewmodel/CardArrayViewModel';

const KEY_BACKGROUND: string = 'background';

@Component
export struct DetailPage {
  @StorageLink('currentBreakpoint') currentBreakpoint: string = Breakpoint.BREAKPOINT_SM;
  @StorageLink('isFoldHorizontal') isFoldHorizontal: boolean = true;
  @StorageLink('cardArrayViewModel') cardArrayViewModel: CardArray = CardArrayViewModel.getInstance();
  @StorageLink('selectCardIndex') selectCardIndex: number = 0;
  @StorageLink('isDetailPage') isDetailPage: boolean = false;
  @StorageLink('isShowInput') isShowInput: boolean = false;
  @State cardItem: CardItem = this.cardArrayViewModel.cardArray[this.selectCardIndex];
  isShowedButton?: boolean = true;

  aboutToAppear() {
    this.isDetailPage = true;
  }

  build() {
    Stack() {
      Column() {
        DetailTitleView({ isShowedButton: this.isShowedButton })
        Scroll() {
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
                md: this.isFoldHorizontal ? Breakpoint.GRID_COLUMN_SPANS[4] : Breakpoint.GRID_COLUMN_SPANS[3],
                lg: Breakpoint.GRID_COLUMN_SPANS[0]
              }
            }) {
              if ((this.isFoldHorizontal && this.currentBreakpoint === Breakpoint.BREAKPOINT_MD)) {
                Scroll() {
                  MircoBlogView({
                    cardItem: this.cardItem,
                    index: this.selectCardIndex
                  })
                    .margin({
                      top: $r('app.float.mirco_blog_mt')
                    })
                }
                .scrollBar(BarState.Off)
                .align(Alignment.Top)
                .layoutWeight(1)
              } else {
                MircoBlogView({
                  cardItem: this.cardItem,
                  index: this.selectCardIndex
                })
                  .margin({
                    top: $r('app.float.mirco_blog_mt')
                  })
              }
            }
            .width(Common.FULL_PERCENT)
            .padding({
              left: new BreakpointType($r('app.float.window_padding_left_sm'), $r('app.float.window_padding_left_md'),
                $r('app.float.window_padding_left_lg')).getValue(this.currentBreakpoint),
              right: new BreakpointType($r('app.float.window_padding_left_sm'), $r('app.float.window_padding_left_md'),
                $r('app.float.window_padding_left_lg')).getValue(this.currentBreakpoint)
            })

            GridCol({
              span: {
                sm: Breakpoint.GRID_COLUMN_SPANS[5],
                md: this.isFoldHorizontal ? Breakpoint.GRID_COLUMN_SPANS[6] : Breakpoint.GRID_COLUMN_SPANS[3],
                lg: Breakpoint.GRID_COLUMN_SPANS[0]
              }
            }) {
              CommentListView()
            }
            .height(Common.FULL_PERCENT)
            .width(Common.FULL_PERCENT)
          }
        }
        .layoutWeight(1)
        .visibility(this.currentBreakpoint === Breakpoint.BREAKPOINT_LG ? Visibility.None : Visibility.Visible)
        .scrollBar(BarState.Off)

        CommentBarView()
          .visibility(this.isShow() ? Visibility.Visible : Visibility.None)

        Column() {
          SideBarContainer() {
            Column() {
              CommentListView()
            }
            .backgroundColor($r('app.color.acetate'))

            Column() {
              Scroll() {
                MircoBlogView({
                  cardItem: this.cardItem,
                  index: this.selectCardIndex
                })
                  .margin({
                    top: $r('app.float.mirco_blog_mt')
                  })
              }
              .padding({
                left: $r('app.float.window_padding_left_lg'),
                right: $r('app.float.window_padding_left_lg')
              })
              .scrollBar(BarState.Off)
            }
            .justifyContent(FlexAlign.Start)

          }
          .sideBarPosition(SideBarPosition.End)
          .showControlButton(false)
          .sideBarWidth($r('app.float.side_bar_with'))
          .minSideBarWidth($r('app.float.min_side_bar_width'))
          .maxSideBarWidth($r('app.float.max_side_bar_width'))
          .autoHide(false)
          .divider(null)
        }
        .width(Common.FULL_PERCENT)
        .visibility(this.currentBreakpoint !== Breakpoint.BREAKPOINT_LG ? Visibility.None : Visibility.Visible)
        .layoutWeight(1)
      }
      .height(Common.FULL_PERCENT)
      .justifyContent(FlexAlign.End)
      .expandSafeArea([SafeAreaType.KEYBOARD, SafeAreaType.SYSTEM])

      if (this.isShowInput) {
        Stack() {
          Column()
            .justifyContent(FlexAlign.End)
            .width(Common.FULL_PERCENT)
            .height(Common.FULL_PERCENT)
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
  }

  isShow(): boolean {
    if ((this.currentBreakpoint === Breakpoint.BREAKPOINT_MD && !this.isFoldHorizontal) ||
      (this.currentBreakpoint === Breakpoint.BREAKPOINT_SM)) {
      return true;
    }
    return false;
  }
}