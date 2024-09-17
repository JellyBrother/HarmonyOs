import { hilog } from '@kit.PerformanceAnalysisKit';
import { rcp } from '@kit.RemoteCommunicationKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { notificationManager } from '@kit.NotificationKit';

const kHttpServerAddress = "https://httpbin.org";
@Entry
@Component
struct  requestContent{
  @State showToken: string = '';
  @State content:string=''
  async aboutToAppear() {
    this.openSysSwitch();
  }

  build() {
    Flex({ direction: FlexDirection.Column }) {
      Row() {
        Text('BaseAddress')
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
      Flex({ direction: FlexDirection.Column,
        justifyContent: FlexAlign.SpaceBetween }) {

        Button('baseAddress-Test')
          .width('80%')
          .height(40)
          .margin({ left: '10%' })
          .backgroundColor('#fff38a07')
          .fontColor('#ffffffff')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .borderRadius(20)
          .onClick(this.getTokenSyn)
      }
      .height(64)
      .margin({ top: 86 })

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
    .linearGradient({
      direction: GradientDirection.Top,
      repeating: true,
      colors: [['#FFFFFF', 0], ['#FFFFFF', 1]]
    })
    .height('100%')
    .width('100%')
  }

  private getTokenSyn = async () => {
    try {
      let session = rcp.createSession({
        baseAddress: kHttpServerAddress
      });
      const resp = await session.get("");
      hilog.info(0x0000, 'testTag', 'Get push token successfully: %{public}s', JSON.stringify(resp));
      console.info(`${kHttpServerAddress} 传递成功`+ JSON.stringify(resp))
      this.content=`${kHttpServerAddress} 传递成功`+ JSON.stringify(resp)
    } catch (err) {
      let e: BusinessError = err as BusinessError;
      hilog.error(0x0000, 'testTag', 'Get push token catch error: %{public}d %{public}s', e.code, e.message);
      console.error(`${kHttpServerAddress} 传递失败`+ JSON.stringify(err))
      this.content=`${kHttpServerAddress} 传递失败`+ JSON.stringify(err)
    }
  }

  private openSysSwitch = async () => {
    await notificationManager.requestEnableNotification();
    hilog.info(0x0000, 'testTag', 'System notification switch is open');
  }
}