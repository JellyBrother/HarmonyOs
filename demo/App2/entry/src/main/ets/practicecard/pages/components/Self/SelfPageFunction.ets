import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import Item from './Item'

@Component
export default struct SelfPageFunctin {
  @Prop hasLogin: boolean;
  @StorageLink('token') token: string = '';
  @StorageLink('phone') phone: string = '';

  @State items: object[] = [
    {
      icon: "ic_mine_card.svg",
      text: '打卡记录',
      showDivider: true,
      clickFn: () => {
        if (this.hasLogin){
          router.pushUrl({url: 'pages/CardHistory'})
        }else{
          promptAction.showToast({
            message: '请先登录',
            duration: 3000,
            bottom: 200
            })
        }
      }
    },
    {
      icon: "ic_mine_update.svg",
      text: '检查更新',
      showDivider: true,
      clickFn: () => {
        promptAction.showToast({
          message: '已是最新版本',
          duration: 3000,
          bottom: 200
        })
      }
    },
    {
      icon: "ic_mine_about.svg",
      text: '关于',
      showDivider: false,
      clickFn: () => {
        promptAction.showToast({
          message: '单词打卡APP',
          duration: 4000,
          bottom: 300
        })
      }
    },
  ];

  // 退出登录
  exitLogin = () => {
    AlertDialog.show({
      title:'退出登录',
      message:'是否确定退出登录',
      primaryButton:{
        value:'确定',
        fontColor: '#ffe31313',
        backgroundColor:'#fff',
        action:()=>{
          this.hasLogin = false;
          this.token = '';
          this.phone = '';
        }
      },
      secondaryButton:{
        value:'取消',
        fontColor:'#ff1366e3',
        backgroundColor:'#fff',
        action: ()=>{}
      },
      alignment:DialogAlignment.Bottom,
      offset: {dx:0,dy:-20}
   })
  }

  build() {
    Flex({
      direction: FlexDirection.Column,
      justifyContent: FlexAlign.Start,
      alignItems: ItemAlign.Center
    }) {
      ForEach(this.items, ({icon, text, showDivider, clickFn}) => {
        Item({
          iconURL: icon as string,
          text: text as string,
          showDivider: showDivider as boolean,
        }).onClick(clickFn)
      })

      if(this.hasLogin || false) {
        Button('退出登录').width('75%').height('100px')
          .position({x: '12.5%', y: '70%'})
          .onClick(this.exitLogin)
      }
    }
    .width('100%')
    .margin({top: '40px'})
  }
}
