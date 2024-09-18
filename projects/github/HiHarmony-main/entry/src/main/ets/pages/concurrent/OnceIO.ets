import { fileIo } from '@kit.CoreFileKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { common } from '@kit.AbilityKit';

async function write(data: string, file: fileIo.File): Promise<void> {
  fileIo.write(file.fd, data).then((writeLen: number) => {
    console.log('write data length is: ' + writeLen)
  }).catch((err: BusinessError) => {
    console.error(`failed to write data.Code is ${err.code}, msg is ${err.message}`)
  })
}

async function testFunc(): Promise<boolean> {
  let context = getContext() as common.UIAbilityContext
  let filePath: string = context.filesDir + '/test.txt' // 应用文件路径
  console.log(`写入文件路径：${filePath}`)
  let file: fileIo.File = await fileIo.open(filePath, fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.CREATE)
  write('Hello, World', file).then(() => {
    console.info('succeeded in writing data')
    fileIo.close(file)
  }).catch((err: BusinessError) => {
    console.error(`failed to write data. Code is ${err.code}, msg is ${err.message}`)
    fileIo.close(file)
  })

  let result = await fileIo.access(filePath, fileIo.AccessModeType.EXIST)
  return result;
}

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(async () => {
            let res = await testFunc();
            console.info("res is: " + res);
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}