interface IHomeAd {
  data: HomeAdItemModel[]
  success: boolean
}

export class HomeAdModel {
  data: HomeAdItemModel[] = []
  success: boolean = true

  constructor(data: HomeAdItemModel[], success: boolean) {
    this.data = data
    this.success = success
  }
}

export class HomeAdItemModel {
  approveTime?: number
  approver?: string
  areaType?: string
  configType?: string
  copeName?: string
  endTime?: number
  id?: number
  imgUrl?: ResourceStr
  isShow?: number
  jumpUrl?: string
  lock?: number
  name?: string
  page?: string
  position?: string
  seq?: number
  startTime?: number
  status?: number
  submitTime?: number
  submitter?: string
  unNeedLogin?: boolean

  constructor(approveTime: number, approver: string, areaType: string, configType: string, copeName: string, endTime: number, id: number, imgUrl: ResourceStr, isShow: number, jumpUrl: string, lock: number, name: string, page: string, position: string, seq: number, startTime: number, status: number, submitTime: number, submitter: string, unNeedLogin: boolean) {
    this.approveTime = approveTime
    this.approver = approver
    this.areaType = areaType
    this.configType = configType
    this.copeName = copeName
    this.endTime = endTime
    this.id = id
    this.imgUrl = imgUrl
    this.isShow = isShow
    this.jumpUrl = jumpUrl
    this.lock = lock
    this.name = name
    this.page = page
    this.position = position
    this.seq = seq
    this.startTime = startTime
    this.status = status
    this.submitTime = submitTime
    this.submitter = submitter
    this.unNeedLogin = unNeedLogin
  }
}

export const homeAdData: HomeAdModel = new HomeAdModel(
  [
  // new HomeAdItemModel(1669103537000, "appaccount", "ALL", "SYBN", "全国", 1675094400000, 467003, "https://enjoy-club-app-cdn-test.yuexiuproperty.cn/540a1a554b0045e2be1de4bd4c0acd69.jpg", 1, "/miniprogram/gh_64d70f10174e/wx?path=/pages/pageNgine/wPage?pageId=1321546168757662724", 2, "煌上煌", "HOMEPAGE", "TOP", 0, 1669103554000, 4, 1717248862000, "appaccount", true),
  // new HomeAdItemModel(1669080080000, "appaccount", "ALL", "SYBN", "全国", 1669737600000, 466973, "https://enjoy-club-app-cdn-test.yuexiuproperty.cn/6f487a6e181145f9837db7c5bbf54127.jpg", 1, "https://ymall-admin-uat.yuexiuproperty.cn/preview.html?id=K03XqSfF", 2, "11-22", "HOMEPAGE", "TOP", 2, 1669080121000, 4, 1717248862000, "appaccount", true),
  // new HomeAdItemModel(1669737600000, "appaccount", "ALL", "SYBN", "全国", 1669737600000, 466973, "https://enjoy-club-app-cdn-test.yuexiuproperty.cn/7d2845d3a76446098f88f1128e187a9f.jpg", 1, "https://enjoy-club-uat.yuexiuproperty.cn/PrimaryBroker/recommendH5", 2, "积分不变", "HOMEPAGE", "TOP", 3, 1669103472000, 1, 1717248862000, "appaccount", true)
    new HomeAdItemModel(1669103537000, "appaccount", "ALL", "SYBN", "全国", 1675094400000, 467003, $r('app.media.ic_yxh_banana_a'), 1, "/miniprogram/gh_64d70f10174e/wx?path=/pages/pageNgine/wPage?pageId=1321546168757662724", 2, "煌上煌", "HOMEPAGE", "TOP", 0, 1669103554000, 4, 1717248862000, "appaccount", true),
    new HomeAdItemModel(1669080080000, "appaccount", "ALL", "SYBN", "全国", 1669737600000, 466973, $r('app.media.ic_yxh_banana_b'), 1, "https://ymall-admin-uat.yuexiuproperty.cn/preview.html?id=K03XqSfF", 2, "11-22", "HOMEPAGE", "TOP", 2, 1669080121000, 4, 1717248862000, "appaccount", true),
    new HomeAdItemModel(1669737600000, "appaccount", "ALL", "SYBN", "全国", 1669737600000, 466973, $r('app.media.ic_yxh_banana_c'), 1, "https://enjoy-club-uat.yuexiuproperty.cn/PrimaryBroker/recommendH5", 2, "积分不变", "HOMEPAGE", "TOP", 3, 1669103472000, 1, 1717248862000, "appaccount", true)
  ],
  true
)

