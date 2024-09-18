import { taskpool } from '@kit.ArkTS';

@Concurrent
function testPromise1(args1: number, args2: number): Promise<number> {
  return new Promise<number>((testFuncA, testFuncB) => {
    testFuncA(args1 + args2);
  });
}

@Concurrent
async function testPromise2(args1: number, args2: number): Promise<number> {
  return new Promise<number>((testFuncA, testFuncB) => {
    testFuncA(args1 + args2);
  });
}

@Concurrent
async function testPromise3(args1: number, args2: number): Promise<number> {
  return await new Promise<number>((testFuncA, testFuncB) => {
    testFuncA(args1 + args2)
  });
}

@Concurrent
function testPromise4() {
  return Promise.resolve(1);
}

@Concurrent
async function testPromise5(): Promise<number> {
  return 1;
}

@Concurrent
async function testPromise6(): Promise<string> {
  return await new Promise((resolve) => {
    setTimeout(() => {
      resolve("Promise setTimeout after resolve");
    }, 1000)
  });
}

async function testConcurrentFunc() {
  let task1: taskpool.Task = new taskpool.Task(testPromise1, 1, 2);
  let task2: taskpool.Task = new taskpool.Task(testPromise2, 1, 2); // testPromise2 前使用了async
  let task3: taskpool.Task = new taskpool.Task(testPromise3, 1, 2);
  let task4: taskpool.Task = new taskpool.Task(testPromise4);
  let task5: taskpool.Task = new taskpool.Task(testPromise5);
  let task6: taskpool.Task = new taskpool.Task(testPromise6); // testPromise6 使用了setTimeout=>resolve

  executeFn(task1, 1) // x_log task1 res is: 3
  executeFn(task2, 2) // x_log task2 catch e: Error: Can't return Promise in pending state
  executeFn(task3, 3) // x_log task3 res is: 3
  executeFn(task4, 4) // x_log task4 res is: 1
  executeFn(task5, 5) // x_log task5 res is: 1
  executeFn(task6, 6) // x_log task6 res is: Promise setTimeout after resolve
}

async function executeFn(task: taskpool.Task, key: number) {
  try {
    const d: object = await taskpool.execute(task)
    console.info("x_log task" + key + " res is: " + d)
  } catch (e) {
    console.info("x_log task" + key + " catch e: " + e)
  }
}

@Entry
@Component
struct ConcurrentModifier {
  build() {
    Row() {
      Column() {
        Button('点击')
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            testConcurrentFunc();
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}