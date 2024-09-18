import { notificationManager } from '@kit.NotificationKit';
import common from '@ohos.app.ability.common';

const notificationRequest: notificationManager.NotificationRequest = { // 描述通知的请求
  id: 1, // 通知ID
  content: { // 通知内容
    notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT, // 普通文本类型通知
    normal: { // 基本类型通知内容
      title: '通知内容标题',
      text: '通知内容详情'
    }
  }
}

@Entry
@Component
struct NotificationDemo {
  async publishNotification() {
    try {
      // 查询通知是否授权
      const data = await notificationManager.isNotificationEnabled()
      console.info('x_log', 'isNotificationEnabled success, data: ' + JSON.stringify(data));

      if(!data){
        const context = getContext(this) as common.UIAbilityContext;
        // 弹出授权弹框
        await notificationManager.requestEnableNotification(context)
      }

      // 发送通知
      await notificationManager.publish(notificationRequest)
      console.info('x_log', 'publish success');

    } catch (err) {
      if(1600004 == err.code){
        console.info('x_log', `[ANS] requestEnableNotification refused`);
        return
      }

      console.error(`requestEnableNotification failed | isNotificationEnabled fail: ${JSON.stringify(err)}`);
    }
  }

  build() {
    Column() {
      Row() {
        Button('发送通知')
          .onClick(() => {
            this.publishNotification()
          })
      }
      .height('100%')
    }
    .width('100%')
  }
}