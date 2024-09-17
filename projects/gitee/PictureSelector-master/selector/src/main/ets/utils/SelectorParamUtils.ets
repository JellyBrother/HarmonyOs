import { MediaData } from '../model/MediaData'
import { ArrayList } from '@kit.ArkTS'
import { MediaDataParams } from '../model/MediaDataParams'

// 获取路由参数
export function getSelectorRouterParams(params: object): ArrayList<MediaData> | null {
  if (params) {
    let mediaDataParams: MediaDataParams = params['mediaDataParams']
    if (mediaDataParams) {
      let list = new ArrayList<MediaData>()
      let count = mediaDataParams.mediaDataListCount
      let mediaDataList = mediaDataParams.mediaDataList
      for (let i = 0; i < count; i++) {
        list.add(mediaDataList[i] as MediaData)
      }
      return list
    }
  }
  return null
}