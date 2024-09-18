import { MessageEvents, worker } from '@kit.ArkTS'

@Entry
@Component
struct WorkDemo {
  build() {
    Row() {
      Column() {
        Button('点击')
          .onClick(() => {
            const w = new worker.ThreadWorker('entry/ets/workers/WorkerDemo')
            w.postMessage('已经点了按钮')
            w.onmessage = (e: MessageEvents) => {
              AlertDialog.show({ message: `主线程: ${e.data}` })
            }
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}