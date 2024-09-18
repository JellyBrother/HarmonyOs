
import { HomeNavListType, UserOptionsType, ProductTabsType, GoodsType } from '../types/HomeType'
export default class HomeCommonData {


  static readonly home_nav_list: Array<HomeNavListType> = [
    {
      uri: $r('app.media.home_map_icon'),
      title: '地图'
    },
    {
      uri: $r('app.media.home_active_icon'),
      title: '活动'
    },
    {
      uri: $r('app.media.home_book_icon'),
      title: '预定'
    },
    {
      uri: $r('app.media.home_staff_icon'),
      title: '客服'
    },
  ]


  static readonly User_option_list: Array<UserOptionsType> = [
    {
      uri: $r('app.media.home_select'),
      title_en: 'Table Booking',
      title_ch: '在线订卡',
    },
    {
      uri: $r('app.media.home_select'),
      title_en: 'Take a Drink',
      title_ch: '约酒组局'
    },
  ]

  static readonly Home_calendar_list: Array<UserOptionsType> = [
    {
      uri: $r('app.media.home_calendar'),
      title_en: 'Events Calendar',
      title_ch: '品牌活动日历',
    },
  ]

  /**
   * 首页产品筛选tab
   */

  static readonly product_tabs_list: Array<ProductTabsType> = [
    {
      title: '全部',
      id: 1
    },
    {
      title: '兔子洞',
      fir_floor: 'B1',
      sec_floor: 'LG',
      id: 2
    },
    {
      title: '漫步',
      fir_floor: 'G',
      id: 3
    },
    {
      title: '人间',
      fir_floor: 'L1',
      sec_floor: 'L2',
      id: 4
    },
    {
      title: '极乐',
      fir_floor: 'L3',
      sec_floor: 'L4',
      id: 5
    },
    {
      title: '仙境',
      fir_floor: 'L5',
      sec_floor: 'L6',
      id: 6
    }
  ]


  static readonly goodsList: Array<GoodsType> = [
    {
      uri: $r('app.media.goods1'),
      goods_title: '四周年店庆DJ LOVE 音乐现场@Culture Club',
      time: '2024.7.10-2024.8.10',
      topic: '#兔子洞',
      price: '1000',
      id: 1
    },
    {
      uri: $r('app.media.goods2'),
      goods_title: '四周年店庆DJ LOVE 音乐现场@Culture Club',
      time: '2024.7.10-2024.8.10',
      topic: '#兔子洞',
      price: '1000',
      id: 2
    },
    {
      uri: $r('app.media.goods3'),
      goods_title: '四周年店庆DJ LOVE 音乐现场@Culture Club',
      time: '2024.7.10-2024.8.10',
      topic: '#兔子洞',
      price: '1000',
      id: 3

    },
  ]
}
