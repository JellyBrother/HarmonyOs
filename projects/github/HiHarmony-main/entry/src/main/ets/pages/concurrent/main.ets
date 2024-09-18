import { BusinessError } from '@kit.BasicServicesKit';
import { router } from '@kit.ArkUI';

async function requestContent(): Promise<string> {
  const result: string = await new Promise((resolve: Function) => {
    setTimeout(() => {
      resolve('Hello, world')
    }, 3000)
  })
  console.log(result)
  return result;
}

@Entry
@Component
struct ConcurrentInsight {
  build() {
    Column() {
      Button('Promise').onClick(async () => {
        let res = await requestContent()
        console.info(`res is: ${res}`)
      })
      Button('单次IO').onClick(() => {
        router.pushUrl({ url: 'pages/concurrent/OnceIO' })
      })
      Button('TaskPool').onClick(() => {
        router.pushUrl({ url: 'pages/concurrent/TaskPool' })
      })
    }
  }
}