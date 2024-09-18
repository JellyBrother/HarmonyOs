**【需求】**
实现类似微信拉起支付页面。在手机应用程管理界面，可以看到同一个应用的两个窗口，如下图

<div style="float: left;">
<img src="https://i-blog.csdnimg.cn/direct/62c218d503c34f6f9213006fc01e84e6.png" width="180">
<img src="https://i-blog.csdnimg.cn/direct/dcfc3c3d8a5d49fd8d27b7d149e8acf4.png" width="180">
</div>


**【方案】**
在EntryAbility的页面，点击按钮拉新的Ability

**【步骤】**
1. 为EntryAbility准备页面
	1. 新建FirstAbilityPage页面
	2. 将EntryAbility中的启动页面改为FirstAbilityPage
2. 为SecondAbility准备页面
	1. 新建SecondAbilityPage页面
	2. 在entry/src/main/ets，鼠标右键，新建一个Ability，名称为SecondAbility
	3. 将SecondAbility中的启动页面改为SecondAbilityPage


**【代码】**
1. FirstAbilityPage.ets
```ts
import { common, Want } from '@kit.AbilityKit';

@Entry
@Component
struct FirstAbilityPage {
  @State message: string = 'First Ability Page';

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('FirstAbilityPageHelloWorld')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
      Button('打开 Second Ability')
        .id('FirstAbilityPageOpenBtn')
        .alignRules({
          top: { anchor: 'FirstAbilityPageHelloWorld', align: VerticalAlign.Bottom },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .offset({ y: 10 })
        .onClick(this.explicitStartAbility)

    }
    .height('100%')
    .width('100%')
  }

  async explicitStartAbility() {
    try {
      const want: Want = {
        deviceId: '',
        bundleName: 'com.example.harmonybasic',
        abilityName: 'SecondAbility'
      }
      const context = getContext() as common.UIAbilityContext
      await context.startAbility(want)
      console.log('x_log', 'startAbility 成功')
    } catch (err) {
      console.log('x_log', err)
    }
  }
}

```
2. EntryAbility.ets
```ts
windowStage.loadContent('pages/AbilityDemo/FirstAbilityPage', (err, data) => {})
```

3. SecondAbilityPage.ets
```ts
@Entry
@Component
struct SecondAbilityPage {
  @State message: string = 'Second Ability Page';

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('SecondAbilityPageHelloWorld')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }
    .height('100%')
    .width('100%')
  }
}
```

4. SecondAbility.ets
```ts
windowStage.loadContent('pages/AbilityDemo/SecondAbilityPage', (err) => {});
```

**【测试】**
点击按钮，可以拉起新的Ability，显示Second Ability Page


**【效果图】**

<div style="float: left;">
<img src="https://i-blog.csdnimg.cn/direct/6d4eaae0133a4dd2adf3914033f3772e.png" width="180">
<img src="https://i-blog.csdnimg.cn/direct/7d0527ba0d7248caacadfb4da9869735.png" width="180">
<img src="https://i-blog.csdnimg.cn/direct/4b41783473c84e0bb77c257fc5d10d0a.png" width="180">
<img src="https://i-blog.csdnimg.cn/direct/d7dd1743f2ea4634a5296eaafaf3994e.png" width="180">
</div>







