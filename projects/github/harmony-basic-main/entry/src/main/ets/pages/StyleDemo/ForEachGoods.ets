import { GoodItem } from './models'
import { SegmentButton, SegmentButtonOptions } from '@ohos.arkui.advanced.SegmentButton'

@Entry
@Component
struct ForEachGoods {
  @State tabOptions: SegmentButtonOptions = SegmentButtonOptions.tab({
    buttons: [{ text: '单列' }, { text: '双列' }],
  })
  @State tabSelectedIndexes: number[] = [1]
  @State list: GoodItem[] = [
    {
      "id": 1,
      "goods_name": "班俏BANQIAO超火ins潮卫衣女士2020秋季新款韩版宽松慵懒风薄款外套带帽上衣",
      "goods_img": "assets/image/goods/1.webp",
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
      "goods_img": "assets/image/goods/3.webp",
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
      "goods_name": "幂凝假两件女士卫衣秋冬女装2020年新款韩版宽松春秋季薄款ins潮外套",
      "goods_img": "assets/image/goods/7.webp",
      "goods_price": 219,
      "goods_count": 2,
    },
    {
      "id": 8,
      "goods_name": "依魅人2020休闲运动衣套装女秋季新款秋季韩版宽松卫衣 时尚两件套",
      "goods_img": "assets/image/goods/8.webp",
      "goods_price": 178,
      "goods_count": 1,
    },
    {
      "id": 9,
      "goods_name": "芷臻(zhizhen)加厚卫衣2020春秋季女长袖韩版宽松短款加绒春秋装连帽开衫外套冬",
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

  build() {
    Column({ space: 20 }) {
      SegmentButton({ options: this.tabOptions, selectedIndexes: $tabSelectedIndexes })
        .margin({
          left: 20,
          right: 20,
        })


      if (this.tabSelectedIndexes.includes(1)) {
        Grid() {
          ForEach(
            this.list,
            (item: GoodItem) => {
              GridItem() {
                Column({ space: 5 }) {
                  Image(item.goods_img)
                    .height(160)
                    .borderRadius(8)
                  Row({ space: 5 }) {
                    Text('￥' + item.goods_price)
                      .fontColor(Color.Red)
                      .fontWeight(900)
                    Text(item.goods_name)
                      .maxLines(1)
                      .fontWeight(900)
                      .layoutWeight(1)
                  }
                }
              }
            }
          )
        }
        .rowsGap(20)
        .columnsGap(20)
        .columnsTemplate('1fr 1fr')
        .layoutWeight(1)
        .padding({
          left: 20,
          right: 20,
        })

      } else if (this.tabSelectedIndexes.includes(0)) {
        List({ space: 20 }) {
          ForEach(
            this.list,
            (item: GoodItem) => {
              ListItem() {
                Row({ space: 20 }) {
                  Image(item.goods_img)
                    .width(110)
                    .height(160)
                    .borderRadius(8)
                  Column() {
                    Text(item.goods_name)
                      .fontWeight(900)
                      .maxLines(3)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                    Text('￥' + item.goods_price)
                      .fontColor(Color.Red)
                      .fontWeight(900)
                  }
                  .layoutWeight(1)
                  .height(160)
                  .justifyContent(FlexAlign.SpaceBetween)
                  .alignItems(HorizontalAlign.Start)
                }
              }
            }
          )
        }
        .layoutWeight(1)
        .padding({
          left: 20,
          right: 20,
        })
      }
    }
    .padding({
      top: 20,
      bottom: 20,
    })
  }
}