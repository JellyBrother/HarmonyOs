const JdImages = (() => {
  const list: ImageFrameInfo[] = []
  for (let index = 0; index < 28; index++) {
    list[index] = {
      src: `/assets/material/jd_animation/gif_shvp_list_${index + 1}@3x.png`,
    }
  }
  return list
})()

@Entry
@Component
struct ImageAnimatorPageB {
  @State jdState: AnimationStatus = AnimationStatus.Initial

  build() {
    Column() {
      ImageAnimator()
        .images(JdImages)
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

    }
    .height('100%')
    .width('100%')
  }
}