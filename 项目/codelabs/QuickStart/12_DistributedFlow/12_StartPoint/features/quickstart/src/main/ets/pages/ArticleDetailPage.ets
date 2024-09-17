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

import { webview } from '@kit.ArkWeb';
import { ArticleClass } from '../model/ArticleClass'
import { emitter } from '@kit.BasicServicesKit';
import { Speaker } from '@ohos/utils';

@Component
export struct ArticleDetailPage {
  @State webviewController: webview.WebviewController = new webview.WebviewController;
  @Consume('articlePathStack') articlePathStack: NavPathStack;
  @State articleDetail: ArticleClass | null = null;
  @State isClicked: boolean = false;
  speaker: Speaker = new Speaker();

  aboutToAppear(): void {
    this.articleDetail = this.articlePathStack.getParamByName('articleDetail')[0] as ArticleClass;
    emitter.on("eventId", () => {
      this.isClicked = false;
    });
  }

  aboutToDisappear(): void {
    this.speaker?.shutdownEngine();
  }

  build() {
    NavDestination() {
      Column() {
        Row() {
          Row() {
            Image($r('app.media.ic_back'))
              .width(40)
              .height(40)
              .onClick(() => {
                this.articlePathStack.pop()
              })
            Row() {
              Text(this.articleDetail?.title)
                .fontFamily('HarmonyHeiTi-Bold')
                .fontSize(20)
                .textAlign(TextAlign.Start)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .maxLines(1)
                .fontWeight(700)
                .margin({ left: 8 })
            }
          }
          .width('80%')

          Image(this.isClicked ? $r('app.media.ic_AI_read_on') : $r('app.media.ic_AI_read_normal'))
            .width(40)
            .height(40)
            .onClick(() => {
              this.isClicked = !this.isClicked;
              if (this.isClicked === true) {
                this.speaker.startSpeak(this.articleDetail!.brief)
              } else {
                this.speaker.stopSpeak();
              }
            })
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
        .height(56)

        WebComponent({ articleDetail: this.articleDetail, webviewController: this.webviewController })
      }
      .padding({ left: 16, right: 16 })
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .hideTitleBar(true)
  }
}

@Component
struct WebComponent {
  @Prop articleDetail: ArticleClass | null;
  @Prop webviewController: WebviewController;

  build() {
    Column() {
      Web({ src: this.articleDetail?.webUrl, controller: this.webviewController })
        .darkMode(WebDarkMode.Auto)
        .domStorageAccess(true)
        .zoomAccess(true)
        .fileAccess(true)
        .mixedMode(MixedMode.All)
        .cacheMode(CacheMode.None)
        .javaScriptAccess(true)
        .width('100%')
        .layoutWeight(1)
    }
  }
}