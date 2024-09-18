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

import promptAction from '@ohos.promptAction';
import { OtherWaysToLogin, ReadAgreement } from './OtherWaysToLogin';

const EFFECT_DURATION = 800;
const EFFECT_OPACITY = 0.4;
const SPACE_TEN = 10;

@Component
export struct DefaultLogin {
  /**
   * isPresentInLoginView控制登录页面是否显示
   * 子组件中被@Link装饰的变量与其父组件中@State装饰的对应数据源建立双向数据绑定，详见：
   * https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/arkts-link-0000001820999565
   */
  @Link isPresentInLoginView: boolean;
  // 是否是默认一键登录方式
  @State isDefaultLogin: boolean = true;
  // 用户名
  userName: string = '18888888888';
  // 判断是否同意协议
  isConfirmed: boolean = false;
  private effect: TransitionEffect = TransitionEffect.OPACITY
    .animation({ duration: EFFECT_DURATION })
    .combine(TransitionEffect.opacity(EFFECT_OPACITY))

  // 默认一键登录方式
  @Builder
  DefaultLoginPage() {
    Column({ space: SPACE_TEN }) {
      Row({ space: SPACE_TEN }) {
        Image($r('app.media.white'))
          .width(40)
          .height(40)
        Column({ space: SPACE_TEN }) {
          Text('Hi, 欢迎回来')
            .fontWeight(FontWeight.Bold)
            .fontSize(20)
            .fontColor(Color.Black)

          Text('登录后更精彩，美好生活即将开始')
            .fontColor('#333333')
        }
        .alignItems(HorizontalAlign.Start)
      }
      .alignItems(VerticalAlign.Center)
      .width('100%')

      Text(this.userName)
        .fontColor('#333333')
        .fontWeight(FontWeight.Bold)
        .padding({ left: 12 })
        .height(40)
        .width('100%')
        .borderRadius(8)
        .backgroundColor('#eeeeee')

      Text('认证服务由橘子提供')
        .fontColor('#666666')
        .width('100%')
        .textAlign(TextAlign.Start)

      Row() {
        Checkbox({ name: 'checkbox1' })
          .select(this.isConfirmed)
          .onChange((value: boolean) => {
            this.isConfirmed = value
          })
        ReadAgreement()
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Button('手机号码一键登录')
        .fontColor(Color.White)
        .borderRadius(8)
        .type(ButtonType.Normal)
        .backgroundColor('#222222')
        .onClick(() => {
          if (this.isConfirmed) {
            // 调用Toast显示登录成功提示
            promptAction.showToast({ message: '登录成功' });
          } else {
            // 调用Toast显示请先阅读并同意协议提示
            promptAction.showToast({ message: '请先阅读并同意协议' });
          }
        })
        .width('100%')
        .height(50)
      Row() {
        Text('其他登录方式')
          .fontColor('#777777')
          .backgroundColor('')
          .onClick(() => {
            this.isDefaultLogin = false;
          })

        Blank() // 在容器主轴方向上自动填充容器空余部分

        Text('遇到问题')
          .fontColor('#777777')
          .backgroundColor('')
          .onClick(() => {
            // 调用Toast显示遇到问题提示
            promptAction.showToast({ message: '遇到问题' });
          })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // 登录方式有两种(默认一键登录方式和其他方式登录)，需要在一个模态窗口中切换，使用if进行条件渲染
      if (this.isDefaultLogin) {
        this.DefaultLoginPage() // 默认一键登录方式
      } else {
        OtherWaysToLogin()// 其他登录方式
          .transition(this.effect) // 此处涉及到组件的显示和消失，所以使用transition属性设置出现/消失转场
      }
      Image($r('app.media.ic_public_arrow_back'))// 通过Stack组件，两个页面只实现一个back
        .width(25)
        .height(25)
        .margin({ top: 20 })
        .onClick(() => {
          if (this.isDefaultLogin) {
            this.isPresentInLoginView = false;
          } else {
            this.isDefaultLogin = true
          }
        })
    }
    .size({ width: '100%', height: '100%' })
    .padding({
      top: 12,
      left: 12,
      right: 12
    })
    .backgroundColor(Color.White) // 将模态页面背景设置为白色，以避免模态页面内组件发生显隐变化时露出下层页面
  }
}