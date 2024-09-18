import NavBar from './components/NavBar'
import { ConnectItem, TabItem } from './models'

class Tem {
  item: TabItem = {} as TabItem
  index: number = 0
}

class TemMessage {
  username: string = ''
  avatar: string = ''
  message: string = ''
  date: string = ''
}

@Entry
@Component
struct CaseDay04_2 {
  TabList: Array<TabItem> = [
    {
      icon: '/pages/CaseDay04/CaseDay04_2/images/ic_public_message.svg',
      name: 'wechat',
      title: '微信',
      selectIcon: '/pages/CaseDay04/CaseDay04_2/images/ic_public_message_filled.svg'
    },
    {
      icon: '/pages/CaseDay04/CaseDay04_2/images/ic_public_contacts_group.svg',
      name: 'connect',
      title: '联系人',
      selectIcon: '/pages/CaseDay04/CaseDay04_2/images/ic_public_contacts_group_filled.svg'
    },
    {
      icon: '/pages/CaseDay04/CaseDay04_2/images/ic_gallery_discover.svg',
      name: 'discover',
      title: '发现',
      selectIcon: '/pages/CaseDay04/CaseDay04_2/images/ic_gallery_discover_filled.svg'
    },
    {
      icon: '/pages/CaseDay04/CaseDay04_2/images/ic_public_contacts.svg',
      name: 'my',
      title: '我的',
      selectIcon: '/pages/CaseDay04/CaseDay04_2/images/ic_public_contacts_filled.svg'
    }
  ]
  ConnectList: Array<ConnectItem> = [
    {
      username: '小趴菜',
      avatar: 'https://img2.baidu.com/it/u=2778471297,524433918&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
      user_id: '1'
    },
    {
      username: '老板',
      avatar: 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F9853de1a-3985-42e6-be59-849853318793%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1708069489&t=f960a72e50a399ddec92b18b3c7fc2d9',
      user_id: '2'
    },
    {
      username: '老婆',
      avatar: 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2Fd064be90-6b8c-4a6d-9721-837206fbb4a7%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1708069489&t=c810057a56c27b5747e1e92bfde37799',
      user_id: '3'
    },
    {
      username: '物业小张',
      avatar: 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2Fabf9e746-a09c-4b08-bcba-1e347a370226%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1708069489&t=b47c00cad15f8dbdc390e82b95348ed2',
      user_id: '4'
    },
    {
      username: '水若寒宇',
      avatar: 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2Ff1d11ab1-35ff-4f2c-b9e9-3e0c996d34a2%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1708069489&t=e3234db982e8a36639d170fc5cec7848',
      user_id: '5'
    },
    {
      username: '小林',
      avatar: 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2Fe9543d7c-02f3-484f-a3f0-5bfa8b2e6ef9%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1708069502&t=118303a29ce4a8ef2c1a496ae880b76b',
      user_id: '6'
    },
    {
      username: '花开富贵',
      avatar: 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F8d90d041-784a-407f-a82e-b851fafdf746%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1708069547&t=d374ebb6973f68b95ba345827a304455',
      user_id: '7'
    },
    {
      username: '妈妈',
      avatar: 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F373c6d24-1f8b-4000-8dd9-8d8410c35e71%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1708069618&t=51805a82420593c2a3cda47b9f65a80e',
      user_id: '8'
    },
    {
      username: '沧海一生笑',
      avatar: 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2Fbb560b27-a0b7-4062-ae40-efe4e5a8a748%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1708069619&t=8605f8477712cf9c5a1159db0cd7dab4',
      user_id: '9'
    },
    {
      username: '爱哭的燕子🐨🐨',
      avatar: 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2Fdc2617f6-4a68-4d4a-8c54-8cbc84e3446a%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1708069619&t=a8b7b4f1e600d53e5547479d947b1809',
      user_id: '10'
    }
  ]
  @State
  MessageList: Array<TemMessage> = this.ConnectList.slice(0, 3).map((item) => {
    const tem: TemMessage = {
      username: item.username,
      avatar: item.avatar,
      message: '我想你了',
      date: '14:00'
    }
    return tem
  })
  @State index: number = 0
  @Builder
  TabBuilder(params: Tem) {
    Column({ space: 5 }) {
      if (params.index === this.index) {
        Image(params.item.selectIcon)
          .width(20)
          .syncLoad(true)
        Text(params.item.title)
          .fontSize(14)
          .fontColor('#3faf04')
      } else {
        Image(params.item.icon)
          .width(20)
        Text(params.item.title)
          .fontSize(14)
      }
    }
  }
  @Builder
  ListItemDelete(index: number) {
    Text('删除')
      .width(80)
      .height('100%')
      .textAlign(TextAlign.Center)
      .fontColor(Color.White)
      .backgroundColor(Color.Red)
      .onClick(() => {
        this.MessageList.splice(index, 1)
      })
  }
  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End, index: $$this.index }) {
        ForEach(this.TabList, (item: TabItem, index: number) => {
          TabContent() {
            Column() {
              NavBar({ title: item.title, messageCont: 0, name: item.name })

                List() {
                  if (index === 0) {
                    ForEach(this.MessageList, (item: TemMessage, index: number) => {
                      ListItem() {
                        Row() {
                          Image(item.avatar)
                            .width(50)
                            .aspectRatio(1)
                          Column() {
                            Row() {
                              Text(item.username)
                                .fontSize(18)
                                .fontWeight(FontWeight.Bold)
                              Text(item.date)
                                .fontSize(14)
                                .fontColor('#CCC')
                            }
                            .justifyContent(FlexAlign.SpaceBetween)
                            .width('100%')
                            Row() {
                              Text(item.message)
                                .fontSize(14)
                            }
                          }
                          .padding({
                            top: 1,
                            right: 10,
                            bottom: 1,
                            left: 10
                          })
                          .width('100%')
                          .height('100%')
                          .alignItems(HorizontalAlign.Start)
                          .justifyContent(FlexAlign.SpaceBetween)
                          .layoutWeight(1)
                        }
                        .padding(10)
                        .height(70)
                      }
                      .swipeAction({
                        end: this.ListItemDelete(index)
                      })
                    })
                  } else if (index === 1) {
                    ForEach(this.ConnectList, (item: ConnectItem, index: number) => {
                      ListItem(){
                        ConnectBuilder(item, index)
                      }
                    })
                  }
                }
                .width('100%')
                .height('100%')
                .layoutWeight(1)
                .backgroundColor(Color.White)
            }
            .justifyContent(FlexAlign.Start)
            .height('100%')
          }
          .tabBar(this.TabBuilder({ item, index }))
          .backgroundColor('#e8e8e8')
        })
      }
    }
    .height('100%')
    .width('100%')
  }
}

@Builder
function ConnectBuilder(item: ConnectItem, index: number) {
  Row({ space: 10 }) {
    Image(item.avatar)
      .width(26)
      .aspectRatio(1)

    Row() {
      Row() {
        Text(item.username)
      }
      // .padding(20)
      .height('100%')
      .width('100%')
    }
    .width('100%')
    .height(40)
    .layoutWeight(1)
    .borderWidth({
      bottom: index % 3 ? 1 : 0
    })
    .borderColor('#ffdbdada')
  }
  .padding(10)
}