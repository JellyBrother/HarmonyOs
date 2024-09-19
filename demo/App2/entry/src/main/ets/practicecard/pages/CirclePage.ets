import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { cancelLike, getAllPost, like } from '../http/Api';
import { PostInfo } from '../model/PostInfo'
import { convertMillisecondsToTime } from '../utils/DateUtil';
import {StatItem} from './PracticePage'
import emitter from '@ohos.events.emitter';
@Entry
@Component
export struct CirclePage {
  @StorageProp('token') @Watch('onTokenChange') token: string = ''
  //@StorageLink('token') @Watch('onTokenChange') token: string = ''
  @State isLoading:boolean = false;
  scroller:Scroller = new Scroller()
  @State postInfoList:PostInfo[] = []
  page:number = 1;
  total:number = 0;
  @StorageLink('isFresh') @Watch('onWatchFresh') isFresh:boolean = false;

  // 获取打卡数据   默认获取第1页，每页10条数据
  async getPostInfoPage(){
    let response = await getAllPost(this.page,10)
    response.data.data.records.forEach(post => this.postInfoList.push(new PostInfo(post)))
    this.total = response.data.data.total
    this.page++
  }

  // 监视token的变化
  onTokenChange(){
    if (this.token) {
      this.getPostInfoPage()
    }else{
      this.postInfoList = []
      this.total = 0
      this.page = 1
    }
  }

  // 刷新函数
  async refresh(){
    this.isLoading = true
    this.postInfoList = [];
    this.total = 0;
    this.page = 1;
    await this.getPostInfoPage();
    this.isFresh = false
    setTimeout(()=>{
      this.isLoading = false
    }, Math.random() * 1000 + 800)
  }

  // 渲染之前获取数据
  aboutToAppear() {
    if (this.token) {
      this.getPostInfoPage()
    }
  }
  
  // 刷新后调用
  onWatchFresh(){
    if (this.isFresh) {
      this.refresh()
    }
  }

  build() {
    Column(){
      Text('英语打卡圈')
        .fontSize(18).fontColor(Color.Black).fontWeight(FontWeight.Medium)
      Divider()
        .backgroundColor(Color.Black)
        .margin({top:10,left:20,right:20})

      if (this.token){
        // 登录后的打卡列表
        if (this.isLoading) {
          this.loadingBuilder()
        }else {
          this.LoginBuilder()
        }
      }else{
        // 未登录
        this.unLoginBuilder()
      }
    }
    .width('100%').height('100%').padding({top:20})
  }
  
  //未登录显示组件
  @Builder unLoginBuilder(){
    Column({space:30}){
      Image($r('app.media.ic_star_red')).width(177).height(177)
      Text('未登录暂无数据').fontSize(16).fontColor('#999999')
      Button('去登录')
        .width(100).height(35).fontSize(16).fontColor(Color.White)
        .backgroundColor('#43C6A0')
        .onClick(()=>{
          router.pushUrl({url:'pages/LoginPage'})
        })
    }.width('100%').layoutWeight(1).justifyContent(FlexAlign.Center)
  }
  
  // 登录后显示的组件
  @Builder LoginBuilder(){
    Stack(){
      List({scroller:this.scroller}){
        ForEach(this.postInfoList,(post)=>{
          ListItem(){
            PostItem({post:post})
          }
        })
      }.width('100%')
      .height('100%')
      .alignListItem(ListItemAlign.Center)
      .onReachEnd(()=>{
        if (this.postInfoList.length < this.total) {
          this.getPostInfoPage()
        }else{
          promptAction.showToast({message:'拉满了~~'})
        }
      })

      // 返回顶部和刷新按钮
      Column({space:20}){
        // 返回顶部
        Button({type:ButtonType.Circle}){
          Image($r('app.media.ic_star_red')).height(14).width(14)
        }.height(40).width(40).backgroundColor(Color.Black).opacity(0.5)
        .onClick(()=>{
          console.log('返回顶部')
          // 返回顶部
          this.scroller.scrollToIndex(0)
        })

        // 刷新按钮
        Button({ type: ButtonType.Circle }) {
          Image($r('app.media.ic_star_red')).height(14).width(14)
        }.height(40).width(40).backgroundColor(Color.Black).opacity(0.5)
        .onClick(() => {
          // 刷新
          this.refresh()
        })
      }
      .offset({x:-20, y:-50})
    }.width('100%').layoutWeight(1).alignContent(Alignment.BottomEnd)
  }

  // 加载时组件
  @Builder loadingBuilder(){
    Column({ space: 15 }) {
      Image($r('app.media.ic_star_red'))
        .width(30)
        .height(30)
      Text('加载中...')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#7e8892')
    }.width('100%')
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct PostItem{
  @ObjectLink post:PostInfo;

  build(){
    // 用户信息展示
    Column({space:10}){
      Row({space:10}){
        Image(this.post.avatarUrl).width(40).height(40).borderRadius(20)
        Text(this.post.nickname).height(40).fontSize(14).fontWeight(FontWeight.Bold)
        Blank()
        Text(this.post.createTime).height(40)
          .fontSize(14).fontColor('#999999').fontWeight(FontWeight.Medium)
      }.width('100%')

      // 打卡语句展示
      Text(this.post.postText).width('100%')

      // 打卡信息展示
      Row(){
        Column(){
          // 准确率
          Row(){
            StatItem({
              icon:$r('app.media.ic_star_red'),
              name:'准确率',
              color:Color.White
            })
            Blank()

            Text((this.post.answeredCount === 0 ? 0 : this.post.rightCount/this.post.answeredCount*100).toFixed()+'%')
              .textStyle()
          }.width('85%')

          // 个数
          Row(){
            StatItem({
              icon:$r('app.media.ic_star_red'),
              name:'单词数',
              color:Color.White
            })
            Blank()

            Text(this.post.answeredCount.toString()+'个')
              .textStyle()
          }.width('85%')

          // 用时
          Row(){
            StatItem({
              icon:$r('app.media.ic_star_red'),
              name:'用时',
              color:Color.White
            })
            Blank()

            Text(convertMillisecondsToTime(this.post.timeUsed))
              .textStyle()
          }.width('85%')
        }
        .padding(10)
        .borderRadius(10)
        .layoutWeight(1)
        .backgroundImage($r('app.media.ic_star_red'))
        .backgroundImageSize(ImageSize.Cover)

        // 点赞按钮
        Column(){
          Text(this.post.likeCount.toString())
            .fontSize(14).fontWeight(FontWeight.Medium)
            .fontColor(this.post.isLike ? '#3ECBA1' : '#000000')

          Image(this.post.isLike ? $r('app.media.ic_star_red') : $r('app.media.ic_star_red'))
            .width(26).height(26)
            .onClick(()=>{
              // 取消点赞/点赞
              if (this.post.isLike) {
                // 取消点赞
                this.post.isLike = false
                this.post.likeCount--
                //需要在从Api.ets文件中导入cancelLike方法
                //调用cancelLike()方法，向后台发起取消点赞的请求
                cancelLike(this.post.id)
              }else{
                // 点赞
                this.post.isLike = true
                this.post.likeCount++
                //需要在从Api.ets文件中导入cancelLike方法
                //like()方法，向后台发起取消点赞的请求
                like(this.post.id)
              }
            })
        }.width(50)
      }.width('100%')
      .alignItems(VerticalAlign.Bottom)
    }
    .padding(10).width('90%').margin({top:10}).borderRadius(10).shadow({radius:20})
  }
}

@Extend(Text) function textStyle(){
  .width(100)
  .fontSize(16)
  .textAlign(TextAlign.End)
  .fontWeight(FontWeight.Medium)
  .fontColor(Color.White)
}
