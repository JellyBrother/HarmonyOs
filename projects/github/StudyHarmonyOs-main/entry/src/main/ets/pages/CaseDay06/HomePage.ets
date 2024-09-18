import { TabItem, TabTopItem } from '../CaseDay06/viewmodel'

interface Tem {
  item: TabItem,
  index: number
}

@Entry
@Component
struct CaseDay06 {
  @Builder TabContentRelativeBuilder(item: TabItem) {
    Row() {
      ForEach(item.tabTopList, (item: TabTopItem, index: number) => {
        Row() {
          Column() {
            Text(item.title)
              Divider()
                .width(25)
                .strokeWidth(2)
                .color('#E52D21')
                .margin({
                  top: 5
                })
          }
          .margin({
            top: 10,
            left: index === 0 ? 30.5 : 36
          })

          // if (index === 0) {
          //   Column() {
          //
          //   }
          //   .layoutWeight(1)
          //   .backgroundColor('#F4F4F4')
          // }
        }
      })
    }
    .alignItems(VerticalAlign.Top)
    .width('100%')
    .height('100%')
  }
  @Builder TabBarBuilder(params: Tem) {
    Column({ space: 5 }) {
      if (params.index === this.index) {
        Image(params.item.selectIcon)
          .width(20)
          .syncLoad(true)
        Text(params.item.title)
          .fontSize(14)
          .fontColor('#EF4F3F')
      } else {
        Image(params.item.icon)
          .width(20)
        Text(params.item.title)
          .fontSize(14)
      }
    }
  }
  @Builder TabContentBuilder(item: TabItem) {
    Tabs() {
      ForEach(item.tabTopList, (item: TabTopItem, index: number) => {
        TabContent() {
          if (index === 0) {
            this.TabContentNullBuilder()
          }
        }
        .backgroundColor('#F4F4F4')
        .tabBar(
          new SubTabBarStyle(item.title)
            .indicator({
              color: '#E52D21',
              width: 23,
              height: 4,
              borderRadius: 2
            })
            .labelStyle({
              font: {

              },
              selectedColor: '#2A2929',
              unselectedColor: '#818181',
              overflow: TextOverflow.None
            })
        )
      })
    }
  }
  @Builder TabContentNullBuilder() {
    Column({ space: 15 }) {
      Image('/pages/CaseDay06/images/null@3x.png')
        .width(200)
      Text('无待提货物')
        .fontSize(16)
        .fontColor('#818181')
    }
  }

  @State TabList: Array<TabItem> = [
    {
      icon: '/pages/CaseDay06/images/btn_test_sel@3x.png',
      name: 'todolist',
      title: '任务',
      selectIcon: '/pages/CaseDay06/images/btn_test_sel@3x.png',
      tabTopList: [
        {
          icon: '',
          name: '',
          title: '待提货',
          selectIcon: ''
        },
        {
          icon: '',
          name: '',
          title: '在途',
          selectIcon: ''
        },
        {
          icon: '',
          name: '',
          title: '已完成',
          selectIcon: ''
        },
      ]
    },
    {
      icon: '/pages/CaseDay06/images/btn_mess_nor@3x.png',
      name: 'message',
      title: '消息',
      selectIcon: '/pages/CaseDay06/images/btn_mess_nor@3x.png'
    },
    {
      icon: '/pages/CaseDay06/images/btn_mine_nor@3x.png',
      name: 'my',
      title: '我的',
      selectIcon: '/pages/CaseDay06/images/btn_mine_nor@3x.png'
    },
  ]
  @State index: number = 0
  build() {
    RelativeContainer() {
      Tabs({ barPosition: BarPosition.End, index: $$this.index }) {
        ForEach(this.TabList, (item: TabItem, index: number) => {
          TabContent() {
            if (index === 0) {
              this.TabContentBuilder(item)
              // this.TabContentRelativeBuilder(item)
            }
          }
          .tabBar(this.TabBarBuilder({ item, index }))
        })
      }
    }
    .id('root')
    .height('100%')
    .width('100%')
  }
}