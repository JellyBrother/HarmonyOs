import router from '@ohos.router';

@Component
export default struct HeadImg {
  @Prop hasLogin: boolean;
  @Prop headImgSrc: string;
  @StorageLink('phone') phone: string = '';
  // 没有登录时默认使用的头像
  // defHeadImg: Resource = $r("app.rawfile.portrait.portrait_03");
  defHeadImg: Resource =  $rawfile('portrait/portrait_28.jpg');

  build() {
    Stack({ alignContent: Alignment.Center }) {
      // 背景
      Row() {
      }
      .width('100%')
      .height('100%')
      .backgroundImage(
        this.hasLogin ? $rawfile(this.headImgSrc) : this.defHeadImg,
        ImageRepeat.NoRepeat
      )
      .backgroundImageSize({ width: '100%', height: '100%' })
      .backgroundImagePosition({ x: '0px', y: '0px' })
      .opacity(0.1)

      Flex({
        direction: FlexDirection.Column,
        justifyContent: FlexAlign.Center,
        alignItems: ItemAlign.Center
      }) {
        // 头像
        Image(this.hasLogin ? $rawfile(this.headImgSrc) : this.defHeadImg)
          .width('100vp')
          .height('100vp')
          .borderRadius('20deg')
          .onClick((!this.hasLogin && !this.phone) ? () => {
            router.pushUrl({ url: 'pages/LoginPage' })
          } : null)
        // 昵称
        Text(this.hasLogin ? this.phone : '未登录')
          .fontWeight(600)
          .margin({ top: '30px' })
          .onClick(() => {
            !this.hasLogin && router.pushUrl({ url: 'pages/LoginPage' })
          })
      }
    }.width('100%')
    .height('40%')
  }
}

