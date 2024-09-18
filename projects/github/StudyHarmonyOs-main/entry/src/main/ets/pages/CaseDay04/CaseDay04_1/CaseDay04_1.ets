import CommentItem from './components/CommentItem'
import NavBar from './components/NavBar'
import { ReplyItemModel, ReplyItem } from './models'
import Reply from './components/Reply'

@Entry
@Component
struct CaseDay04_1 {
  scroller: Scroller = new Scroller()
  @State currentComment: ReplyItemModel = new ReplyItemModel({
    id: 999,
    avatar: 'https://ww4.sinaimg.cn/mw690/dad5bf5dgy1hs885w13uwj20u016548a.jpg',
    author: '满山猴子我腚最红',
    time: '08-05',
    area: '北京',
    likeNum: 100,
    content: '巴黎奥运会男子游泳潘展乐同学突破欧美限制夺得100米自由泳金牌，并打破世界记录',
    likeFlag: false
  })
  // 回复列表
  @State CommentList: Array<ReplyItemModel> = [
    new ReplyItemModel({
      id: 1,
      avatar: 'https://picx.zhimg.com/027729d02bdf060e24973c3726fea9da_l.jpg?source=06d4cd63',
      author: '偏执狂-妄想家',
      content: '更何况还分到一个摩洛哥[惊喜]',
      time: '11-30',
      area: '海南',
      likeNum: 34,
      likeFlag: false
    }) ,
    new ReplyItemModel({
      id: 2,
      avatar: 'https://pic1.zhimg.com/v2-5a3f5190369ae59c12bee33abfe0c5cc_xl.jpg?source=32738c0c',
      author: 'William',
      content: '当年希腊可是把1：0发挥到极致了',
      time: '11-29',
      area: '北京',
      likeNum: 58,
      likeFlag: false
    }),
    new ReplyItemModel({
      id: 3,
      avatar: 'https://picx.zhimg.com/v2-e6f4605c16e4378572a96dad7eaaf2b0_l.jpg?source=06d4cd63',
      author: 'Andy Garcia',
      content: '欧洲杯其实16队球队打正赛已经差不多，24队打正赛意味着正赛阶段在小组赛一样有弱队。',
      time: '11-28',
      area: '上海',
      likeNum: 10,
      likeFlag: false
    }),
    new ReplyItemModel({
      id: 4,
      avatar: 'https://picx.zhimg.com/v2-53e7cf84228e26f419d924c2bf8d5d70_l.jpg?source=06d4cd63',
      author: '正宗好鱼头',
      content: '确实眼红啊，亚洲就没这种球队，让中国队刷',
      time: '11-27',
      area: '香港',
      likeNum: 139,
      likeFlag: false
    }),
    new ReplyItemModel({
      id: 5,
      avatar: 'https://pic1.zhimg.com/v2-eeddfaae049df2a407ff37540894c8ce_l.jpg?source=06d4cd63',
      author: '柱子哥',
      content: '我是支持扩大的，亚洲杯欧洲杯扩到32队，世界杯扩到64队才是好的，世界上有超过200支队伍，欧洲区55支队伍，亚洲区47支队伍，即使如此也就六成出现率',
      time: '11-27',
      area: '旧金山',
      likeNum: 29,
      likeFlag: false
    }),
    new ReplyItemModel({
      id: 6,
      avatar: 'https://picx.zhimg.com/v2-fab3da929232ae911e92bf8137d11f3a_l.jpg?source=06d4cd63',
      author: '飞轩逸',
      content: '禁止欧洲杯扩军之前，应该先禁止世界杯扩军，或者至少把亚洲名额一半给欧洲。',
      time: '11-26',
      area: '里约',
      likeNum: 100,
      likeFlag: false
    })
  ]

  // 热评喜欢
  topLike: () => void = () => {
    const likeFlag = this.currentComment.likeFlag
    if (likeFlag === false) {
      this.currentComment.likeNum++
    } else {
      this.currentComment.likeNum--
    }
    this.currentComment.likeFlag = !likeFlag
  }
  // 喜欢
  like: (item: ReplyItem, index: number) => void = (item: ReplyItem, index: number) => {
    const likeFlag = item.likeFlag
    if (likeFlag === false) {
      item.likeNum++
    } else {
      item.likeNum--
    }
    this.CommentList[index].likeFlag = !likeFlag
    this.CommentList[index] = new ReplyItemModel(item)
  }

  build() {
    Column() {
      NavBar({ title: '评论回复' })

      CommentItem({ item: this.currentComment, like: () => { this.topLike() } })
        .padding(20)

      Column() {
        Divider().strokeWidth(10)
        Text('评论数' + this.CommentList.length)
          .width('100%')
          .padding(20)
        Divider().strokeWidth(1)
      }

      List({ scroller: this.scroller }) {
        ForEach(this.CommentList, (item: ReplyItem, index: number) => {
          ListItem() {
            CommentItem({ item, like: () => { this.like(item, index) } })
              .padding({
                top: 20,
                right: 20,
                left: 20
              })
          }
        })
      }
      .width('100%')
      .height('100%')
      .layoutWeight(1)

      Reply({
        publishComment: (content: string) => {
          const comment = new ReplyItemModel({
            id: 0,
            avatar: 'https://i2.hdslb.com/bfs/face/67a6ad3458b4a8fc390b16b0bbc28e46f4f79ebb.jpg',
            author: '喜欢玩基金的小瑜哥',
            time: '09-03',
            area: '安徽',
            likeNum: 10000,
            content,
            likeFlag: false
          })
          this.CommentList.unshift(comment)
          this.scroller.scrollEdge(Edge.Top)
        }
      })
    }
    .height('100%')
    .width('100%')
  }
}