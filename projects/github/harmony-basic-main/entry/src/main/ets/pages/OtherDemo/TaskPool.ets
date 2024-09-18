import { taskpool } from '@kit.ArkTS'

@Entry
@Component
struct TaskPool {
  beginTaskPool() {
    taskpool.execute(task1)
    taskpool.execute(task2)
  }

  build() {
    Column() {
      Button('点击')
        .onClick(() => {
          this.beginTaskPool()
        })
    }
    .height('100%')
  }
}

@Concurrent
function task1() {
  for (let index = 0; index < 10000; index++) {
    console.log(`任务1：${index}`)
  }
}

@Concurrent
function task2() {
  for (let index = 10000; index > 0; index--) {
    console.log(`任务2：${index}`)
  }
}