import { SrTopNav } from '@sr/uicomponents'
import { fileIo, picker } from '@kit.CoreFileKit'
import { ImageList, ResManager } from '@sr/utils'
import { camera, cameraPicker } from '@kit.CameraKit'

const HEADER_WIDTH = 120

@Component
export struct Profile {
  @State albumList: ResourceStr[] = [
    $rawfile('Intersect.png'),
    $rawfile('Intersect-1.png'),
    $rawfile('Intersect-2.png'),
    $rawfile('Intersect-3.png'),
    $rawfile('Intersect-4.png'),
    $rawfile('Intersect-5.png'),
  ]
  @State imageList: ImageList[] = []
  @State avatar: ResourceStr = ''
  @State showPopup: boolean = false

  // 打开相册
  async selectImage() {
    const photo = new picker.PhotoViewPicker()
    const result = await photo.select({
      MIMEType: picker.PhotoViewMIMETypes.IMAGE_TYPE,
      maxSelectNumber: 1,
    })
    this.imageList = result.photoUris.map(url => ({ url } as ImageList))
    this.avatar = this.imageList[0].url
    this.showPopup = false
  }

  // 打开相机
  async openCamera() {
    const result = await cameraPicker.pick(getContext(), [
      cameraPicker.PickerMediaType.PHOTO,
    ], {
      cameraPosition: camera.CameraPosition.CAMERA_POSITION_BACK // 后置摄像头
    })
    const filePath = getContext().filesDir + "/" + Date.now() + '.'
    let extendName = "jpg"
    const file = fileIo.openSync(result.resultUri, fileIo.OpenMode.READ_ONLY)
    fileIo.copyFileSync(file.fd, filePath + extendName) // 拷贝
    fileIo.closeSync(file.fd)
    this.avatar = filePath + extendName
  }

  @Builder
  dataItemBuilder(count: number | string, label: string) {
    Column({ space: 5 }) {
      Text(count.toString()).fontWeight(700).fontColor('#525F7F').fontSize(18).fontFamily('Open Sans')
      Text(label).fontWeight(400).fontColor('#525F7F').fontSize(14).fontFamily('Open Sans')
    }
  }

  @Builder
  leftIconBuilder() {
    Image($r('app.media.ic_back')).width(26).aspectRatio(1).fillColor(Color.White)
  }

  @Builder
  getSheetBuilder() {
    List() {
      ListItem() {
        Row() {
          Text('phone album').albumTextStyles().onClick(() => {
            this.selectImage()
          })
        }
      }.width('100%')

      ListItem() {
        Row() {
          Text('watch for a chance').albumTextStyles().onClick(() => {
            this.openCamera()
          })
        }
      }.width('100%')
    }.margin({ top: 24, left: 20, right: 20 }).divider({ strokeWidth: 1, color: 'rgba(0,0,0,0.1)', })
  }

  build() {
    Column() {
      // 顶部导航
      SrTopNav({
        leftIconBuilder: this.leftIconBuilder,
        title: 'Home',
        frontColor: Color.White
      }).padding({ left: 10, right: 10 })
      Scroll() {
        Stack({ alignContent: Alignment.Top }) {
          // 头像
          Image(this.avatar || $r('app.media.ic_header_default')).headerStyles().onClick(() => {
            this.showPopup = !this.showPopup
          })
          Column() {
            // 两个标签
            Row({ space: 12 }) {
              Text('CONNECT').textStyles()
              Text('MESSAGE').textStyles().backgroundColor('#1b2c4b')
            }

            // 数据展示
            Row({ space: 30 }) {
              this.dataItemBuilder('2k', 'Friends')
              this.dataItemBuilder(10, 'Photos')
              this.dataItemBuilder(89, 'Comments')
            }.margin({ top: 30 })

            // 个人信息
            Text('Jessica Jones, 27').fontSize(28).fontColor('#32325D').margin({ top: 30 })
            Text('San Francisco, USA').fontSize(16).fontColor('#32325D').margin({ top: 5 })

            // 分隔线
            Divider().width('90%').margin({ top: 30, bottom: 20 })

            // 简介
            Text('An artist of considerable range, Jessica name taken by Melbourne 6549db175cc84261bae5ad5c8dd10662')
              .introStyles()

            // 更多
            Text('Show more').fontSize(16).fontColor('#233DD2').margin({ top: 10 })

            // 相册
            Text('Album').albumStyles()

            // View All
            Text('View All').viewAllStyles()

            // 9宫格
            Grid() {
              ForEach(this.albumList, (item: ResourceStr) => {
                GridItem() {
                  Image(item).aspectRatio(1).borderRadius(4)
                }
              })
            }.columnsTemplate('1fr 1fr 1fr').rowsGap(6).columnsGap(6).padding(12)

            // 登出
            // Button('LOGOUT')
            //   .onClick(() => {
            //     UserStore.setUser(JSON.stringify({}))
            //     router.replaceNamedRoute({
            //       name: 'LoginPage'
            //     })
            //   }).buttonStyles()

          }.columnContentStyles()
        }.padding({ left: 12, right: 12, top: 100 })
      }
    }.columnBoxStyles()
    .bindSheet($$this.showPopup, this.getSheetBuilder(), {
      showClose: true,
      detents: [180, SheetSize.MEDIUM, SheetSize.LARGE],
      height: 180
    })
  }
}

@Extend(Image)
function headerStyles() {
  .width(HEADER_WIDTH)
  .aspectRatio(1)
  .borderRadius(HEADER_WIDTH / 2)
  .zIndex(10)
  .offset({
    y: HEADER_WIDTH / -2
  })
  .shadow({
    radius: 10,
    type: ShadowType.COLOR,
    color: 'rgba(0,0,0,0.1)',
  })
}

@Extend(Column)
function columnContentStyles() {
  .backgroundColor(Color.White)
  .width('100%')
  .borderRadius(4)
  .padding({ top: 80, bottom: 80 })
  .shadow({
    radius: 10,
    type: ShadowType.COLOR,
    color: 'rgba(0,0,0,0.1)',
    offsetY: 4,
  })
}

@Extend(Column)
function columnBoxStyles() {
  .width('100%')
  .height('100%')
  .backgroundColor('#fcfcfc')
  .backgroundImage($r('app.media.profile_bg'))
  .backgroundImageSize(ImageSize.Contain)
  .backgroundImagePosition({ y: -2 })
  .justifyContent(FlexAlign.Start)
  .padding({ top: 50 })
  .rotate({
    y: 1,
    x: 0,
    angle: -0.2
  })
  .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
}


@Extend(Text)
function textStyles() {
  .fontColor(Color.White)
  .fontSize(12)
  .fontWeight(700)
  .fontFamily('Open Sans')
  .backgroundColor('#5ccbeb')
  .borderRadius(4)
  .padding({
    top: 6,
    bottom: 6,
    left: 8,
    right: 8
  })
}

@Extend(Text)
function introStyles() {
  .width('85%')
  .textAlign(TextAlign.Center)
  .fontSize(16)
  .fontColor('#525F7F')
  .lineHeight(24)
  .maxLines(2)
  .textOverflow({ overflow: TextOverflow.Ellipsis })
}

@Extend(Text)
function albumStyles() {
  .fontSize(16)
  .fontColor('#525F7F')
  .fontWeight(700)
  .width('100%')
  // .padding({  })
  .margin({ left: 30, top: 20 })
}

@Extend(Text)
function viewAllStyles() {
  .width('100%')
  .textAlign(TextAlign.End)
  .margin({ right: 30, top: 20 })
  .fontSize(12)
  .fontColor('#5E72E4')
}

@Extend(Button)
function buttonStyles() {
  .type(ButtonType.Capsule)
  .width(200)
  .backgroundColor('#4c34a0')
  .borderRadius(4)
  .margin({ top: 20 })
}

@Extend(Text)
function albumTextStyles() {
  .fontSize(20).fontWeight(500).height(50).fontColor(ResManager.COLOR_DEFAULT)
}