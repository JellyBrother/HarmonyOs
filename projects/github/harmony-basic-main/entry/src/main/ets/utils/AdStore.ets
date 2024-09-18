import { preferences } from '@kit.ArkData'

/**
 * 广告类
 */
export class AdvertModel {
  /** 显示广告 */
  showAd: boolean = false
  /** 广告时长 */
  adTime: number = 5
  /** 广告链接 */
  adUrl?: string
  /** 广告图片 */
  adImg?: ResourceStr
}

/** 广告仓库key */
export const AD_STORE_KEY = 'ad_store_key'

/** 启动广告key */
export const START_AD_KEY = 'start_ad_key'

/** 打开子窗口key */
export const OPEN_SUB_WINDOW_KEY = 'open_sub_window_key'

/** 默认广告 */
export const DEFAULT_AD: AdvertModel = {
  showAd: false,
  adTime: 5,
  adImg: $r("app.media.start"),
}

/** 广告仓库 */
export class AdStore {
  context: Context

  constructor(ctx: Context) {
    this.context = ctx
  }

  /**
   * 获取AD仓库
   * @returns
   */
  getStore() {
    return preferences.getPreferencesSync(this.context, { name: AD_STORE_KEY })
  }

  /**
   * 设置启动广告
   * @param ad
   */
  async setStartAd(ad: AdvertModel) {
    const store = this.getStore()
    store.putSync(START_AD_KEY, JSON.stringify(ad))
    await store.flush()
  }

  /**
   * 获取启动广告
   * @returns
   */
  getStartAd() {
    const store = this.getStore()
    return JSON.parse(store.getSync(START_AD_KEY, JSON.stringify(DEFAULT_AD)) as string) as AdvertModel
  }
}

/**
 * 模似接口获取广告数据
 * @returns
 */
export function getStartAd() {
  return new Promise<AdvertModel>((resolve, reject) => {
    // DEFAULT_AD.adTime = 2
    const ad = JSON.parse(JSON.stringify(DEFAULT_AD) as string) as AdvertModel
    ad.adTime = 1
    setTimeout(() => {
      resolve(ad)
    }, 500)
  })
}