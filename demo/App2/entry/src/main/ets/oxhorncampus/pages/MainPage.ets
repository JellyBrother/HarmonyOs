import { ListItemEntity } from '../main/entity/ListItemEntity';
import { MainView } from './MainView';
import router from '@ohos.router';
import { Log, WindowUtils } from '@ohos/lib_utils';
import hilog from '@ohos.hilog';
import EntryContext from '../../wanharmony/common/EntryContext';

/**
 * UIAbility生命周期
 * onCreate-onWindowStageCreate-onForeground-onBackground-onWindowStageDestroy-onDestroy
 * 其余的有onNewWant（栈内唯一模式）、onConfigurationUpdate、onMemoryLevel、onWindowStageRestore
 * 页面生命周期 Entry component/common.d.ts$CustomComponent extends CommonAttribute
 * aboutToAppear-build-onPageShow-onBackPress-onPageHide(实际没有打印)-aboutToDisappear
 * 组件生命周期 Component
 * aboutToAppear-build-aboutToDisappear
 * EntryAbility,  life Ability onCreate
 * EntryAbility,  life Ability onWindowStageCreate
 * EntryAbility,  life Ability onForeground
 * MainPage,      life aboutToAppear
 * MainView,      life aboutToAppear
 * MainView,      life build
 * MainPage,      life build
 * MainPage,      life onPageShow
 * MainPage,      life onBackPress
 * EntryAbility,  life Ability onBackground
 * MainPage,      life aboutToDisappear
 * MainView,      life aboutToDisappear
 * EntryAbility,  life Ability onWindowStageDestroy
 * EntryAbility,  life Ability onDestroy
 */
@Preview
@Entry
@Component
struct MainPage {
  // private context = getContext(this) as common.UIAbilityContext;
  private TAG: string = 'MainPage';
  @State listItems: ListItemEntity[] = [];

  jumpPage(listItemEntity: ListItemEntity) {
    Log.getInstance().error(this.TAG, `jumpPage text:${listItemEntity.text} path:${listItemEntity.path}`);
    router.pushUrl({
      url: listItemEntity.path
    });
  }

  aboutToAppear(): void {
    Log.getInstance().error(this.TAG, 'life aboutToAppear');
    this.listItems = [
      new ListItemEntity("玩安卓", "wanharmony/pages/Index"),
      new ListItemEntity("单词测试", "practicecard/pages/PracticePage"),
      new ListItemEntity("日历", "calendar/pages/Index"),
      new ListItemEntity("仿抖音", "tiktok/pages/Index"),
    ]
  }

  build() {
    Column() {

      // Text('深色模式')
      //   .onClick(() => {
      //     WindowUtils.setDarkMode3()
      //   })
      //   .height(60)
      //   .width('100%')
      //   .margin({ top: 15 })
      // Text('浅色模式')
      //   .onClick(() => {
      //     WindowUtils.setLightMode3()
      //   })
      //   .height(60)
      //   .width('100%')
      //   .margin({ top: 15 })
      // MainView()

      List() {
        ForEach(this.listItems, (item: ListItemEntity) => {

          ListItem() {
            Text(item.text)
              .onClick(() => {
                this.jumpPage(item)
              })
              .fontColor($r('app.color.mother_child_room_color'))
              .fontSize($r('app.float.font_size_16fp'))
              .backgroundColor($r('app.color.swiper_jump_bg_color'))
              .borderRadius($r('app.float.10'))
              .textAlign(TextAlign.Center)
              .height(60)
              .width('100%')
              .margin({ top: 15 })
          }

        }, (itemGroup: ListItemEntity) => JSON.stringify(itemGroup))
      }.sticky(StickyStyle.Header) // 设置吸顶，实现粘性标题效果
      .width('100%')
      .height('100%')

    }.height('100%')
    .width('100%')
    .padding({ top: $r('app.float.top_bar_height') })
  }

  onPageShow(): void {
    Log.getInstance().error(this.TAG, 'life onPageShow');
  }

  onBackPress(): void {
    Log.getInstance().error(this.TAG, 'life onBackPress');
  }

  onPageHide(): void {
    Log.getInstance().error(this.TAG, 'life onPageHide');
  }

  aboutToDisappear(): void {
    Log.getInstance().error(this.TAG, 'life aboutToDisappear');
  }

}

