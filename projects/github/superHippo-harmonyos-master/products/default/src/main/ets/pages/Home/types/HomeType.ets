export interface HomeNavListType {
  uri: Resource
  title: string
}


export interface UserOptionsType {
  title_en: string
  title_ch: string
  uri: Resource
  path?: string
}

export interface ProductTabsType {
  id: number
  title: string
  fir_floor?: string
  sec_floor?: string
}

export interface GoodsType {
  uri: Resource,
  goods_title: string,
  time: string,
  topic: string,
  price: string
  id: string | number
}