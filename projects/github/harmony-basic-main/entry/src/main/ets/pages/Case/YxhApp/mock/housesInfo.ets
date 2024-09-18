export interface HousesInfo {
  imgUrl: ResourceStr
  name: string
  city: string
  area: string
  addr: string
  labelList: string[]
  goldStandard: string
  goldExplain: string
}

export class HousesInfoModel implements HousesInfo {
  imgUrl: ResourceStr = ''
  name: string = ''
  city: string = ''
  area: string = ''
  addr: string = ''
  labelList: string[] = []
  goldStandard: string = ''
  goldExplain: string = ''

  constructor(model: HousesInfo) {
    this.imgUrl = model.imgUrl
    this.name = model.name
    this.city = model.city
    this.area = model.area
    this.addr = model.addr
    this.labelList = model.labelList
    this.goldStandard = model.goldStandard
    this.goldExplain = model.goldExplain
  }
}

export const housesInfoList: HousesInfo[] = [
  {
    imgUrl: 'https://fangbao-oss.yuexiuproperty.cn/market_backend/backend/test/thumb/other/2024-05-09KTrZm6.jpeg',
    name: '越秀·万博城',
    city: '广州市',
    area: '番禺区',
    addr: '番禺大道北162号',
    labelList: ['中轴之上', '教育大盘', '公园环绕'],
    goldStandard: '推荐金标准：项目在售所有住宅：成交金额*0.5%元/套（税前）',
    goldExplain: '项目在售所有住宅：成交金额*0.5%元/套（税前）'
  }, {
  imgUrl: 'https://fangbao-oss.yuexiuproperty.cn/market_backend/backend/test/thumb/other/2024-03-11BWqwju.jpeg',
  name: '越秀·天悦云啟',
  city: '广州市',
  area: '南沙区',
  addr: '庆盛先行启动区·港科大（广州）南侧',
  labelList: ['品牌国企', '名校周边', '轨道商圈'],
  goldStandard: '推荐金标准：项目在售所有房源：成交金额*0.3%元/套（税前）',
  goldExplain: '项目在售所有房源：成交金额*0.3%元/套（税前）'
}, {
  imgUrl: 'https://fangbao-oss.yuexiuproperty.cn/market_backend/backend/test/thumb/other/2024-04-17mEKI7G.png',
  name: '越秀·观樾',
  city: '广州市',
  area: '天河区',
  addr: '广州市天河区悦景路与帝景西街交界处',
  labelList: ['繁华城区', '主城区', '生态宜居'],
  goldStandard: '推荐金标准：项目在售所有住宅：成交金额*0.8%元/套（税前）',
  goldExplain: '项目在售所有住宅：成交金额*0.8%元/套（税前）'
}, {
  imgUrl: 'https://fangbao-oss.yuexiuproperty.cn/market_backend/backend/test/thumb/other/2024-02-192JLkSS.jpeg',
  name: '越秀 | 滨江·樾',
  city: '广州市',
  area: '海珠区',
  addr: '滨江西路256号',
  labelList: ['中轴之上', '主城区', '滨水住宅'],
  goldStandard: '推荐金标准：项目在售所有住宅：150,000元/套（税前）',
  goldExplain: '项目在售所有住宅：150,000元/套（税前）'
}, {
  imgUrl: 'https://fangbao-oss.yuexiuproperty.cn/market_backend/backend/test/thumb/other/2024-04-17Wjhyap.jpeg',
  name: '越秀|琶洲·ONE57/琶洲·樾',
  city: '广州市',
  area: '海珠区',
  addr: '广州市海珠区新港东路176号',
  labelList: ['品牌国企', '近商圈'],
  goldStandard: '推荐金标准：琶洲ONE57(悦泽智库大厦)项目:30000元/套(税前)；琶洲樾(宁越府)项目暂不设推荐金。',
  goldExplain: '琶洲ONE57(悦泽智库大厦)项目:30000元/套(税前)；琶洲樾(宁越府)项目暂不设推荐金。'
}, {
  imgUrl: 'https://fangbao-oss.yuexiuproperty.cn/market_backend/backend/test/thumb/other/2024-01-11cenCAO.jpeg',
  name: '越秀·万博·瑞麓府',
  city: '广州市',
  area: '番禺区',
  addr: '越秀万博瑞麓府营销中心',
  labelList: ['品牌国企', '全龄教育', '高绿化率'],
  goldStandard: '推荐金标准：项目在售所有房源：成交金额*1%元/套（税前）',
  goldExplain: '项目在售所有房源：成交金额*1%元/套（税前）'
}, {
  imgUrl: 'https://fangbao-oss.yuexiuproperty.cn/market_backend/backend/test/thumb/other/2024-04-26rX5tty.jpeg',
  name: '越秀·滨海花城',
  city: '广州市',
  area: '南沙区',
  addr: '广州市南沙区黄阁南路旁',
  labelList: ['名校周边', '教育大盘', '全龄教育'],
  goldStandard: '推荐金标准：项目在售所有房源：成交金额*0.3%元/套（税前）',
  goldExplain: '项目在售所有房源：成交金额*0.3%元/套（税前）'
}, {
  imgUrl: 'https://fangbao-oss.yuexiuproperty.cn/market_backend/backend/test/thumb/other/2024-05-08pGFcfo.jpeg',
  name: '越秀·天悦云湖',
  city: '广州市',
  area: '白云区',
  addr: '地铁8号线亭岗站B出口旁',
  labelList: ['地铁上盖', '湖景房', '全明户型'],
  goldStandard: '推荐金标准：住宅：50,000元/套（税前）；商铺：10,000元/套（税前）',
  goldExplain: '住宅：50,000元/套（税前）；商铺：10,000元/套（税前）'
}
]