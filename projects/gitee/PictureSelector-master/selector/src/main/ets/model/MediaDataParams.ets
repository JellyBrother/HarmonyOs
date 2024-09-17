/**
 * 媒体文件参数
 * @Author sea
 * @Date 2024/7/8
 */
export class MediaDataParams {
  mediaDataList: object
  mediaDataListCount:number
  constructor(mediaDataList: object,mediaDataListCount:number) {
    this.mediaDataList = mediaDataList
    this.mediaDataListCount = mediaDataListCount
  }
}