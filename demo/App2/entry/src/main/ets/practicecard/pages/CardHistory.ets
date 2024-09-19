import { cancelLike, getAllPost, getMyPost, like } from '../http/Api';
import { PostInfo } from '../model/PostInfo'
import router from '@ohos.router';
import HeadImg from './components/Self/HeadImg';
import { convertMillisecondsToTime } from '../utils/DateUtil';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct CardHistory {
  @State postInfoList:PostInfo[] = []
  @StorageLink('phone') phone: string = '';

  page:number = 1;
  total:number = 0;
  scroller: Scroller = new Scroller();

  async getPostInfoPage(page:number){
    let response = await getMyPost(page, 10)
    response.data.data.records.forEach(post => {
      // if(post.nickname === this.phone) {
        this.postInfoList.push(new PostInfo(post))
      // }
    })
    this.total = response.data.data.total
    this.page++
  }

  onPageShow(){
    this.postInfoList = []
    this.total = 0
    this.page = 1
    this.getPostInfoPage(this.page)
  }

  // aboutToAppear() {
  //   this.getPostInfoPage(this.page);
  // }

  build() {
    Flex({
      direction: FlexDirection.Column,
      justifyContent: FlexAlign.Start,
      alignItems: ItemAlign.Center
    }) {
      Row() {
        Image($rawfile('back.png'))
          .width('100px')
          .height('100px')
          .margin({ left: '50px' })
          .onClick(() => {
            router.back()
          })
        Text('打卡记录')
          .width('400px')
          .fontSize(20)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Medium)
          .position({ x: '50%', y: '50%' })
          .translate({ x: '-25%', y: '-50%' })
      }
      .width('100%')
      .height('160px')
      .border({ color: '#ac0dfa', style: BorderStyle.Solid, width: '5px' })

      Divider()
        .backgroundColor(Color.Black)

      if (this.postInfoList.length <= 0) {
        Flex({
          justifyContent: FlexAlign.Center,
          alignItems: ItemAlign.Center
        }) {
          Text('暂无打卡记录') {
          }
        }
        .width('100%')
        .height('400px')
      }
      else {
        List({
          space: '20px',
          scroller: this.scroller
        }) {
          ForEach(this.postInfoList, (post) => {
            ListItem() {
              Flex({
                justifyContent: FlexAlign.Center,
                alignItems: ItemAlign.Center
              }) {
                CardItem({ itemData: post })
              }.width('100%')
            }.width('100%')

          })
        }.width('100%').height('100%')
        .onReachEnd(()=>{
          if (this.postInfoList.length < this.total) {
            this.getPostInfoPage(this.page)
          }else{
            promptAction.showToast({message:'拉满了~~'})
          }
        })
      }
    }
  }
}

@Component
struct CardItem {
  @ObjectLink itemData: PostInfo;

  build() {
    Row(){
      Flex({
        direction: FlexDirection.Column,
        justifyContent: FlexAlign.SpaceAround,
        alignItems: ItemAlign.Start
      }) {
        Text(this.itemData.createTime)
        Row() {
          // @ts-ignore
          Text(`单词数: ${this.itemData.answeredCount.toString()}`)
            .margin({right: '25px'})
          Text(`准确率: ${(this.itemData.answeredCount === 0 ? 0 : this.itemData.rightCount / this.itemData.answeredCount * 100).toFixed()}%`)
        }
        Text(`用时: ${convertMillisecondsToTime(this.itemData.timeUsed)}`)

      }
      .width('70%')
      Stack() {
        Image($rawfile('schedule.png'))
          .width('180px')
          .height('180px')
        Text(this.itemData.createTime.split(' ')[0].split('-')[2].toString())
          .fontWeight(900)
      }
      .offset({x: '60px'})
    }
    .width('90%')
    .height('300px')
    .border({width: '4px', style: BorderStyle.Solid, color: '#000'})
    .margin({top: '20px', bottom: '20px'})
    .padding({top: '10px', bottom:'10px', left: '20px', right: '20px'})
    .borderRadius('24px')
    .shadow({offsetX: 5, offsetY: 5, color: '#999', radius: 12})
  }
}
