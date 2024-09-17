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

@Component
export struct ChartLegendComponent {
  private name: ResourceStr = '';
  private color: ResourceStr = '';
  private value: ResourceStr = '';

  build() {
    Column() {
      Row() {
        Text(this.name)
          .fontSize($r('app.float.text_name_size'))
          .fontColor($r('app.color.name_build_text'));
        Divider()
          .width($r('app.float.build_divider_width'))
          .height($r('app.float.build_divider_height'))
          .color(this.color)
          .borderRadius($r('app.float.build_divider_radius'))
          .margin({
            left: $r('app.float.build_divider_margin_left')
          })
      }
      Text(this.value)
        .fontColor($r('app.color.value_build_text'))
        .fontSize($r('app.float.value_build_text_size'));
    }
    .alignItems(HorizontalAlign.Start)
  }
}