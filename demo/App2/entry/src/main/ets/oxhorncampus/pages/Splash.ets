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
import router from '@ohos.router';
// import { router } from '@kit.ArkUI';
import { CommonConstants as Const } from '../common/constants/CommonConstants';
import dataPreferences from '@ohos.data.preferences';

// import { splashImages } from '../viewmodel/SplashModel';

@Entry
@Component
struct Splash {
  private swiperController: SwiperController = new SwiperController();
  private data: Resource[] = [];
  @State countdown: number = Const.COUNTDOWN;
  @State showSwiper: boolean = false;
  private timer: number = 0;
  private preferences?: dataPreferences.Preferences
  private key_Splash_first_start: string = "key_Splash_no_first_start";

  async aboutToAppear(): Promise<void> {
    let context = getContext(this);
    this.preferences = await dataPreferences.getPreferences(context, 'com.jelly.app2.oxhorncampus');
    let isNoFirstStart = await this.preferences.get(this.key_Splash_first_start, false);
    if (isNoFirstStart) {
      this.jumpToMainPage2()
      return
    }
    this.preferences.put(this.key_Splash_first_start, true);
    this.preferences.flush();

    let data: Resource[] = [$r('app.media.splash1'), $r('app.media.splash2'), $r('app.media.splash3')];
    // let hours = new Date().getHours();
    // if (hours >= Const.MORNING_TIME && hours < Const.EVENING_TIME) {
    //   data = splashImages.day;
    // } else if (hours >= Const.EVENING_TIME && hours <= Const.NIGHT_TIME) {
    //   data = splashImages.dusk;
    // } else {
    //   data = splashImages.night;
    // }
    this.data = data;
    setTimeout(() => {
      this.showSwiper = true;
      this.startTiming();
    }, Const.SPLASH_DURATION);
  }

  startTiming() {
    this.timer = setInterval(() => {
      this.countdown--;
      if (this.countdown === 0) {
        this.clearTiming();
        this.jumpToMainPage();
      }
    }, Const.DURATION);
  }

  clearTiming() {
    if (this.timer !== null) {
      clearInterval(this.timer);
      this.timer = 0;
    }
  }

  jumpToMainPage() {
    this.clearTiming();
    this.jumpToMainPage2()
  }

  jumpToMainPage2() {
    router.replaceUrl({
      url: 'oxhorncampus/pages/MainPage'
    });
  }

  aboutToDisappear() {
    this.clearTiming();
  }

  build() {
    Column() {
      Stack() {
        if (this.showSwiper) {
          Swiper(this.swiperController) {
            ForEach(this.data, (item: Resource) => {
              Image(item)
                .width(Const.FULL_SIZE)
                .height(Const.FULL_SIZE)
                .objectFit(ImageFit.Cover)
            })
          }
          .loop(true)
          .interval(2 * Const.DURATION)
          .duration(Const.DURATION)
          .autoPlay(true)
          .indicator(true)
          .curve(Curve.Linear)
          .onChange((index: number) => {
            console.info(index.toString())
          })

          Text() {
            Span($r('app.string.skip'))
            Span(`${this.countdown}`)
          }
          .onClick(() => this.jumpToMainPage())
          .fontColor(Color.White)
          .fontSize($r('app.float.12fp'))
          .backgroundColor($r('app.color.swiper_jump_bg_color'))
          .width($r('app.float.63'))
          .height($r('app.float.24'))
          .borderRadius($r('app.float.10'))
          .textAlign(TextAlign.Center)
          .position({
            x: Const.PERCENTAGE_78,
            y: $r('app.float.63')
          })
        } else {
          Image($r('app.media.splash_bg'))
            .width('100%')
            .height('100%')
          Image($r('app.media.startIcon'))
            .width($r('app.float.192'))
            .height($r('app.float.192'))
            .offset({
              y: `-${Const.PERCENTAGE_15}`
            })
            .objectFit(ImageFit.Contain)

          Column() {
            Text(Const.SPLASH_DES)
              .fontColor(Color.White)
              .fontSize($r('app.float.font_size_24fp'))
              .fontWeight(FontWeight.Medium)

            Text(Const.SPLASH_WELCOME)
              .fontSize($r('app.float.font_size_16fp'))
              .fontColor(Color.White)
              .margin({
                top: $r('app.float.5')
              })
          }
          .offset({
            y: Const.PERCENTAGE_25
          })
        }
      }
    }
    .height(Const.FULL_SIZE)
    .width(Const.FULL_SIZE)
  }
}