import { GoodItem } from './models'
import { promptAction } from '@kit.ArkUI'

@Entry
@Component
struct WaterFlowDemo {
  @State loading: boolean = false
  @State list: GoodItem[] = [
    {
      "id": 1,
      "goods_name": "思蜜怡2020休闲运动套装女春秋季新款时尚大码宽松长袖卫衣两件套潮卫衣女士款宽松带帽上衣",
      "goods_img": "assets/image/goods/3.webp",
      "goods_price": 108,
      "goods_count": 1,
    },
    {
      "id": 2,
      "goods_name": "嘉叶希连帽卫衣女春秋薄款2020新款宽松bf韩版字母印花中长款外套ins潮",
      "goods_img": "assets/image/goods/2.webp",
      "goods_price": 129,
      "goods_count": 1,
    },
    {
      "id": 3,
      "goods_name": "思蜜怡2020休闲运动套装女春秋季新款时尚大码宽松长袖卫衣两件套",
      "goods_img": "assets/image/goods/1.webp",
      "goods_price": 198,
      "goods_count": 1,
    },
    {
      "id": 4,
      "goods_name": "思蜜怡卫衣女加绒加厚2020秋冬装新款韩版宽松上衣连帽中长款外套",
      "goods_img": "assets/image/goods/4.webp",
      "goods_price": 99,
      "goods_count": 1,
    },
    {
      "id": 5,
      "goods_name": "幂凝早秋季卫衣女春秋装韩版宽松中长款假两件上衣薄款ins盐系外套潮",
      "goods_img": "assets/image/goods/5.webp",
      "goods_price": 156,
      "goods_count": 1,
    },
    {
      "id": 6,
      "goods_name": "ME&CITY女装冬季新款针织抽绳休闲连帽卫衣女",
      "goods_img": "assets/image/goods/6.webp",
      "goods_price": 142.8,
      "goods_count": 1,
    },
    {
      "id": 7,
      "goods_name": "幂凝假两件女士卫衣秋冬女装2020年新款韩版宽松",
      "goods_img": "assets/image/goods/7.webp",
      "goods_price": 219,
      "goods_count": 2,
    },
    {
      "id": 8,
      "goods_name": "依魅人2020休闲运动衣套装女秋季新款秋季韩版宽松卫衣大码宽松长袖卫衣两件套时尚两件套",
      "goods_img": "assets/image/goods/8.webp",
      "goods_price": 178,
      "goods_count": 1,
    },
    {
      "id": 9,
      "goods_name": "芷臻(zhizhen)加厚卫衣2020春秋季女长袖韩版宽松短款加绒春秋装连帽开",
      "goods_img": "assets/image/goods/9.webp",
      "goods_price": 128,
      "goods_count": 1,
    },
    {
      "id": 10,
      "goods_name": "Semir森马卫衣女冬装2019新款可爱甜美大撞色小清新连帽薄绒女士套头衫",
      "goods_img": "assets/image/goods/10.webp",
      "goods_price": 153,
      "goods_count": 1,
    }
  ]

  @Builder
  getFlowItem(item: GoodItem, index: number) {
    Column({ space: 8 }) {
      Image(item.goods_img)
        .borderRadius(8)
      Text(item.goods_name)
        .lineHeight(24)
        .fontWeight(900)
    }
  }

  @Builder
  getFooter() {
    Column() {
      LoadingProgress()
        .width(40)
      Text('加载中')
    }
    .width('100%')
  }

  getMore() {
    return new Promise<boolean>((resolve, reject) => {
      setTimeout(() => {
        this.list.push(...this.list.slice(0, 9))
        resolve(true)
      }, 1000)
    })
  }

  build() {
    WaterFlow({ footer: this.getFooter() }) {
      ForEach(this.list, (item: GoodItem, index: number) => {
        FlowItem() {
          this.getFlowItem(item, index)
        }
      })
    }
    .onReachEnd(() => {
      if (!this.loading) {
        try {
          this.loading = true
          this.getMore()
        } catch (error) {
          console.log(error)
        } finally {
          this.loading = false
        }
      }
    })
    .columnsTemplate('1fr 1fr')
    .padding(20)
    .columnsGap(20)
    .rowsGap(20)
  }
}