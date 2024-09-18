export interface TabTopItem {
  icon?: ResourceStr
  name?: string
  title: string
  selectIcon?: ResourceStr,
}

export interface TabItem {
  icon: ResourceStr
  name: string
  title: string
  selectIcon: ResourceStr,
  tabTopList?: Array<TabTopItem>
}

export interface ConnectItem {
  username: string
  avatar: string
  user_id: string
}