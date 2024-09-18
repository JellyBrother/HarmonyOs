@Extend(Text)
function getTextStyles() {
  .fontColor(Color.White)
  .fontSize(18)
  .fontWeight(FontWeight.Medium)
}

@Extend(Row)
function getTextRowStyles() {
  .width(60)
  .aspectRatio(1)
  .backgroundColor('rgba(0, 0, 0, 0.6)')
  .borderRadius(30)
  .justifyContent(FlexAlign.Center)
}

@Entry
@Component
struct LongPressPage {
  @State
  showVoice: boolean = true

  @Builder
  getVoiceContext() {
    Column() {
      Row() {
        Row() {
          Text('删')
            .getTextStyles()
        }
        .getTextRowStyles()
        .rotate({
          angle: -10,
        })

        Row() {
          Text('文')
            .getTextStyles()
        }
        .getTextRowStyles()
        .rotate({
          angle: 10,
        })
      }
      .width('100%')
      .padding({
        left: 40,
        right: 40,
        bottom: 160,
      })
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('rgba(0, 0, 0, 0.5)')
    .justifyContent(FlexAlign.End)
  }

  build() {
    Column() {
      Button('按住 说话')
        .type(ButtonType.Normal)
        .width('100%')
        .height(44)
        .gesture(
          LongPressGesture()
            .onAction(() => {
              this.showVoice = true
            })
            .onActionEnd(() => {
              this.showVoice = false
            })
        )
    }
    .width('100%')
    .height('100%')
    .padding(30)
    .justifyContent(FlexAlign.End)
    .bindContentCover($$this.showVoice, this.getVoiceContext(), {
      modalTransition: ModalTransition.NONE
    })
  }
}