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