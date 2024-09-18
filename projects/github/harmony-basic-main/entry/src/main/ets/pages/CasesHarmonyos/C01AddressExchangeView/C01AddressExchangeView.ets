/**
 * 1.地址交换动画案例
 */
import { curves } from '@kit.ArkUI'

@Entry
@Component
struct Case01AddressExchangeView {
  @State translateX: number = 0
  @State swap: boolean = false
  @State rotateAngle: number = 0
  addrWidth: number = 140
  buttonWidth: number = 40
  zeroTranslate: number = 0
  rotateAddAngle: number = 360

  build() {
    Column({ space: 10 }) {
      Row() {
        Text('广州')
          .translate({ x: this.translateX })
          .padding(10)
          .width(this.addrWidth)
          .backgroundColor('green')
          .textAlign(this.swap ? TextAlign.End : TextAlign.Start)
        Button('<>')
          .type(ButtonType.Circle)
          .width(this.buttonWidth)
          .padding(10)
          .rotate({ angle: this.rotateAngle })
          .animation({
            curve: Curve.Ease,
            playMode: PlayMode.Normal,
          })
          .onClick(() => {
            this.swap = !this.swap
            animateTo({ curve: curves.springMotion() }, () => {
              if (this.swap) {
                this.translateX = this.addrWidth + this.buttonWidth;
              } else {
                this.translateX = this.zeroTranslate;
              }
            })
            this.rotateAngle += this.rotateAddAngle;
          })
        Text('北京')
          .translate({ x: -this.translateX })
          .padding(10)
          .width(this.addrWidth)
          .backgroundColor('red')
          .textAlign(this.swap ? TextAlign.Start : TextAlign.End)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .padding(20)
  }
}