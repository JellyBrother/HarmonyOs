interface JobRole {
  company: string
  salary: number
  details: string
  timeQuantum: string
}

interface GoodItem {
  goods_name: string
  goods_price: number
  goods_img: string
  goods_count: number
  id: number
}

interface BtnType {
  label: string
  code: string
  color?: Color | string
  autoClose?: boolean
  callback: (type: string) => void
}

interface OptionsType {
  title: string,
  btnList: BtnType[]
}

export {
  JobRole, GoodItem, BtnType, OptionsType, }