/**
 * 官方文档
 * https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/js-apis-photoaccesshelper-V5#showassetscreationdialog12
 */

import { http } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
import util from '@ohos.util';
import { fileUri } from '@kit.CoreFileKit';
import fs, { ReadOptions } from '@ohos.file.fs';
import { photoAccessHelper } from '@kit.MediaLibraryKit';
import { dataSharePredicates } from '@kit.ArkData';
import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct SaveAlbum {
  @State message: string = 'Hello World';
  url1: string = "https://img20.360buyimg.com/img/jfs/t1/241153/31/4968/64736/65e53e56Fd3868b6e/b595d41ca8447ea4.jpg";
  url2: string =
    "https://upfile-drcn.platform.hicloud.com/ptTJ5B1eJ6k-d45UmOTF0Q.FYlVoBLGO3P9jZfjPUtqh2Cry9mQBzJButWu-okMhg2Xsd4zaoBTVAAsA08DPk1Vn7VFa1Mpl1Dp112CNKhEBjd4a9kP2NCKrQUpgq0HP_E3uqofnQ.6099200.png";

  build() {
    Column({ space: 30 }) {
      Text('保存到相册').fontSize(30)
      Column() {
        Text(this.url1)
        Button("保存").onClick(() => {
          this.downloadAndSave(this.url1)
        })
      }.margin({ top: 15, bottom: 15 })

      Column() {
        Text(this.url2)
        Button("保存").onClick(() => {
          this.downloadAndSave(this.url2);
        })
      }.margin({ top: 15, bottom: 15 })
    }.justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center).height('100%').width('100%')
  }

  downloadAndSave(url: string) {
    const arr = url.split('.')
    const type = arr[arr.length -1]
    httpDownload(url, type).then((result: DownloadResult) => {
      if (result.isSuccess) {
        promptAction.showToast({ message: "下载成功" })
      } else {
        console.error("失败：" + result.msg);
        promptAction.showToast({ message: "下载失败❌，请查看日志" })
      }
    })
  }
}

interface DownloadResult {
  isSuccess: boolean,
  msg: string
}

async function httpDownload(imgUrl: string, imgType: string): Promise<DownloadResult> {
  return new Promise((resolve, reject) => {
    http.createHttp().request(imgUrl, async (error: BusinessError, data: http.HttpResponse) => { // 下载失败
      if (error) {
        return resolve({ isSuccess: false, msg: "下载失败" });
      } // 数据格式不正确
      if ((data.result instanceof ArrayBuffer) == false) {
        return resolve({ isSuccess: false, msg: "图片保存失败：数据流不支持" });
      } // 保存到Cache目录下
      let imageBuffer: ArrayBuffer = data.result as ArrayBuffer;
      const newFileName = util.generateRandomUUID() + "." + imgType;
      const newFilePath = getContext().cacheDir + "/" + newFileName;
      const newFileUri = fileUri.getUriFromPath(newFilePath);
      let file: fs.File = await fs.open(newFileUri, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
      await fs.write(file.fd, imageBuffer);
      await fs.close(file);
      console.info("文件路径：" + newFileUri); // 保存成功 // resultData.status = 3; // return resolve(resultData);
      saveImageToAsset(newFileUri, imgType).then(() => { // 保存成功
        return resolve({ isSuccess: true, msg: "保存成功" });
      }).catch((error: Error) => { // 保存失败
        return resolve({ isSuccess: false, msg: "保存失败:" + error.message });
      });
    });
  })
}

async function saveImageToAsset(uri: string, nameExtension: string): Promise<void> {
  console.info('ShowAssetsCreationDialogDemo: ' + uri);
  try {
    let phAccessHelper = photoAccessHelper.getPhotoAccessHelper(getContext()); // 获取需要保存到媒体库的位于应用沙箱的图片/视频uri
    let srcFileUris: Array<string> = [uri];
    let photoCreationConfigs: Array<photoAccessHelper.PhotoCreationConfig> = [{
      title: 'test2', // 可选
      fileNameExtension: nameExtension,
      photoType: photoAccessHelper.PhotoType.IMAGE, // 可选，支持：普通图片、动态图片
      subtype: photoAccessHelper.PhotoSubtype.DEFAULT,
    }];
    let desFileUris: Array<string> = await phAccessHelper.showAssetsCreationDialog(srcFileUris, photoCreationConfigs);
    console.info('showAssetsCreationDialog success, data is ' + desFileUris);
    if (desFileUris.length == 0) { // 用户拒绝保存
      throw (new Error("用户拒绝保存"))
    }
    await createAssetByIo(uri, desFileUris[0]);
    return Promise.resolve();
  } catch (err) {
    console.error('showAssetsCreationDialog failed, errCode is ' + err.code + ', errMsg is ' + err.message);
    return Promise.reject(err);
  }
}

let context = getContext(this);
const createAssetByIo = async (sourceFilePath: string, targetFilePath: string) => {
  try {
    console.log(`context.fileDir ===> ${context.filesDir}`)
    let srcFile: fs.File = fs.openSync(sourceFilePath, fs.OpenMode.READ_ONLY);
    let targetFile: fs.File = await fs.open(targetFilePath, fs.OpenMode.READ_WRITE);
    let bufSize = 14096;
    let readSize = 0;
    let buf = new ArrayBuffer(bufSize);
    let readOptions: ReadOptions = { offset: readSize, length: bufSize };
    let readLen = fs.readSync(srcFile.fd, buf, readOptions);
    while (readLen > 0) {
      readSize += readLen;
      fs.writeSync(targetFile.fd, buf, { length: readLen });
      readOptions.offset = readSize;
      readLen = fs.readSync(srcFile.fd, buf, readOptions);
    }
    fs.closeSync(srcFile);
    fs.closeSync(targetFile);
  } catch (error) {
    console.error(`createAssetByIo :: error , msg is ${error} `);
  }
}