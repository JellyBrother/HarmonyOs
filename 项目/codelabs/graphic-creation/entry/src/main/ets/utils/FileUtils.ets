/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import { image } from '@kit.ImageKit';
import fs from '@ohos.file.fs';
import { CommonConstants } from '../common/CommonConstants';
import Logger from './Logger';
import { photoAccessHelper } from '@kit.MediaLibraryKit';
import fileIo from '@ohos.file.fs';
import { BusinessError } from '@kit.BasicServicesKit';
import { fileUri } from '@kit.CoreFileKit';

export class FileUtils {
  static readonly tag: string = 'FileUtils';
  static readonly qualityValue: number = 98;
  static readonly formatValue: string = 'image/jpeg';
  static readonly extensionValue: string = 'jpg';
  static options: image.DecodingOptions = {
    index: 0,
    editable: false,
    desiredPixelFormat: image.PixelMapFormat.RGBA_8888,
  };

  /**
   * send picture to cloud
   *
   * @param context
   * @param uriArr
   */
  static sendCloudFile(context: Context, uriArr: string[]) {
    uriArr.forEach((uri: string) => {
      FileUtils.copyToDistributedDir(context, uri);
    });
  }

  /**
   * Copy file to distributedDir, the camera media address needs to be read and written.
   *
   * @param context
   * @param uri
   */
  static copyToDistributedDir(context: Context, uri: string) {
    try {
      Logger.info(FileUtils.tag, 'copyToDistributedDir path = ' + uri);
      let buf = new ArrayBuffer(CommonConstants.FILE_BUFFER_SIZE);
      let readSize = 0;
      let file = fileIo.openSync(uri, fileIo.OpenMode.READ_ONLY);
      let readLen = fileIo.readSync(file.fd, buf, { offset: readSize });
      let fileName = file.name;
      let destinationDistribute = fileIo.openSync(`${context.distributedFilesDir}/${fileName}`,
        fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.CREATE);
      while (readLen > 0) {
        readSize += readLen;
        fileIo.writeSync(destinationDistribute.fd, buf);
        readLen = fileIo.readSync(file.fd, buf, { offset: readSize });
      }
      Logger.info(FileUtils.tag, 'copyToDistributedDir destinationDistribute = ' + destinationDistribute.path);
      fileIo.closeSync(file);
      fileIo.closeSync(destinationDistribute);
    } catch (err) {
      Logger.error(FileUtils.tag, `copyToDistributedDir failed. Code: ${err.code}, message: ${err.message}`);
    }
  }

  static addAllFiles(uriArr: string[]) {
    let nameArr = AppStorage.get(CommonConstants.KEY_PICTURE_PATHS) as string[];
    if (nameArr === undefined) {
      nameArr = [];
    }
    nameArr.length = 0;
    uriArr.forEach((uri: string) => {
      let fileUriObject = new fileUri.FileUri(uri);
      nameArr.push(fileUriObject.name);
    });
    AppStorage.setOrCreate(CommonConstants.KEY_PICTURE_PATHS, nameArr);
  }

  static unshiftFiles(uri: string) {
    let nameArr = AppStorage.get(CommonConstants.KEY_PICTURE_PATHS) as string[];
    if (nameArr === undefined) {
      nameArr = [];
    }
    let fileUriObject = new fileUri.FileUri(uri);
    nameArr.unshift(fileUriObject.name);
    AppStorage.setOrCreate(CommonConstants.KEY_PICTURE_PATHS, nameArr);
  }

  static deleteFiles(index: number) {
    let nameArr = AppStorage.get(CommonConstants.KEY_PICTURE_PATHS) as string[];
    if (nameArr === undefined) {
      nameArr = [];
    }
    nameArr.splice(index, 1);
    AppStorage.setOrCreate(CommonConstants.KEY_PICTURE_PATHS, nameArr);
  }

  static getCloudFile(context: Context, callback: Function) {
    let nameArr = AppStorage.get(CommonConstants.KEY_PICTURE_PATHS) as string[];
    if (nameArr === undefined) {
      nameArr = [];
    }
    if (nameArr.length === 0) {
      callback();
    } else {
      FileUtils.copyToFilesDir(context, nameArr, 0, () => {
        let filesDir: string = context.filesDir;
        let uriArr: string[] = [];
        nameArr.forEach((fileName: string) => {
          let destUri: string = fileUri.getUriFromPath(filesDir + `/${fileName}`);
          uriArr.push(destUri);
        })
        callback(uriArr);
      });
    }
  }

  private static copyToFilesDir(context: Context, nameArr: string[], state: number, callback: Function) {
    if (state === nameArr.length) {
      return;
    }
    let fileName = nameArr[state];
    let filesDir: string = context.filesDir;
    let distributedFilesDir: string = context.distributedFilesDir;
    let srcUri: string = fileUri.getUriFromPath(distributedFilesDir + `/${fileName}`);
    let destUri: string = fileUri.getUriFromPath(filesDir + `/${fileName}`);

    let options: fs.CopyOptions = {
      "progressListener": (progress: fs.Progress) => {
        if (progress.processedSize === progress.totalSize) {
          Logger.info(FileUtils.tag, 'copyToFilesDir success copied!');
          FileUtils.handleNextCopy(context, nameArr, state, callback);
        }
      }
    }
    try {
      fs.copy(srcUri, destUri, options).then(() => {
        Logger.info(FileUtils.tag, 'copyToFilesDir success copying!');
      }).catch((error: BusinessError) => {
        let err: BusinessError = error as BusinessError;
        Logger.error(FileUtils.tag, `copyToFilesDir failed to copy. Code: ${err.code}, message: ${err.message}`);
        FileUtils.handleNextCopy(context, nameArr, state, callback);
      });
    } catch (err) {
      Logger.error(FileUtils.tag, `copyToFilesDir failed to copy. Code: ${err.code}, message: ${err.message}`);
      FileUtils.handleNextCopy(context, nameArr, state, callback);
    }
  }

  private static handleNextCopy(context: Context, nameArr: string[], state: number, callback: Function) {
    if (state === nameArr.length - 1) {
      callback();
    } else {
      let next = state + 1;
      FileUtils.copyToFilesDir(context, nameArr, next, callback);
    }
  }

  /**
   * create PixelMap
   * @param uri file uri
   * @returns pixelMap
   */
  static async createPixelMapFromUri(uri: string): Promise<PixelMap | undefined> {
    if (uri === '') {
      return undefined;
    }
    let pixelMap: PixelMap | undefined;
    try {
      let file = fs.openSync(uri, fs.OpenMode.READ_ONLY);
      let imageResource = image.createImageSource(file.fd);
      pixelMap = imageResource.createPixelMapSync(FileUtils.options);
      fs.closeSync(file);
    } catch (error) {
      Logger.error(FileUtils.tag, `createPixelMapFromUri error: ${JSON.stringify(error)}`);
    }
    return pixelMap;
  }

  static async createPixelMap(buffer: ArrayBuffer): Promise<PixelMap | undefined> {
    let pixelMap: PixelMap | undefined;
    try {
      let imageResource = image.createImageSource(buffer);
      pixelMap = imageResource.createPixelMapSync(FileUtils.options);
    } catch (error) {
      Logger.error(FileUtils.tag, `createPixelMap error: ${JSON.stringify(error)}`);
    }
    return pixelMap;
  }

  static async savePicture(buffer: ArrayBuffer): Promise<string> {
    let options: photoAccessHelper.CreateOptions = {
      title: Date.now().toString()
    };
    let accessHelper: photoAccessHelper.PhotoAccessHelper = photoAccessHelper.getPhotoAccessHelper(getContext());
    let photoUri: string =
      await accessHelper.createAsset(photoAccessHelper.PhotoType.IMAGE, FileUtils.extensionValue, options);
    let file: fileIo.File = fileIo.openSync(photoUri, fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.CREATE);
    await fileIo.write(file.fd, buffer);
    fileIo.closeSync(file);
    Logger.debug(FileUtils.tag, `savePicture uri: ${photoUri}}`);
    return photoUri;
  }

  static async saveFile(context: Context, buffer: ArrayBuffer): Promise<string> {
    let filesDir: string = context.filesDir;
    let photoUri: string = fileUri.getUriFromPath(filesDir + `/${Date.now().toString()}.${FileUtils.extensionValue}`);
    let file: fileIo.File = fileIo.openSync(photoUri, fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.CREATE);
    await fileIo.write(file.fd, buffer);
    Logger.debug(FileUtils.tag, `saveFile uri: ${photoUri}}`);
    fileIo.closeSync(file);
    return photoUri;
  }
}