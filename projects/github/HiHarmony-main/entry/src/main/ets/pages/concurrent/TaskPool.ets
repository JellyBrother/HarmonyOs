import { taskpool } from '@kit.ArkTS';

@Concurrent
async function asyncFunc(val1: number, val2: number): Promise<number> {
  let ret: number = await new Promise((resolve, reject) => {
    let value = val1 + val2;
    resolve(value)
  })
  return ret;
}

function taskpoolExecutor() {
  taskpool.execute(asyncFunc, 10, 20).then((result: Object) => {
    console.info(`taskPool task result: ${result}`)
  }).catch((err: string) => {
    console.error(`taskpool occur error: ${err}`)
  })
}

@Entry
@Component
struct Index {
  build() {
    Button('触发任务池执行').onClick(() => {
      taskpoolExecutor()
    })
  }
}