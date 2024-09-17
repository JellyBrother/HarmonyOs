import { hilog } from '@kit.PerformanceAnalysisKit';
import { rcp } from '@kit.RemoteCommunicationKit';
import { notificationManager } from '@kit.NotificationKit';

const kHttpServerAddress = "https://www.baidu.com";
@Entry
@Component
struct  requestContent{
  @State showToken: string = '';
  @State content: string = '';
  @State timeout:rcp.Timeout = {
    connectMs: 1000,
    transferMs: 1000
  }
  async aboutToAppear() {
    this.openSysSwitch();
  }

  build() {
    Flex({ direction: FlexDirection.Column }) {
      Row() {
        Text('TimeOut')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#ff100f0f')
          .height(30)
          .width(220)
          .margin({ left: 4 })
      }
      .height(32)
      .width(124)
      .margin({ top: 32, left: 12 })

      Divider().color('gray').strokeWidth(1)
      Text(this.showToken)
        .fontColor(Color.Blue)
        .width('80%')
        .margin({ left: '10%'})
      Flex({ direction: FlexDirection.Column,
        justifyContent: FlexAlign.SpaceBetween }) {
        Text("connectMs:")
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#ff100f0f')
          .height(40)
          .width(220)
          .margin({ left: 8 })
        TextArea({
          text:String(this.timeout.connectMs)
        })
          .width('80%')
          .height(40)
          .margin({ left: '10%' })
          .backgroundColor('0x317aff')
          .fontColor('#000')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .borderRadius(10)

        Text("transferMs:")
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#ff100f0f')
          .height(40)
          .width(220)
          .margin({ left: 8 })
        TextArea({
          text:String(this.timeout.transferMs)
        })
          .width('80%')
          .height(40)
          .margin({ left: '10%'})
          .backgroundColor('0x317aff')
          .fontColor('#000')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .borderRadius(10)

        Button('timeout-test')
          .width('80%')
          .height(40)
          .margin({ left: '10%' })
          .backgroundColor('#fff38a07')
          .fontColor('#ffffffff')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .borderRadius(20)
          .onClick(this.getTimeoutSyn)

        Text("结果")
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000')
          .height(30)
          .width(220)
          .margin({ left: 8 })
        TextArea({
          text: this.content
        })
          .width('80%')
          .height(260)
          .margin({ left: '10%',top: '10%' })
          .backgroundColor('0x317aff')
          .fontColor('#ffffffff')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .borderRadius(10)
      }
      .height(644)
      .margin({ top: 16 })
    }
    .linearGradient({
      direction: GradientDirection.Top,
      repeating: true,
      colors: [['#FFFFFF', 0], ['#FFFFFF', 1]]
    })
    .height('100%')
    .width('100%')
  }

  private getTimeoutSyn = async () => {
    const session = rcp.createSession();
    const request = new rcp.Request(kHttpServerAddress);
    request.configuration = {
      transfer: {
        timeout: this.timeout
      }
    }
    let onCatch = false;
    try {
      const response = await session.fetch(request);
      console.info('timeout--success',JSON.stringify(response))
      this.content=`timeout--success + ${JSON.stringify(response)}`
    } catch (err) {
      console.error('timeout--err',JSON.stringify(err))
      this.content=`timeout--err + ${JSON.stringify(err)}`
      onCatch = true;
    }
    session.close();
  }

  private openSysSwitch = async () => {
    await notificationManager.requestEnableNotification();
    hilog.info(0x0000, 'testTag', 'System notification switch is open');
  }
}