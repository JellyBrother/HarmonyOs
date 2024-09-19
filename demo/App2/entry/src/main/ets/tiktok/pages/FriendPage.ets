import { Log, WindowUtils } from '@ohos/lib_utils';

@Preview
@Component
export struct FriendPage{
  private TAG: string = 'FriendPage';

  aboutToAppear(): void {
    Log.getInstance().error(this.TAG, 'life aboutToAppear');
  }

  build() {
    Column(){
      Text('朋友')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .height('100%')
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