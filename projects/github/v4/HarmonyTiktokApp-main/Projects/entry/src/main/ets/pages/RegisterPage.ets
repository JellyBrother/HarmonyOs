import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import Constants from '../common/Constants';
import { PortraitInfo } from '../model/PortraitInfo';
import { UserInfo } from '../model/UserInfo';

@Entry
@Component
export struct RegisterPage {
  @State message: string = 'Register Page';
  @State selectedPortraitInfo: PortraitInfo = new PortraitInfo();

  @State username: string = 'xjk';
  @State password: string = '123456';

  // 页面显示时候自动加载
  onPageShow() {
    // 从路由获取选中的头像
    let params = router.getParams();
    // 判断参数数据是否存在,存在则获取参数数据
    if (params != null) {
      this.selectedPortraitInfo =
      (params as Record<string, PortraitInfo>)[`${Constants.PARAM_SELECTED_PORTRAIT_INFO_KEY}`];
    }
  }

  validateLogin(username: string, password: string): boolean {
    return Constants.PARAM_PORTRAIT_INFO_ACCOUNT_PASSWORD.some(
      (user) => user.username === username && user.password === password
    );
  }

  build() {
    Row() {
      Column() {
        // 进行三元判断 如果非空则使用路由获取的头像信息路径
        // 为空 使用默认图片
        Image($rawfile(this.selectedPortraitInfo.portraitPath != null
          ? this.selectedPortraitInfo.portraitPath : 'portrait/ic_portraitmaleplus.png'))
          .height(108)
          .width(108)
            // 添加点击事件
          .onClick(() => {
            // 读取头像json数据转换为对象模型
            // 通过路由参数模式 传递给头像相册页面
            router.pushUrl({
              url: 'pages/PortraitAlbumPage',
              params: { [`${Constants.PARAM_PORTRAIT_INFO_ARR_KEY}`]: Constants.PORTRAIT_INFO_ARR }
            });
          });

        TextInput({ placeholder: '账号' })
          .width(320)
          .height(50)
          .borderRadius(0)
          .backgroundColor('#f9f9f9')
          .fontSize(27)
          .margin({ top: '10' })
          .type(InputType.Normal)
            // 每当输入框的值发生变化的时候 会触发的函数
          .onChange((value: string) => {
            // 获取输入框内改变的内容
            this.username = value;
          });

        TextInput({ placeholder: '密码' })
          .width(320)
          .height(50)
          .borderRadius(0)
          .backgroundColor('#f9f9f9')
          .type(InputType.Password)
          .onChange((value: string) => {
            this.password = value;
          });

        Button('注册/登录', { type: ButtonType.Normal })
          .width(320)
          .height(50)
          .borderRadius(0)
          .backgroundColor('#5AA5C7')
          .margin({ top: '10' })
          .fontSize(24)
          .onClick(() => {
            if (this.username !== '' && this.password !== '') {
            // if (this.username !== '' && this.password !== '' && this.selectedPortraitInfo.portraitPath != null) {
              if (this.validateLogin(this.username, this.password)) {
                // 校验通过，封装用户信息
                let userInfo: UserInfo = new UserInfo(this.username, this.password, this.selectedPortraitInfo.portraitPath);
                // 跳转到首页并传递用户登录信息
                router.replaceUrl({
                  url: 'pages/Index',
                  params: { [`${Constants.PARAM_LOGGED_USER_INFO_KEY}`]: userInfo }
                });
              } else {
                // 提示用户名或密码错误
                promptAction.showToast({
                  message: '用户名或密码错误!',
                  duration: 2000
                });
              }
            } else {
              // 提示账号、密码、头像不能为空
              promptAction.showToast({
                message: '账号、密码、头像都不可为空!',
                duration: 2000
              });
            }
          });
      }
      .width('100%');
    }
    .height('100%');
  }
}
