import { MyBuilderFunction } from '../../builder'

@Entry
@Component
struct BuilderParamModifierDialog {
  @Builder
  header() {
    Row() {
      Text('确认删除')
        .height(50)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .border({
      color: '#f0f0f0',
      width: { bottom: 1 }
    })
  }

  @Builder
  body() {
    Row() {
      Text('确定要删除吗？')
        .height(150)
        .fontColor(Color.Red)
    }
  }

  @Builder
  header2() {
    Row() {
      Text('温馨提示')
        .height(50)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .border({
      color: '#f0f0f0',
      width: { bottom: 1 }
    })
  }

  @Builder
  body2() {
    Row() {
      Text('你有一条新的消息！！')
        .height(100)
        .fontColor(Color.Green)
    }
  }

  build() {
    Column({ space: 20 }) {
      ModelDialog({
        header: () => {
          this.header()
        },
        body: () => {
          this.body()
        }
      })
      ModelDialog({
        header: () => {
          this.header2()
        },
        body: () => {
          this.body2()
        }
      })
    }
    .backgroundColor("#ddd")
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct ModelDialog {
  @BuilderParam header: () => void = MyBuilderFunction
  @BuilderParam body: () => void = MyBuilderFunction

  build() {
    Column() {
      Column() {
        // header
        Column() {
          if (this.header) {
            this.header()
          }
        }

        // body
        Column() {
          if (this.body) {
            this.body()
          }
        }

        Row({ space: 10 }) {
          Button('确定')
          Button('取消')
        }
        .width('100%')
        .justifyContent(FlexAlign.End)
      }
      .width('100%')
      .backgroundColor('#fff')
      .borderRadius(8)
      .padding(10)
    }
    .padding({ right: 20, left: 20 })
  }
}