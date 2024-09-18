import { Navbar } from '../../components'

@Component
export default struct PassCard {
  scroller: Scroller = new Scroller()
  private qr_value: string = ''
  @State count: number = 120
  @State interval: number | null = null

  aboutToAppear(): void {
    this.startInterval()
  }

  onPageHide(): void {
    clearInterval(this.interval)
  }

  startInterval(): void {
    console.log('------触发')
    let _this = this
    this.interval = setInterval(() => {
      _this.count--
      if (_this.count === 0) {
        _this.count = 120
      }
    }, 1000)
  }
  freshQrCode = () => {
    console.log('------触发刷新')
    this.count = 120
  }

  build() {
    Scroll(this.scroller) {
      Column() {
        Navbar({
          title: '通行证',
          showMoreIcon: true,
          showOpacity: true,
          fontColor: '#fff'
        }).margin(0)
        Row() {
          Text('我的订单')
            .width(80)
            .height(32)
            .textAlign(TextAlign.Center)
            .fontColor('#fff')
            .backgroundColor('rgba(0,0,0,0.3)')
            .borderRadius(5)
            .fontSize(16)
            .fontWeight(500)
            .margin({ right: 17 })
        }.justifyContent(FlexAlign.End).width('100%').margin({ bottom: 25 })

        Column() {
          Image($r('app.media.card_bg'))
            .width(340)
            .height(567)
            .objectFit(ImageFit.Cover)
            .interpolation(ImageInterpolation.High)
          Column() {
            Image($r('app.media.avatar')).width(86).height(86).borderRadius(50).margin({ top: -30, bottom: 9 })
            Text('幼儿园里的灭霸').fontSize(18).fontFamily('AppleSystemUIFont').fontColor('#2B2144').height(21)
            Flex({ justifyContent: FlexAlign.SpaceAround, alignItems: ItemAlign.Center }) {
              Row()
                .width(90)
                .height(1)
                .borderColor('#E0DBED')
                .borderStyle(BorderStyle.Dashed)
                .borderWidth(1)
                .margin({ left: 21 })
              Text('Culture Clue').fontColor('#CAC0E0').fontWeight(400).fontSize(16)
              Row()
                .width(90)
                .height(1)
                .borderColor('#E0DBED')
                .borderStyle(BorderStyle.Dashed)
                .borderWidth(1)
                .margin({ right: 21 })
            }.margin({ top: 15 }).height(22)

            Stack() {
              Image('https://barplatform-test.oss-cn-beijing.aliyuncs.com/2024/06/185ecb2a9758c0490888cec23d7886153bqr-scan-icon.png')
              QRCode(this.qr_value).width(181).height(181)
            }.width(218).height(218).margin({ top: 15 })

            Text(`通行证二维码${this.count}秒后更新`)
              .margin({ top: 9 })
              .fontWeight(400)
              .fontSize(13)
              .fontFamily('PingFangSC, PingFang SC')
            Flex({ justifyContent: FlexAlign.SpaceAround, alignItems: ItemAlign.Center }) {
              Row()
                .width(80)
                .height(1)
                .borderColor('#E0DBED')
                .borderStyle(BorderStyle.Solid)
                .borderWidth(1)
                .margin({ left: 21 })
              Text('今日可入场权限').fontWeight(500).fontColor('#2B2144').fontSize(16)
              Row()
                .width(80)
                .height(1)
                .borderColor('#E0DBED')
                .borderStyle(BorderStyle.Solid)
                .borderWidth(1)
                .margin({ right: 21 })
            }.margin({ top: 20 }).height(22)

            Text('today’s adimission').margin({ top: 2 }).fontWeight(400).fontSize(12).fontColor('#979797')
            Row() {
              Text('暂无入场权限').margin({ right: 15 }).fontColor('#979797').fontSize(14).fontWeight(400)
              Row() {
                Image($r('app.media.fresh_icon')).width(16).height(16)
                Text('刷新').fontWeight(400).fontSize(14).fontColor('#2B2144')
              }.onClick(this.freshQrCode)
            }.margin({ top: 20 })

            Button('查看售票处')
              .width(118)
              .height(36)
              .linearGradient({
                angle: 90,
                colors: [['#9D61FD', 0], ['#4161FF', 1.0]]
              })
              .borderRadius(18)
              .margin({ top: 18 })
              .fontSize(14)
              .fontWeight(500)
              .fontColor('#fff')
          }.position({ x: 0, y: 0 }).width(340).height(567)
        }.height(567)
      }
      .backgroundImage('https://barplatform-test.oss-cn-beijing.aliyuncs.com/2024/06/1878ee6c6d778143d6b79ae47b9fd1c392msg-bg.png')
      .width('100%')
      .height('100%')
      .backgroundImageSize({ width: '100%', height: 200 })
      .backgroundColor('#121325')
    }.scrollBarColor('rgba(0,0,0,0)').height('100%')
  }
}