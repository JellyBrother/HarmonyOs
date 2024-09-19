import { info } from '../../../http/Api'
import HeadImg from './HeadImg'
import SelfPageFunction from './SelfPageFunction'

@Component
export default struct Self{
  @StorageLink('token') @Watch('onTokenWatch') token: string = '';
  @State userInfo: Object = {};
  @State headImageSrc: string = 'head_img.jpg'
  @State hasLogin: boolean = false;

  // 监听 token 改变，token 存在则说明用户已经登录
  onTokenWatch(nval, oval) {
    this.hasLogin = this.token ? true : false;
  }

  build() {
    Stack({alignContent: Alignment.Bottom}) {
      // 头像区域
      Flex({direction: FlexDirection.Column, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center}) {
        HeadImg({
          hasLogin: this.hasLogin,
          headImgSrc: this.headImageSrc,
        })
      }
      .width('100%')
      .height('100%')

      // 功能区域
      Row() {
        SelfPageFunction({hasLogin: this.hasLogin})
      }.width('100%')
      .height('60%')
      .backgroundColor('f5f5f5')
      .borderRadius({topLeft: '50deg', topRight: '50deg'})
      .padding({left: '40px', right: '40px', top: '20px'})
    }
  }
}