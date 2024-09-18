@Entry
@Component
struct VideoPage {
  @State
  speed: number = 1
  controller: VideoController = new VideoController()

  build() {
    Row() {
      Column({ space: 20 }) {
        // 音频-常规使用
        Video({
          src: '/assets/media/KMS.mp3'
        })
          .width('100%')
          .height(44)

        // 音频-背景音乐
        Video({
          src: '/assets/media/KMS.mp3',
          controller: this.controller,
          currentProgressRate: this.speed,
        })
          .width(0)
          .height(0)
        Row() {
          Button('播放背景音乐')
            .onClick(() => {
              this.controller.start()
            })
          Button('暂停背景音乐')
            .onClick(() => {
              this.controller.pause()
            })
          Slider({
            min: 0.5,
            max: 2,
            step: 0.25,
            value: $$this.speed
          })
            .layoutWeight(1)
        }

        // 视频
        Video({
          src: '/assets/media/FF.mp4'
        })
          .width('100%')
          .height(300)

      }
      .width('100%')
    }
    .height('100%')
  }
}