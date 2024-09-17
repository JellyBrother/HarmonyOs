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

export interface NavBarItemType {
  order: string,
  title: string
}

@Component
export struct NavBarItem {
  @Consume('knowledgeMapPageStack') knowledgeMapPageStack: NavPathStack;
  @Prop navBarItem: NavBarItemType;
  @Link currentNavBarIndex: number;

  build() {
    Row() {
      Text(this.navBarItem.order)
        .margin({ right: 6 })
        .fontFamily('HarmonyHeiTi-Bold')
        .fontSize(21)
        .fontColor('#182431')
        .textAlign(TextAlign.Start)
        .lineHeight(22)
        .fontWeight(700)
      Text(this.navBarItem.title)
        .fontFamily('HarmonyHeiTi-Medium')
        .fontSize(16)
        .fontColor('#182431')
        .textAlign(TextAlign.Start)
        .lineHeight(22)
        .fontWeight(500)
      Blank()
      Image($r('app.media.ic_arrow'))
        .width(12)
        .height(24)
    }
    .width('100%')
    .height(48)
    .borderRadius(16)
    .alignItems(VerticalAlign.Center)
    .padding({ left: 12, right: 12 })
    .backgroundColor(
      this.currentNavBarIndex === Number(this.navBarItem.order) - 1 ?
        '#1A0A59F7' :
      Color.Transparent
    )
    .onClick(() => {
      const index = Number(this.navBarItem.order) - 1;
      this.currentNavBarIndex = index;
      this.knowledgeMapPageStack.replacePath({ name: 'KnowledgeMapContent' });
    })
  }
}