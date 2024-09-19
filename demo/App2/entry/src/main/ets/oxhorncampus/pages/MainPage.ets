import { Log } from '@ohos/lib_utils';
import { toast } from '@ohos/lib_views';
import { ListItemEntity } from '../main/entity/ListItemEntity';
import router from '@ohos.router';

@Entry
@Component
struct MainPage {
  private TAG: string = 'MainPage';
  @State listItems: ListItemEntity[] = [];

  jumpPage(listItemEntity: ListItemEntity) {
    Log.getInstance().error(this.TAG, `jumpPage text:${listItemEntity.text} path:${listItemEntity.path}`);
    toast(listItemEntity.text)
    router.pushUrl({
      url: listItemEntity.path
    });
  }

  aboutToAppear(): void {
    Log.getInstance().error(this.TAG, 'aboutToAppear');
    this.listItems = [
      new ListItemEntity("玩安卓", ""),
      new ListItemEntity("单词阅读", ""),
      new ListItemEntity("日历", "calendar/pages/Index"),
      new ListItemEntity("仿抖音", ""),
    ]
  }

  build() {
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
    .padding({ top: $r('app.float.top_bar_height') })
    .height('100%')
    .width('100%')
  }

  onPageShow(): void {
    Log.getInstance().error(this.TAG, 'onPageShow');
  }

  onBackPress(): void {
    Log.getInstance().error(this.TAG, 'onBackPress');
  }

  onPageHide(): void {
    Log.getInstance().error(this.TAG, 'onPageHide');
  }

  aboutToDisappear(): void {
    Log.getInstance().error(this.TAG, 'aboutToDisappear');
  }
}