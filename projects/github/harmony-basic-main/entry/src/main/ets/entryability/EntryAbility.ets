import UIAbility from '@ohos.app.ability.UIAbility';
import window from '@ohos.window';
import { AbilityConstant, Want } from '@kit.AbilityKit';
import { hiAppEvent, hilog } from '@kit.PerformanceAnalysisKit';

import { AdStore, getStartAd, OPEN_SUB_WINDOW_KEY } from '../utils';
// import { KeyboardAvoidMode } from '@kit.ArkUI';

import { TokenManager } from '../pages/ApplicationState/utils/token';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    startApm()
    reportUserAction()
  }

  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  async onWindowStageCreate(windowStage: window.WindowStage): Promise<void> {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    await showStartAd(windowStage, this.context)

    // 缓存windowStage
    AppStorage.setOrCreate('windowStage', windowStage);

    // 应用全屏
    const win = windowStage.getMainWindowSync()
    win.setWindowLayoutFullScreen(true)
    // 获取顶部区域高度
    const topAreaHeight = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM).topRect.height
    AppStorage.setOrCreate('topAreaHeight', topAreaHeight)
    // 键盘避让
    // win.getUIContext().setKeyboardAvoidMode(KeyboardAvoidMode.RESIZE)

    // let url = 'pages/ApplicationState/PersistentStorageLogin'
    // if (await TokenManager.getToken(this.context)) {
    //   url = 'pages/ApplicationState/PersistentStorageMain'
    // }
    let url = 'pages/Case/SaveAlbum/SaveAlbum'

    windowStage.loadContent(url, (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onNewWant');
  }

  onForeground() {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground() {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}

function startApm() {
  hiAppEvent.addWatcher({
    // 开发者可以自定义观察者名称，系统会使用名称来标识不同的观察者
    name: "watcher",
    // 开发者可以订阅感兴趣的系统事件，此处是订阅了崩溃事件
    appEventFilters: [
      {
        domain: hiAppEvent.domain.OS,
        names: [hiAppEvent.event.APP_CRASH]
      }
    ],

    // 开发者可以自行实现订阅实时回调函数，以便对订阅获取到的事件数据进行自定义处理
    onReceive: (domain: string, appEventGroups: Array<hiAppEvent.AppEventGroup>) => {
      hilog.info(0x0000, 'testTag', `HiAppEvent onReceive: domain=${domain}`);
      for (const eventGroup of appEventGroups) {
        // 开发者可以根据事件集合中的事件名称区分不同的系统事件
        hilog.info(0x0000, 'testTag', `HiAppEvent eventName=${eventGroup.name}`);
        for (const eventInfo of eventGroup.appEventInfos) {
          // 开发者可以对事件集合中的事件数据进行自定义处理，此处是将事件数据打印在日志中
          hilog.info(0x0000, 'testTag', `HiAppEvent eventInfo.domain=${eventInfo.domain}`);
          hilog.info(0x0000, 'testTag', `HiAppEvent eventInfo.name=${eventInfo.name}`);
          hilog.info(0x0000, 'testTag', `HiAppEvent eventInfo.eventType=${eventInfo.eventType}`);
          // 开发者可以获取到崩溃事件发生的时间戳
          hilog.info(0x0000, 'testTag', `HiAppEvent eventInfo.params.time=${eventInfo.params['time']}`);
          // 开发者可以获取到崩溃事件发生的崩溃类型
          hilog.info(0x0000, 'testTag', `HiAppEvent eventInfo.params.crash_type=${eventInfo.params['crash_type']}`);
          // 开发者可以获取到崩溃应用的前后台状态
          hilog.info(0x0000, 'testTag', `HiAppEvent eventInfo.params.foreground=${eventInfo.params['foreground']}`);
          // 开发者可以获取到崩溃应用的版本信息
          hilog.info(0x0000, 'testTag',
            `HiAppEvent eventInfo.params.bundle_version=${eventInfo.params['bundle_version']}`);
          // 开发者可以获取到崩溃应用的包名
          hilog.info(0x0000, 'testTag', `HiAppEvent eventInfo.params.bundle_name=${eventInfo.params['bundle_name']}`);
          // 开发者可以获取到崩溃应用的进程id
          hilog.info(0x0000, 'testTag', `HiAppEvent eventInfo.params.pid=${eventInfo.params['pid']}`);
          hilog.info(0x0000, 'testTag', `HiAppEvent eventInfo.params.uid=${eventInfo.params['uid']}`);
          hilog.info(0x0000, 'testTag', `HiAppEvent eventInfo.params.uuid=${eventInfo.params['uuid']}`);
          // 开发者可以获取到崩溃事件发生的异常类型、异常原因和异常调用栈
          hilog.info(0x0000, 'testTag',
            `HiAppEvent eventInfo.params.exception=${JSON.stringify(eventInfo.params['exception'])}`);
          // 开发者可以获取到崩溃事件发生时日志信息
          hilog.info(0x0000, 'testTag', `HiAppEvent eventInfo.params.hilog.size=${eventInfo.params['hilog'].length}`);
          // 开发者可以获取到崩溃事件发生时的故障日志文件
          hilog.info(0x0000, 'testTag',
            `HiAppEvent eventInfo.params.external_log=${JSON.stringify(eventInfo.params['external_log'])}`);
          hilog.info(0x0000, 'testTag',
            `HiAppEvent eventInfo.params.log_over_limit=${eventInfo.params['log_over_limit']}`);
          // 开发者可以获取到崩溃事件的自定义数据test_data
          hilog.info(0x0000, 'testTag', `HiAppEvent eventInfo.params.test_data=${eventInfo.params['test_data']}`);
        }
      }
    }
  });
}

function reportUserAction() {
  hiAppEvent.addWatcher({
    // 开发者可以自定义观察者名称，系统会使用名称来标识不同的观察者
    name: "watcher1",
    // 开发者可以订阅感兴趣的应用事件，此处是订阅了按钮事件
    appEventFilters: [{ domain: "button" }],
    // 开发者可以设置订阅回调触发的条件，此处是设置为事件打点数量满足1个
    triggerCondition: { row: 1 },
    // 开发者可以自行实现订阅回调函数，以便对订阅获取到的事件打点数据进行自定义处理
    onTrigger: (curRow: number, curSize: number, holder: hiAppEvent.AppEventPackageHolder) => {
      // 返回的holder对象为null，表示订阅过程发生异常，因此在记录错误日志后直接返回
      if (holder == null) {
        hilog.error(0x0000, 'testTag', "HiAppEvent holder is null");
        return;
      }
      hilog.info(0x0000, 'testTag', `HiAppEvent onTrigger: curRow=%{public}d, curSize=%{public}d`, curRow, curSize);
      let eventPkg: hiAppEvent.AppEventPackage | null = null;
      // 根据设置阈值大小（默认为512KB）去获取订阅事件包，直到将订阅数据全部取出
      // 返回的事件包对象为null，表示当前订阅数据已被全部取出，此次订阅回调触发结束
      while ((eventPkg = holder.takeNext()) != null) {
        // 开发者可以对事件包中的事件打点数据进行自定义处理，此处是将事件打点数据打印在日志中
        hilog.info(0x0000, 'testTag', `HiAppEvent eventPkg.packageId=%{public}d`, eventPkg.packageId);
        hilog.info(0x0000, 'testTag', `HiAppEvent eventPkg.row=%{public}d`, eventPkg.row);
        hilog.info(0x0000, 'testTag', `HiAppEvent eventPkg.size=%{public}d`, eventPkg.size);
        for (const eventInfo of eventPkg.data) {
          hilog.info(0x0000, 'testTag', `HiAppEvent eventPkg.info=%{public}s`, eventInfo);
        }
      }
    }
  });
  // 上传服务器 Todo: 待测试完善
  hiAppEvent.configure({
    disable: false,
    maxStorage: '10M'
  })
  let analytics: hiAppEvent.Processor = {
    name: 'test',
    debugMode: false,
    routeInfo: 'http://anlaytics.cloud.con/v1/upload',
    // periodReport: 20000, // 定期上报
    // batchReport: 10, // 批次上报
  }
  hiAppEvent.addProcessor(analytics)
  hiAppEvent.write({
    domain: '',
    name: 'report',
    eventType: hiAppEvent.EventType.BEHAVIOR,
    params: {
      test: 12
    }
  })
}

/**
 * 打开启动广告
 * @param windowStage
 * @param ctx
 */
async function showStartAd(windowStage: window.WindowStage, ctx: Context) {
  const adStore = new AdStore(ctx)
  const ad = await getStartAd() // 获取广告数据
  await adStore.setStartAd(ad) // 写入首选项
  const win = await windowStage.createSubWindow(OPEN_SUB_WINDOW_KEY) // 创建子窗口
  await win.showWindow()
  win.setUIContent('pages/OtherDemo/StartAd')
}
