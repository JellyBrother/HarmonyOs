import { common } from '@kit.AbilityKit';

@Entry
@Component
struct PayAbPage {
  @State message: string = '支付Ability';
  @StorageProp('order_id')
  orderId: number = 0

  build() {
    Row() {
      Column({ space: 10 }) {
        Text(this.message)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
        Text(this.orderId.toString())
        Button('确定支付')
          .onClick(() => {
            const context = getContext() as common.UIAbilityContext
            context.terminateSelfWithResult({
              resultCode: 1,
              want: {
                deviceId: '',
                bundleName: 'com.example.harmonybasic',
                abilityName: 'EntryAbility',
                parameters: { 'pay_result': true }
              }
            })
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}