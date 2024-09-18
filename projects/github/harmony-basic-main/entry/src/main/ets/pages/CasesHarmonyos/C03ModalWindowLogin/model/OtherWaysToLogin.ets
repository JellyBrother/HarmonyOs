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

const PHONE_NUMBER_LENGTH = 11;
const SPACE_TWENTY = 20;
const SPACE_TEN = 10;
const COUNTDOWN_SECONDS = 30; // 倒计时总秒数
const SEND_AGAIN_IN_SECONDS = "s后可再次发送";

/**
 * 其他账号登录：主要提供短信验证码登录方式，以及其他三方应用登录方式
 */
@Entry
@Component
export struct OtherWaysToLogin {
  // 发送验证码按钮的颜色
  @State buttonColor: ResourceColor = Color.Grey;
  // 发送验证码按钮的内容
  @State buttonContent: ResourceStr = '发送短信验证码';
  // 手机号是否可用
  phoneNumberAvailable: boolean = false;
  // 可发送验证码的倒计时秒数
  countdownSeconds: number = 0;
  // 是否勾选阅读并同意服务协议及个人信息处理规则
  isAgree: boolean = false;
  loginIcons: Resource[] =
    [$r("app.media.ic_public_app_logo1"), $r("app.media.ic_public_app_logo2"), $r("app.media.ic_public_app_logo3")]

  build() {
    Column({ space: SPACE_TWENTY }) {
      Column({ space: SPACE_TEN }) {
        Row({ space: SPACE_TEN }) {
          Image($r("app.media.ic_public_phone")).width(40)
            .borderRadius(16)
          Text('手机号登录').fontSize(20)
        }
        .width('100%')

        Text('首次登录将产生新账号')
          .width('100%')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      Row() {
        Text('+86')
        Image($r("app.media.ic_public_arrow_right"))
          .size({
            width: 16,
            height: 16
          })
          .margin(10)
        TextInput({ placeholder: '请输入手机号' })
          .inputFilter('[0-9]')// 正则表达式，输入的是数字0-9则允许显示，不是则被过滤
          .backgroundColor(Color.Transparent)
          .caretColor(Color.Grey)
          .width('100%')
          .maxLength(PHONE_NUMBER_LENGTH)// 设置最大输入字符数
            // 当输入字符数为11位时，发送验证码按钮变为蓝色，否则置灰
          .onChange((value: string) => {
            if (value.length === PHONE_NUMBER_LENGTH) {
              this.phoneNumberAvailable = true;
              this.buttonColor = Color.Blue;
            } else {
              this.phoneNumberAvailable = false;
              this.buttonColor = Color.Grey;
            }
          })
      }

      Button(this.buttonContent)
        .type(ButtonType.Normal)
        .border({ radius: 16 })
        .width('100%')
        .backgroundColor(this.buttonColor)
        .onClick(() => {
          if (this.countdownSeconds > 0) { // 处于可再次发送的读秒倒计时状态下，点击按钮不响应
            return;
          }
          // 输入输入字符数为11位，并同意服务协议及个人信息处理规则，才能发送验证码
          if (!this.phoneNumberAvailable) {
            promptAction.showToast({ message: '请输入正确的手机号' });
          } else if (!this.isAgree) {
            promptAction.showToast({ message: '请先阅读并同意服务协议及个人信息处理规则' });
          } else {
            // 点击发送短信验证码按钮后，按钮置灰，开始读秒倒计时，按钮内容改变
            promptAction.showToast({ message: '验证码已发送' });
            this.buttonColor = Color.Grey;
            this.countdownSeconds = COUNTDOWN_SECONDS;
            const timerId = setInterval(() => {
              this.countdownSeconds--;
              if (this.countdownSeconds <= 0) {
                // 计时结束，根据手机号位数是否正确，重置按钮状态
                this.buttonContent = '认证服务由橘子提供';
                clearInterval(timerId);
                this.buttonColor = this.phoneNumberAvailable ? Color.Blue : Color.Grey;
                return;
              }
              this.buttonContent = this.countdownSeconds + SEND_AGAIN_IN_SECONDS;
            }, 1000)
          }
        })

      Row() {
        Checkbox({ name: 'agreement' })// $$运算符为系统内置组件提供TS变量的引用，使得TS变量和系统内置组件的内部状态保持同步
          .select($$this.isAgree)
        ReadAgreement()
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)

      Blank() // 在容器主轴方向上自动填充容器空余部分

      // 其他三方应用登录方式
      List({ space: SPACE_TWENTY }) {
        // 性能知识点：此处在List中排列组件，列表项确定、数量较少，且需要一次性加载，因此使用ForEach。在列表项多的情况下，推荐使用LazyForEach
        ForEach(this.loginIcons, (item: Resource) => {
          ListItem() {
            Image(item)
              .width(32)
              .borderRadius(16)
              .onClick(() => {
                // 调用Toast显示三方应用授权登录提示
                promptAction.showToast({ message: '使用XX应用授权登录' });
              })
          }
        })
      }
      .listDirection(Axis.Horizontal)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .padding({ bottom: 20, top: 200 })
  }
}

@Component
export struct ReadAgreement {
  build() {
    Text() {
      Span('阅读并同意')
        .fontColor('#999999')
      Span('服务协议及个人信息处理规则')
        .fontColor(Color.Orange)
        .onClick(() => {
          // 调用Toast显示用户点击服务协议及个人信息处理规则的提示
          promptAction.showToast({ message: '服务协议及个人信息处理规则' });
        })
    }
    .textAlign(TextAlign.Start)
  }
}