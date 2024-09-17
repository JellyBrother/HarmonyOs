# PictureSelector
如果觉得有参考价值，麻烦帮点个star吧！多谢！:tada:

#### 介绍
Harmony简单好用的图片选择库，可以快速集成到你的项目中，支持HarmonyOS。支持自定义样式，支持多图选择。
如果使用官方图片选择可参考[使用Picker选择媒体库资源](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/photoaccesshelper-photoviewpicker-V5)
![图片选择](https://gitee.com/sea5241/PictureSelector/raw/master/%E6%BC%94%E7%A4%BA.gif)
#### 主要功能
1.  读写资源文件权限申请
2.  图片资源选择
3.  最大选择数量限制
4.  可自定义标题、图片列表、权限弹窗等样式
5.  more...（拍照、裁剪、预览、视频等待完善）

#### 权限说明
不同于Android中的权限申请，Harmony中除了**system_grant(系统授权)**和**user_grant(用户授权)**，新增了**受限开放权限**。
1.  system_grant(系统授权)
    <br>可参考[系统授权权限列表](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/permissions-for-all-V5#system_grant系统授权权限列表)
，申请方式可参考[声明权限](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/declare-permissions-V5)
2.  user_grant(用户授权)
    <br>可参考[用户授权权限列表](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/permissions-for-all-V5#user_grant用户授权权限列表)
，申请方式请参考[声明权限](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/declare-permissions-V5)> [向用户申请授权](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/request-user-authorization-V5)
3.  受限开放权限
    <br>可参考[受限开放权限列表](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/restricted-permissions-V5)
，申请方式请参考[申请使用受限权限](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/declare-permissions-in-acl-V5)
    <br>**调试阶段**暂可不用这么麻烦，可以按[申请步骤-说明](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/declare-permissions-in-acl-V5#section16719554133310)中描述的，通过DevEco Studio自动签名完成申请，参考[自动签名-操作步骤](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/ide-signing-0000001587684945-V5#section151231211105010)
：进入File > Project Structure... > Project > Signing Configs界面，勾选“Automatically generate signature”（如果是HarmonyOS工程，需同时勾选“Support HarmonyOS”），即可完成签名。如果未登录，请先单击Sign In进行登录，然后自动完成签名。
#### 使用说明

1.  因为要用到[允许读取用户公共目录的图片或视频文件权限](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/restricted-permissions-V5#section397164718158)和[允许修改用户公共目录的图片或视频文件权限](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/restricted-permissions-V5#section1417080131712)，所以需要按上述权限说明中第三项配置DevEco Studio自动签名。
2.  下载安装
    ```bash
    ohpm install @sea/picture-selector
    ```
    OpenHarmony ohpm 环境配置等更多内容，请参考[如何安装 OpenHarmony ohpm 包](https://ohpm.openharmony.cn/#/cn/help/downloadandinstall)
3.  需要跳转选择图片的地方调用如下方法即可：
    ```bash
    MediaSelector.Builder()
        .setMaxSelectCount(this.maxSelectCount)
        .build()
        .openSelectorPage(this.mediaList)
    ```

#### 参与贡献
欢迎提交PR来改进本项目
1.  Fork 本仓库
2.  新建 Feat_xxx 分支
3.  提交代码
4.  新建 Pull Request


#### 更多相关

1.  [程序访问控制](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/2_5_u7a0b_u5e8f_u8bbf_u95ee_u63a7_u5236-V5)
2.  [媒体文件管理服务](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/92_u4f53_u6587_u4ef6_u7ba1_u7406_u670d_u52a1_uff09-V5)
3.  [页面路由](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/arkts-routing-V5)
4.  [Grid自适应高度](https://developer.huawei.com/consumer/cn/forum/topic/0203142166821666372?fid=0102683795438680754)

### 友情链接
1.  [OpenHarmony组件库](https://gitee.com/explore/harmony)
2.  [OpenHarmony三方库中心仓](https://ohpm.openharmony.cn/#/cn/help/createandpublish)
3.  [Harmony官方开发文档](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/application-dev-guide-V5)
4.  [Harmony开发者学堂](https://developer.huawei.com/consumer/cn/training/dev-cert-detail/101666948302721398)
5.  [Harmony活动](https://developer.huawei.com/consumer/cn/activity/)