/**
 * 全屏登录页面
 */
import { DefaultLogin } from './model/DefaultLogin';

/**
 * 模态转场是新的界面覆盖在旧的界面上，旧的界面不消失的一种转场方式。
 * 通过bindContentCover属性为Button组件绑定全屏模态页面，点击Button后显示模态页面，模态页面内容自定义，
 * 包含默认一键登录页面和其他登录方式页面。
 */

@Entry
@Component
struct C04ModalWindowLogin {
  // 是否显示全屏模态页面
  @State isPresent: boolean = false;

  @Builder
  loginBuilder() {
    Column() {
      DefaultLogin({ isPresentInLoginView: this.isPresent }) // 通过@State和@Link使isPresentInLoginView和isPresent产生关联
    }
  }

  build() {
    Column() {
      // TODO：需求：增加其他登录方式，如半模态窗口
      Button('点击跳转到全屏登录页')
        .fontColor(Color.White)
        .borderRadius(8)/**
         * ButtonType为Normal时，按钮圆角通过通用属性borderRadius设置。不同ButtonType下borderRadius属性是否生效，详见：
         * https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-button-0000001815086854-V5#ZH-CN_TOPIC_0000001815086854__buttontype枚举说明
         */
        .type(ButtonType.Normal)
        .backgroundColor('#222222')
        .width('100%')/**
         * TODO: 知识点: 通过bindContentCover属性为组件绑定全屏模态页面
         * isPresent：是否显示全屏模态页面
         * loginBuilder：配置全屏模态页面内容
         */
        .bindContentCover($$this.isPresent, this.loginBuilder)
        .onClick(() => {
          this.isPresent = true; // 当isPresent为true时显示模态页面，反之不显示
        })
    }
    .size({ width: '100%', height: '100%' })
    .padding(12)
    .justifyContent(FlexAlign.Center)
  }
}
