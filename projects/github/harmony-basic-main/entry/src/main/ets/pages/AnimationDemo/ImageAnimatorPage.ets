interface ImageType {
  src: string
}

const jdImages = (() => {
  const list: ImageType[] = []
  for (let index = 0; index < 28; index++) {
    list[index] = {
      src: `/assets/material/jd_animation/gif_shvp_list_${index + 1}@3x.png`
    }
  }
  return list
})()

const diceImages = (() => {
  const list: ImageType[] = []
  for (let index = 0; index < 4; index++) {
    list[index] = {
      src: `/assets/material/wechat_dice/dice_Action_${index}.png`
    }
  }
  return list
})()

@Entry
@Component
struct ImageAnimatorPage {
  @State
  jdState: AnimationStatus = AnimationStatus.Initial
  @State
  diceState: AnimationStatus = AnimationStatus.Initial

  build() {
    Row() {
      Column({ space: 20 }) {
        ImageAnimator()
          .images(jdImages)
          .state(this.jdState)
          .fillMode(FillMode.None)
          .duration(2000)
          .iterations(-1)
          .width(120)
          .height(200)

        Button('启动/暂停')
          .onClick(() => {
            const state =
              this.jdState === AnimationStatus.Running ?
              AnimationStatus.Paused :
              AnimationStatus.Running
            this.jdState = state
          })

        ImageAnimator()
          .images(diceImages)
          .state(this.diceState)
          .fillMode(FillMode.None)
          .duration(200)
          .iterations(-1)
          .width(80)
          .height(80)

        Button('启动/暂停')
          .onClick(() => {
            const state =
              this.diceState === AnimationStatus.Running ?
              AnimationStatus.Paused :
              AnimationStatus.Running
            this.diceState = state
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}