import { HOST, USER_DATA, UserDataInterface } from '../constants/Constants';

@Component
export default struct AvaterComponent {
  @StorageLink(USER_DATA) userData: UserDataInterface = null;
  @Prop dimensions: number;

  build() {
    Image(this.userData?.avater ? HOST + this.userData.avater : $r('app.media.default_avater'))
      .height(this.dimensions)
      .width(this.dimensions)
      .borderRadius(this.dimensions).onClick(() => {
      // router.pushUrl({
      //   url: 'moviemusic/movie/pages/MovieUserPage', // 目标url
      // }, router.RouterMode.Standard, (err) => {
      //   if (err) {
      //     console.error(`Invoke showAlertBeforeBackPage failed, code is ${err.code}, message is ${err.message}`);
      //   }
      // });
    })
  }
}