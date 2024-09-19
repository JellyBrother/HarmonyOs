import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import {sendCode,login, createPost} from '../http/Api'
import emitter from '@ohos.events.emitter';
AppStorage.SetOrCreate('isFresh',false)
@Entry
@Component
export struct LoginPage{
  @StorageLink('phone') phone:string = '';
  @State code:string = '';
  // 登录后的token字符
  @StorageLink('token') token : string = '';
  // tabs组件当前访问的子页面索引
  @StorageLink('currentTabIndex') currentTabIndex:number = 0;
  // 打卡圈刷新
  @StorageLink('isFresh') isFresh:boolean = false;

  build(){
    Column(){
      // 左上角返回按钮
      Image($r('app.media.ic_star_red'))
        .width(30).height(30).alignSelf(ItemAlign.Start)
        .onClick(()=>{
          // 之间返回，直接清空token，避免输入电话号码也可显示圈子
          this.token = ''
          // 点击返回上一个页面
          router.back()
        })
      Blank()

      // 登录
      Column(){
        Text('欢迎登录').fontWeight(FontWeight.Bold).fontSize(28)

        // 输入手机号
        Row(){
          Image($r('app.media.ic_star_red'))
            .iconStyle()

          TextInput({placeholder:'请输入手机号', text:this.phone})
            .inputStyle()
            .onChange((value)=>{
              this.phone = value
            })
        }.margin({top:30})

        Divider().backgroundColor(Color.Black)

        // 输入验证码
        Row(){
          Image($r('app.media.ic_star_red'))
            .iconStyle()


          TextInput({placeholder:'请输入验证码', text:this.code})
            .inputStyle()
            .onChange((value)=>{
              this.code = value
            })

          Button('获取验证码')
            .but_style(Color.Transparent,Color.Black)
            .onClick(async ()=>{
              // 获取验证码
              const response = await sendCode(this.phone)
              this.code = response.data.data
            })
        }.margin({top:20})
        Divider().backgroundColor(Color.Black).margin({right:120})

        // 登录按钮
        Button('立即登录')
          .but_style(Color.Black,Color.White)
          .width('100%')
          .margin({top:50})
          .onClick(async ()=>{
            //登录
            const response = await login(this.phone, this.code)
            const { data } = response;
            this.token = response.data.data

            // 如果是答题页面跳转到登录，登录后立马实现打卡
            if (this.currentTabIndex === 0) {
              // 获取打卡弹窗传过来的数据，（用时，个数，准确率）
              const params = router.getParams()
              // 请求后台API，存储打卡数据
              await createPost({
                rightCount:params['rightCount'],
                answeredCount:params['answerCount'],
                timeUsed:params['timeUsed']
              })
              promptAction.showToast({message:'打卡成功'})

              // 通知打卡圈
              console.log('立即登录');
              this.isFresh = true
              // if (this.isFresh) {
              //   emitter.emit({eventId:1})
              // }

              // 打卡完跳转到圈子页面
              this.currentTabIndex = 1
            }
            //登录完返回上一个页面
            this.isFresh = true
            router.back()
          })

        // 登录同意协议
        Row() {
          Text('登录即表示已同意')
            .fontSize(12)
            .fontColor('#546B9D')
          Text('《用户使用协议》')
            .fontSize(12)
            .fontColor('#00B3FF')
        }.margin({ top: 20 })
      }
      .backgroundColor(Color.White)
      .borderRadius(20)
      .padding(30)

      // 底部logo
      Row({ space: 10 }) {
        Image($r('app.media.ic_star_red'))
          .width(36)
          .height(36)
        Text('快速记单词神器')
          .fontColor('#546B9D')
          .fontWeight(FontWeight.Bold)
          .fontSize(20)
      }.margin({ top: 70 })

      Text('Developed By Togogo')
        .fontSize(12)
        .fontColor('#546B9D')
        .margin(10)
    }
    .width('100%').height('100%')
    .backgroundImage($r('app.media.ic_star_red'))
    .backgroundImageSize({width:'100%',height:'100%'})
    .padding({ top:30,bottom:30,left:20,right:20 })
  }
}

@Styles function  iconStyle(){
  .width(28)
  .height(28)
}

@Extend(TextInput) function inputStyle() {
  .height(40)
  .layoutWeight(1)
  .borderRadius(0)
  .fontSize(14)
  .backgroundColor(Color.Transparent)
}

@Extend(Button) function but_style(bg:ResourceColor,font:ResourceColor){
  .type(ButtonType.Normal)
  .fontSize(14)
  .fontWeight(FontWeight.Medium)
  .borderWidth(1)
  .borderRadius(5)
  .backgroundColor(bg)
  .fontColor(font)
}