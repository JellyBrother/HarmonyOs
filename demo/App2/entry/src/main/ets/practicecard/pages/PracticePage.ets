import {PracticeStatus} from '../enums/PracticeStatus'
import {Question,getRandomQuestions} from '../model/Question'
import {OptionStatus} from '../enums/OptionStatus'
import {AnswerStatus} from '../enums/AnswerStatus'
import promptAction from '@ohos.promptAction'
import { convertMillisecondsToTime } from '../utils/DateUtil'
import router from '@ohos.router'
import {createPost} from '../http/Api'
import emitter from '@ohos.events.emitter'

@Entry
@Component
export struct PracticePage {
  @State practiceStatus:PracticeStatus = PracticeStatus.Stopped;
  // 题目的个数
  @State totalCount:number=10;
  // 存储题目的数组
  @State questions:Question[] = getRandomQuestions(this.totalCount);
  // 当前题目索引
  @State currentQueIndex:number = 0;
  // 当前答题状态
  @State answerStatus : AnswerStatus = AnswerStatus.Answering;
  // 选择的答案
  @State selectOption:string = '';
  // 答题时间统计
  timerController:TextTimerController = new TextTimerController()
  // 答对个数、答题次数
  @State rightCount:number = 0;
  @State answerCount:number = 0;
  // 答题用时
  timeUsed:number = 0;
  // 初始化弹窗
  dialogController:CustomDialogController = new CustomDialogController({
    builder:resultDialog({
      answerCount:this.answerCount,
      rightCount:this.rightCount,
      timeUsed:this.timeUsed,
      resetPractice:()=>{
        this.questions = getRandomQuestions(this.totalCount)
        this.currentQueIndex = 0
        this.answerCount = 0
        this.rightCount = 0
        this.timeUsed = 0
        this.timerController.reset()
        this.answerStatus = AnswerStatus.Answering
      },
      startPractice:()=>{
        this.practiceStatus = PracticeStatus.Running
        // 启动计时器
        this.timerController.start()
      }
    }),
    customStyle:true,
    autoCancel:false
  })

  build() {
    Column({space:40}){
      // 统计面板
      Column(){
        // 准确率
        Row(){
          StatItem({
            icon:$r('app.media.ic_accuracy'),
            name:'准确率',
            color:Color.Black
          })
          Blank()
          Row(){
            Text((this.answerCount === 0 ? 0 : this.rightCount/this.answerCount*100).toFixed()+'%').fontSize(16).fontColor(Color.Black)
          }
          .width(100)
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')

        // 进度
        Row(){
          StatItem({
            icon:$r('app.media.ic_progress'),
            name:'进度',
            color:Color.Black
          })
          Blank()
          Progress({value:this.answerCount, total:this.totalCount})
            .width(100)
        }
        .width('100%')

        // 个数
        Row(){
          StatItem({
            icon:$r('app.media.ic_count'),
            name:'个数',
            color:Color.Black
          })

          Blank()
          Button(this.totalCount.toString())
            .width(100)
            .height(25)
            .backgroundColor('#EBEBEB')
            .fontColor(Color.Black)
            .enabled(this.practiceStatus===PracticeStatus.Stopped)
            .onClick(()=>{
              TextPickerDialog.show({
                range:['5','10','15','20'],
                value:this.totalCount.toString(),
                onAccept:result=>{
                  this.totalCount = parseInt(result.value)
                  this.questions = getRandomQuestions(this.totalCount)
                  return
                }
              })
            })
        }
        .width('100%')

        // 用时
        Row(){
          StatItem({
            icon:$r('app.media.ic_timer'),
            name:'用时',
            color:Color.Black
          })
          Blank()

          Row(){
            TextTimer({controller:this.timerController})
              .fontSize(16).fontColor(Color.Black)
              .onTimer((utc,elapsedTime)=>{
                this.timeUsed = elapsedTime
              })
          }
          .width(100)
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
      }
      .width('90%')
      .backgroundColor(Color.White)
      .padding(20)
      .borderRadius(10)

      // 单词
      Column({space:10}){
        Text(this.questions[this.currentQueIndex].word)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)

        Text(this.questions[this.currentQueIndex].sentence)
          .height(40)
          .width('80%')
          .fontSize(18)
          .fontColor('#9BA1A5')
          .fontWeight(FontWeight.Medium)
          .textAlign(TextAlign.Center)
      }
      .width('90%')

      // 按钮选项
      Column({space:15}){
        ForEach(this.questions[this.currentQueIndex].options,(option)=>{
          ButtonItem({
            option:option,
            answer:this.questions[this.currentQueIndex].answer,
            selectOption:this.selectOption,
            answerStatus:this.answerStatus,
          })
            .enabled(this.answerStatus === AnswerStatus.Answering)
            .onClick(()=>{
              // 判断练习状态
              if (this.practiceStatus !== PracticeStatus.Running) {
                promptAction.showToast({ message: '请先点击开始测试' })
                return
              }

              // 判断正误
              this.selectOption = option

              //切换当前题目答题状态
              this.answerStatus = AnswerStatus.Answered

              // 计算答题数量
              this.answerCount++
              if (option === this.questions[this.currentQueIndex].answer)
              {
                this.rightCount++
              }

              //切换题目
              if(this.currentQueIndex<this.questions.length-1){
                setTimeout(() => {
                  this.currentQueIndex++
                  this.answerStatus = AnswerStatus.Answering
                  this.selectOption = ''
                }, 500)
              }
              else{
                //停止计时器
                this.timerController.pause()
                //切换答题停止状态
                this.practiceStatus = PracticeStatus.Stopped
                // 打开结算弹窗
                this.dialogController.open()
              }
            })
        })

      }

      Row({space:40})
      {
        Button('停止测试',{type:ButtonType.Capsule})
          .width(120)
          .fontSize(18)
          .backgroundColor(Color.White)
          .borderWidth(2)
          .fontColor(this.practiceStatus === PracticeStatus.Stopped ? Color.Gray : Color.Black)
          .borderColor(this.practiceStatus === PracticeStatus.Stopped ? Color.Gray : Color.Black)
          .enabled(this.practiceStatus!=PracticeStatus.Stopped)
          .onClick(()=>{
            // 停止计时器，切换停止状态
            this.timerController.pause();
            this.practiceStatus = PracticeStatus.Stopped
            // 打开弹窗
            this.dialogController.open()
          })

        Button(this.practiceStatus===PracticeStatus.Running?'暂停测试':'开始测试',{type:ButtonType.Capsule})
          .width(120)
          .fontSize(18)
          .fontColor(Color.White)
          .backgroundColor(this.practiceStatus === PracticeStatus.Running ?'#555555':Color.Black)
          .borderColor(this.practiceStatus === PracticeStatus.Running ?'#555555':Color.Black)
          .borderWidth(2)
          .onClick(()=>{
            if (this.practiceStatus===PracticeStatus.Running) {
              //   停止计时器
              this.timerController.pause()
              //  切换暂停状态
              this.practiceStatus = PracticeStatus.Paused
            }else{
               //  开启计时器，切换练习状态
              this.timerController.start()
              this.practiceStatus = PracticeStatus.Running
            }
          })
      }
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundImage($r('app.media.splash_bg'))
    .backgroundImageSize({width:'100%',height:'100%'})
  }
}

@Extend(Button) function  but_sty(color: {
  bg: ResourceColor,
  font: ResourceColor
}){
  .width(240)
  .height(48)
  .fontSize(18)
  .type(ButtonType.Normal)
  .fontWeight(FontWeight.Medium)
  .borderRadius(8)
  .backgroundColor(color.bg)
  .fontColor(color.font)
  .border({width:2,color:Color.White,radius:10})
}

// 统计表子组件
@Component
export struct StatItem{
  icon:Resource;
  name:string;
  color:Color;

  build(){
    Row({space:10}){
      Image(this.icon).height(16).width(16)
      Text(this.name).fontSize(16).fontWeight(FontWeight.Medium).fontColor(this.color)
    }
    .height(30)
  }
}

// 按钮子组件
@Component
struct ButtonItem{
  option:string;
  answer:string;
  // 答题对错状态的按钮显示
  @State optionStatus:OptionStatus = OptionStatus.Default;
  @Prop selectOption:string;
  @Prop @Watch('onAnswerStatusChange') answerStatus : AnswerStatus;

  onAnswerStatusChange(){
    if (this.option===this.answer) {
      this.optionStatus = OptionStatus.Right
    }else {
      if (this.option === this.selectOption) {
        this.optionStatus = OptionStatus.Wrong
      }else {
        this.optionStatus = OptionStatus.Default
      }
    }
  }

  getBgColor() {
    switch (this.optionStatus) {
      case OptionStatus.Right:
        return '#1DBF7B'
      case OptionStatus.Wrong:
        return '#FA635F'
      default:
        return Color.White
    }
  }

  build(){
    Stack() {
      Button(this.option.toString())
        .but_sty({
          bg: this.getBgColor(),
          font: this.optionStatus === OptionStatus.Default ? Color.Black : Color.White
        })
      if (this.optionStatus === OptionStatus.Right) {
        Image($r('app.media.ic_right'))
          .width(22)
          .height(22)
          .offset({ x: 10 })
      } else if (this.optionStatus === OptionStatus.Wrong) {
        Image($r('app.media.ic_wrong'))
          .width(22)
          .height(22)
          .offset({ x: 10 })
      }
    }.alignContent(Alignment.Start)
  }
}

// 弹窗组件
@CustomDialog
struct resultDialog{
  answerCount:number;
  rightCount:number;
  timeUsed:number;
  resetPractice:()=>void;
  startPractice:()=>void;
  controller : CustomDialogController = new CustomDialogController({
    builder:resultDialog
  })
  // 登录token字符，判断登录状态
  @StorageProp('token') token:string = '';
  //用于存储当前Tabs组件中访问的子页面的索引，方便登录后跳转到对应的子页面
  @StorageLink('currentTabIndex') currentTabIndex: number = 0

  build(){
    Column({space:10}){
      Image($r('app.media.ic_close')).height(25).width(25).alignSelf(ItemAlign.End)
        .onClick(()=>{
          this.controller.close()
          this.resetPractice()
        })

      Column({space:10}){
        Image($r('app.media.img_post')).width('100%').borderRadius(10)
        Row(){
          StatItem({
            icon:$r('app.media.ic_accuracy'),
            name:'准确率',
            color:Color.Black
          })
          Blank()
          Row(){
            Text((this.answerCount === 0 ? 0 : this.rightCount/this.answerCount*100).toFixed()+'%')
              .fontSize(16).fontColor(Color.Black)
          }
          .width(50)
          .justifyContent(FlexAlign.Center)
        }.width('100%')

        // 个数
        Row(){
          StatItem({
            icon:$r('app.media.ic_count'),
            name:'个数',
            color:Color.Black
          })
          Blank()
          Row(){
            Text(this.answerCount.toString())
              .fontSize(16).fontColor(Color.Black)
          }
          .width(50)
          .justifyContent(FlexAlign.Center)
        }.width('100%')

        // 用时
        Row(){
          StatItem({
            icon:$r('app.media.ic_timer'),
            name:'用时',
            color:Color.Black
          })
          Blank()
          Row(){
            Text(convertMillisecondsToTime(this.timeUsed))
              .fontSize(16).fontColor(Color.Black)
          }
          .width(50)
          .justifyContent(FlexAlign.Center)
        }.width('100%')

        Divider()

        Row({space:30}){
          Button('再背一组')
            .fontSize(16)
            .backgroundColor(Color.Black)
            .borderColor(Color.Black)
            .borderWidth(2)
            .fontColor(Color.White)
            .onClick(()=>{
              this.controller.close()
              this.resetPractice()
              this.startPractice()
            })

          Button(this.token ? '立即打卡':'登录打卡')
            .fontSize(16)
            .backgroundColor(Color.Black)
            .borderColor(Color.Black)
            .borderWidth(2)
            .fontColor(Color.White)
            .onClick(async () => {
              this.controller.close()
              this.resetPractice()
              if (this.token) {
                // 如果登录，立即打卡
                // 发送打卡请求。
                await createPost({
                  rightCount: this.rightCount,
                  answeredCount:this.answerCount,
                  timeUsed: this.timeUsed
                })
                promptAction.showToast({ message: '打卡成功' })
                // 通知,需要再页面最上方导入import emitter from '@ohos.events.emitter'
                emitter.emit({eventId:1})
                // 打卡后跳转到打卡圈
                this.currentTabIndex = 1
              }else{
                // 未登录，跳转登录页面
                router.pushUrl({
                  url:'pages/LoginPage',
                  // 传递打卡参数，完成打卡功能
                  params:{
                    rightCount:this.rightCount,
                    answerCount:this.answerCount,
                    timeUsed:this.timeUsed
                  }
                })

              }
            })
        }
      }
      .backgroundColor(Color.White)
      .width('100%')
      .padding(20)
      .borderRadius(10)
    }
    .backgroundColor(Color.Transparent)
    .width('80%')
  }
}