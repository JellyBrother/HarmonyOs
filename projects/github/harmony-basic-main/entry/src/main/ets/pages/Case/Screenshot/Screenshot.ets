import { image } from '@kit.ImageKit';
import { componentSnapshot } from '@kit.ArkUI';

@Entry
@Component
struct Screenshot {
  @State snapshotImage: image.PixelMap | null = null
  @State showSnap: boolean = false

  @Builder
  getSnapContent() {
    Column() {
      Image(this.snapshotImage)
        .width('100%')
        .objectFit(ImageFit.Auto)
        .borderRadius(6)
    }
    .padding('10%')
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor('rgba(0,0,0,0.5)')
    .onClick(() => {
      this.showSnap = false
    })

  }

  @Builder
  getIconUI() {
    Image($r('app.media.ic_snapshot'))
      .width(20)
      .aspectRatio(1)
      .fillColor(Color.Black)
      .margin({ right: 10 })
      .onClick(async () => {
        this.snapshotImage = await componentSnapshot.get('page')
        this.showSnap = !this.showSnap // 显示截屏
        // Todo: 截屏音效
        // Todo: 保存到相册
      })
  }

  build() {
    Column({ space: 5 }) {
      Row() {
        Text('Hello Snapshot').fontSize(24)
        this.getIconUI()
      }.justifyContent(FlexAlign.SpaceBetween).padding(20).width('100%')

      Image('https://img20.360buyimg.com/img/jfs/t1/241153/31/4968/64736/65e53e56Fd3868b6e/b595d41ca8447ea4.jpg')
        .width('60%')
        .border({ width: 1, color: Color.Red })
        .borderRadius(8)

      Text('我是内容1')
      Text('我是内容2')
      Text('我是内容3')
    }
    .height('100%')
    .width('100%')
    .padding({ top: 50 })
    .backgroundColor(Color.White)
    .id('page')
    .bindContentCover($$this.showSnap, this.getSnapContent(), {
      modalTransition: ModalTransition.NONE
    })
  }
}