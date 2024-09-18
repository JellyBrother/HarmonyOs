import { display, promptAction } from '@kit.ArkUI'

@Extend(Text)
function getTextStyles2() {
  .fontColor(Color.White)
  .fontSize(18)
  .fontWeight(FontWeight.Medium)
}

@Extend(Row)
function getTextRowStyles2() {
  .width(60)
  .aspectRatio(1)
  .backgroundColor('#333')
  .borderRadius(30)
  .justifyContent(FlexAlign.Center)
}

@Entry
@Component
struct GestureGroupPage {
  @State
  showVoice: boolean = false
  @State
  gestureType: GestureGroupType = GestureGroupType.NONE
  @State
  screenWidth: number = 0
  @State
  screenHeight: number = 0

  @Builder
  getVoiceContext() {
    Column() {
      Row() {
        Row() {
          Text('删')
            .getTextStyles2()
            .fontColor(this.gestureType === GestureGroupType.DELETE ? '#333' : Color.White)
        }
        .getTextRowStyles2()
        .backgroundColor(this.gestureType === GestureGroupType.DELETE ? Color.White : '#333')
        .rotate({
          angle: -10,
        })

        Row() {
          Text('文')
            .getTextStyles2()
            .fontColor(this.gestureType === GestureGroupType.TEXT ? '#333' : Color.White)
        }
        .getTextRowStyles2()
        .backgroundColor(this.gestureType === GestureGroupType.TEXT ? Color.White : '#333')
        .rotate({
          angle: 10,
        })
      }
      .width('100%')
      .padding({
        left: 40,
        right: 40,
      })
      .margin({
        bottom: '-30%'
      })
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
      }
      .width('80%')
      .aspectRatio(1 / 2)
      .borderRadius({
        topRight: 400,
        bottomRight: 400,
      })
      .rotate({
        angle: -90
      })
      .backgroundColor(this.gestureType === GestureGroupType.NONE ? Color.White : '#333')
      .margin({
        bottom: '-88%'
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('rgba(0, 0, 0, 0.5)')
    .justifyContent(FlexAlign.End)
  }

  aboutToAppear(): void {
    // this.getDisplay()
  }

  async getDisplay() {
    // 获取宽高方法二，需要似器
    const result = await display.getAllDisplays()
    promptAction.showToast({
      message: px2vp(result[0].width).toString()
    })
    this.screenWidth = px2vp(result[0].width)
    this.screenHeight = px2vp(result[0].height)
  }

  build() {
    Column() {
      Button('按住 说话')
        .type(ButtonType.Normal)
        .width('100%')
        .height(44)
        .gesture(
          GestureGroup(
            GestureMode.Parallel,
            // 第一个手势：长按手势
            LongPressGesture()
              .onAction(() => {
                this.showVoice = true
              })
              .onActionEnd(() => {
                this.showVoice = false
              }),
            // 第二个手势：拖动手势
            PanGesture()
              .onActionUpdate((event) => {
                const globalX = event.fingerList[0].globalX
                const globalY = event.fingerList[0].globalY
                // 在下部拖动
                if (globalY > this.screenHeight - 120) {
                  this.gestureType = GestureGroupType.NONE
                  return
                }
                // 在上部拖动
                if (globalX < this.screenWidth / 2) {
                  // 左边
                  this.gestureType = GestureGroupType.DELETE
                } else {
                  // 右边
                  this.gestureType = GestureGroupType.TEXT
                }
              })
              .onActionEnd(() => {
                this.gestureType = GestureGroupType.NONE
              })
          )
        )
    }
    .width('100%')
    .height('100%')
    .padding(30)
    .justifyContent(FlexAlign.End)
    .bindContentCover($$this.showVoice, this.getVoiceContext(), {
      modalTransition: ModalTransition.NONE
    })
    .onAreaChange((oldArea, newArea) => {
      // 获取宽高方法一
      this.screenWidth = newArea.width as number
      this.screenHeight = newArea.height as number
    })
  }
}

enum GestureGroupType {
  DELETE,
  TEXT,
  NONE,
}