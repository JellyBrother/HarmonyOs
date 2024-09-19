@Entry
@Component
struct Index {
  @State flag:boolean = false; //状态变量，用于控制组件出现或消失
  build() {
    Column() {
      if (this.flag) {
        Image($r('app.media.ic_star_red'))
          .width(150)
          .height(150)
            //透明度
            // .transition({ type: TransitionType.All, opacity: 0 })
            //平移
            .transition({ type: TransitionType.All, translate: { x: -100 }, opacity:0 })
            //缩放
            // .transition({ type: TransitionType.All, scale: { x: 0, y: 0 } })
            //旋转
          // .transition({
          //   type: TransitionType.All,
          //   rotate: {
          //     x: 0,
          //     y: 0,
          //     z: 1,
          //     angle: 90,
          //     centerY: 0,
          //     centerX: 0
          //   },
          //   opacity: 0
          // })
      }

      Blank()

      Row({ space: 50 }) {
        Button('消失')
          .backgroundColor(Color.Orange)
          .onClick(() => {
            animateTo({ duration: 2000 }, () => {
              this.flag = false;
            })
          })

        Button('出现')
          .backgroundColor(Color.Green)
          .onClick(() => {
            animateTo({ duration: 2000 }, () => {
              this.flag = true;
            })
          })
      }

    }
    .padding({ top: 200, bottom: 200 })
    .width('100%')
    .height('100%')
  }
}

