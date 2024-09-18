import { BusinessError } from '@kit.BasicServicesKit';
import { hiAppEvent, hilog } from '@kit.PerformanceAnalysisKit';

@Entry
@Component
struct ReportData {
  build() {
    Row() {
      Column() {
        Button("writeTest").onClick(()=>{
          // 在按钮点击函数中进行事件打点，以记录按钮点击事件
          let eventParams: Record<string, number> = { 'click_time': 100 };
          let eventInfo: hiAppEvent.AppEventInfo = {
            // 事件领域定义
            domain: "button",
            // 事件名称定义
            name: "click",
            // 事件类型定义
            eventType: hiAppEvent.EventType.BEHAVIOR,
            // 事件参数定义
            params: eventParams,
          };
          hiAppEvent.write(eventInfo).then(() => {
            hilog.info(0x0000, 'testTag', `HiAppEvent success to write event`)
          }).catch((err: BusinessError) => {
            hilog.error(0x0000, 'testTag', `HiAppEvent err.code: ${err.code}, err.message: ${err.message}`)
          });
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}