import { OptionItem, OptionItemModel, QuestionInfo, QuestionInfoModel, UserAnswer } from './models'
import { promptAction } from '@kit.ArkUI'

@Entry
@Component
struct BpOnlineSimulation {
  @State
  list: QuestionInfo[] = []
  @State
  questionIndex: number = 0
  @State
  answerMap: Record<number, UserAnswer> = {}

  @Styles
  getContextPadding() {
    .padding({
      left: 16,
      right: 16,
    })
  }

  @Builder
  getTopUI() {
    Row() {
      Image($r('app.media.ic_public_left_arrow'))
        .getImageStyle()
      Text('在线模拟')
        .fontSize(17)
        .fontColor('#191919')
      Image($r('app.media.ic_public_pb_file'))
        .getImageStyle(24)
    }
    .getTopStyle()
  }

  @Builder
  getQuestionUI() {
    Column({ space: 10 }) {
      if (this.list.length) {
        Text(this.questionIndex + 1 + '. ' + this.getCurrentQuestion()!.title)
          .width('100%')
        ForEach(this.getCurrentQuestion()!.options, (item: OptionItem) => {
          Row({ space: 10 }) {
            Text(item.letter + '.')
              .fontColor(this.getColor(item))
            Text(item.optionsTitle)
              .fontColor(this.getColor(item))
          }
          .width('100%')
          .backgroundColor(this.getColor(item, 'back'))
          .height(48)
          .borderRadius(6)
          .padding({
            left: 16,
            right: 16,
          })
          .onClick(() => {
            this.selectAnswer(item)
          })
        })
      }
    }
    .getContextPadding()
    .layoutWeight(1)
    .margin({
      top: 12,
    })
  }

  @Builder
  getBottomUI() {
    Row() {
      Row({ space: 10 }) {
        Image($r('app.media.ic_public_left_arrow'))
          .getImageStyle(16)
          .fillColor(this.canLastQuestion() ? Color.Black : '#ccc')
        Text('上一题')
          .fontColor(this.canLastQuestion() ? Color.Black : '#ccc')
      }
      .onClick(() => {
        this.lastQuestion()
      })

      Row({ space: 10 }) {
        Text('下一题')
          .fontColor(this.canNextQuestion() ? Color.Black : '#ccc')
        Image($r('app.media.ic_public_left_arrow'))
          .getImageStyle(16)
          .fillColor(this.canNextQuestion() ? Color.Black : '#ccc')
          .rotate({
            angle: 180,
          })
      }
      .onClick(() => {
        this.nextQuestion()
      })
    }
    .getTopStyle()
  }

  aboutToAppear(): void {
    this.getList()
  }

  async getList() {
    try {
      this.list = await getListApi()
    } catch (error) {
      promptAction.showToast({
        message: '获取题目失败'
      })
    }
  }

  getColor(option: OptionItem, type: 'front' | 'back' = 'front') {
    const question = this.getCurrentQuestion()
    if (question && this.answerMap[question.id]?.user_answer === option.letter) {
      // 选中颜色
      return type === 'front' ? Color.White : '#317ae5'
    }
    // 未选中颜色
    return type === 'front' ? Color.Black : '#f9f9f9'
  }

  canLastQuestion() {
    return this.questionIndex > 0
  }

  canNextQuestion() {
    return this.questionIndex < this.list.length - 1
  }

  lastQuestion() {
    if (this.canLastQuestion()) {
      this.questionIndex--
    }
  }

  nextQuestion() {
    if (this.canNextQuestion()) {
      this.questionIndex++
    }
  }

  getCurrentQuestion() {
    if (this.list.length) {
      return this.list[this.questionIndex]
    }
    return null
  }

  selectAnswer(option: OptionItem) {
    const question = this.getCurrentQuestion()
    if (question) {
      this.answerMap[question.id] = {
        question_id: question.id,
        user_answer: option.letter,
        user_id: '123456', // Todo: 暂写死
      }
    }
  }

  build() {
    Column({ space: 10 }) {
      // 顶部
      this.getTopUI()

      // 进度条
      Progress({
        value: this.questionIndex + 1,
        total: this.list.length,
      })
        .getContextPadding()

      // 中部
      this.getQuestionUI()

      // 底部
      this.getBottomUI()
    }
  }
}

@Extend(Row)
function getTopStyle() {
  .width('100%')
  .height(56)
  .justifyContent(FlexAlign.SpaceBetween)
  .padding({
    left: 16,
    right: 16,
  })
}

@Extend(Image)
function getImageStyle(width: number = 20) {
  .width(width)
  .aspectRatio(1)
}

function getListApi() {
  return new Promise<QuestionInfoModel[]>((resolve) => {
    setTimeout(() => {
      resolve([
        new QuestionInfoModel({
          id: 1,
          title: '下面说法正确的是',
          options: [
            new OptionItemModel({
              letter: 'A',
              optionsTitle: '鸿蒙和openHarmony是一回事',
            }),
            new OptionItemModel({
              letter: 'B',
              optionsTitle: '鸿蒙的装饰器不可以做响应式',
            }),
            new OptionItemModel({
              letter: 'C',
              optionsTitle: 'arkTS借鉴了TS的语法',
            }),
            new OptionItemModel({
              letter: 'D',
              optionsTitle: '鸿蒙4.0已经面世1年了',
            }),
          ]
        }),
        new QuestionInfoModel({
          id: 2,
          title: '哪个修饰符不具备响应式',
          options: [
            new OptionItemModel({
              letter: 'A',
              optionsTitle: 'State',
            }),
            new OptionItemModel({
              letter: 'B',
              optionsTitle: 'Prop',
            }),
            new OptionItemModel({
              letter: 'C',
              optionsTitle: 'Link',
            }),
            new OptionItemModel({
              letter: 'D',
              optionsTitle: 'Preview',
            }),
          ]
        }),
        new QuestionInfoModel({
          id: 3,
          title: 'Link的用法下面哪个语法是正确的',
          options: [
            new OptionItemModel({
              letter: 'A',
              optionsTitle: '$$this.xxx',
            }),
            new OptionItemModel({
              letter: 'B',
              optionsTitle: '$xxx',
            }),
            new OptionItemModel({
              letter: 'C',
              optionsTitle: '$this.xxx',
            }),
            new OptionItemModel({
              letter: 'D',
              optionsTitle: '$$xxx',
            }),
          ]
        }),
      ])
    }, 300)
  })
}
