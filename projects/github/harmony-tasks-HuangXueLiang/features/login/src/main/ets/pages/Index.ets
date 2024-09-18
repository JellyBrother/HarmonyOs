import { SrTopNav } from '@sr/uicomponents';
import { PasswordStrength, ResManager, UserInfo, UserInfoModel } from '@sr/utils';
import { promptAction, router } from '@kit.ArkUI';
import { UserStore } from '@sr/datastore';

class FormItem {
  @Track
  name: string = ''
  @Track
  mail?: string = ''
  @Track
  pwd: string = ''
  @Track
  pwdConfirm?: string = ''
}


/**
 * 设置密码强度样式Map
 */
const passwordStrengthMap: Record<string, ResourceStr> = {
  [PasswordStrength.STRONG]: ResManager.COLOR_SUCCESS,
  [PasswordStrength.MEDIUM]: ResManager.COLOR_WARNING,
  [PasswordStrength.WEAK]: ResManager.COLOR_DANGER,
}

@Entry({ routeName: 'LoginPage' })
@Component
export struct Index {
  @State message: string = 'Hello World';
  @State name: string = ''
  @State mail: string = ''
  @State pwd: string = ''
  @State pwdConfirm: string = ''
  @State agreeFlag: boolean = false
  @State isLogin: boolean = true
  @State userInfo: UserInfo = new UserInfoModel({} as UserInfo)

  goLogin() {
    if (!this.agreeFlag) {
      promptAction.showToast({ message: 'Please choose to agree' })
      return
    }
    if (this.name === 'hxl' && this.pwd === '123') {
      this.userInfo = new UserInfoModel({
        userName: this.name,
        age: 18,
        avatar: 'http://gips2.baidu.com/it/u=195724436,3554684702&fm=3028&app=3028&f=JPEG&fmt=auto?w=1280&h=960'
      })
      UserStore.setUser(JSON.stringify(this.userInfo))
      router.pushUrl({
        url: 'pages/Index'
      })
    } else {
      promptAction.showToast({ message: '用户名或密码错误' })
    }
  }

  goRegister() {

  }

  @Builder
  leftIconBuilder() {
    Image($r('app.media.ic_back')).width(26).aspectRatio(1).fillColor(Color.White)
  }

  build() {
    Column() {
      // 顶部导航
      SrTopNav({
        leftIconBuilder: this.leftIconBuilder,
        title: 'Home',
        frontColor: Color.White
      }).padding({ top: 15 })

      Column() {
        Column() {
          Text('Sign up with').titleStyle()
          Row({ space: 10 }) {
            Row({ space: 14 }) {
              Image($r('app.media.ic_github')).iconStyle()
              Text('GITHUB').textStyle()
            }.rowStyle()

            Row({ space: 14 }) {
              Image($r('app.media.ic_google')).iconStyle()
              Text('GOOGLE').textStyle()
            }.rowStyle()
          }.margin({ top: 20, bottom: 40 })
        }
        .backgroundColor('#ffffff')
        .width('100%')
        .borderRadius({ topLeft: 5, topRight: 5 })
        .border({ width: { bottom: 1 }, color: 'rgba(0,0,0,0.1)' })

        Text('Or sign up with credentials').titleStyle()

        Stack({ alignContent: Alignment.Start }) {
          TextInput({ text: $$this.name, placeholder: 'Name' }).textInputStyle()
          Image($r('app.media.ic_name')).iconInputStyle()
        }.stackStyle()

        if (!this.isLogin) {
          Stack({ alignContent: Alignment.Start }) {
            TextInput({ text: $$this.mail, placeholder: 'Email' }).textInputStyle()
            Image($r('app.media.ic_email')).iconInputStyle()
          }.stackStyle()
        }

        Stack({ alignContent: Alignment.Start }) {
          TextInput({ text: $$this.pwd, placeholder: 'Password' }).type(InputType.Password).textInputStyle()
          Image($r('app.media.ic_lock')).iconInputStyle()
        }.stackStyle()

        Row({ space: 3 }) {
          Text('password strength:').titleStyle().margin({ top: 20 })
          Text('Strong').strengthStyle(PasswordStrength.STRONG)
        }.width('100%').padding({ left: 22 })

        Row({ space: 5 }) {
          Checkbox()
            .shape(CheckBoxShape.ROUNDED_SQUARE)
            .select($$this.agreeFlag)
            .selectedColor(ResManager.COLOR_PRIMARY)
          Text('I agree with the ').fontSize(14).fontColor(ResManager.COLOR_DEFAULT)
          Text('Privacy Policy').fontSize(14).fontColor(ResManager.COLOR_PRIMARY)
        }.width('100%').justifyContent(FlexAlign.Start).margin({ top: 30, left: 26 })

        Row({ space: 12 }) {
          Button(this.isLogin ? 'LOGIN' : 'CREATE ACCOUNT')
            .onClick(() => {
              if (this.isLogin) {
                this.goLogin()
                return
              }
              this.goRegister()
            })
            .type(ButtonType.Normal)
            .borderRadius(4)
            .backgroundColor('#6075dd')

          Text(this.isLogin ? 'create account' : 'go login').fontSize(14)
            .fontColor(ResManager.COLOR_PRIMARY)
            .onClick(() => {
              animateTo({ duration: 300 }, () => {
                this.isLogin = !this.isLogin
              })
            })
        }.alignItems(VerticalAlign.Center).margin({ top: 30, bottom: 40 })
      }
      .width('100%')
      .backgroundColor('#f4f5f7')
      .margin({ top: 50 })
      .borderRadius(5)
    }
    .width('100%')
    .height('100%')
    .padding(12)
    .backgroundImage($r('app.media.login_bg'))
    .backgroundImageSize(ImageSize.FILL)
    .justifyContent(FlexAlign.Start)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

@Extend(Text)
function titleStyle() {
  .fontColor('#8898AA')
  .fontFamily('Open Sans')
  .fontSize(12)
  .margin({ top: 40 })
}

@Extend(Image)
function iconStyle() {
  .width(22)
  .aspectRatio(1)
}

@Extend(Text)
function textStyle() {
  .fontSize(18)
  .fontWeight(600)
  .fontFamily('Open Sans')
  .fontColor('#5E72E4')
}

@Extend(Row)
function rowStyle() {
  .width(140)
  .height(44)
  .justifyContent(FlexAlign.Center)
  .borderRadius(4)
  .shadow({
    radius: 15,
    type: ShadowType.COLOR,
    color: 'rgba(0,0,0,0.2)',
    offsetY: 10,
  })
}

@Extend(TextInput)
function textInputStyle() {
  .borderRadius(4).backgroundColor('#fff').padding({ left: 42 })
}

@Extend(Image)
function iconInputStyle() {
  .width(18).aspectRatio(1).margin({ left: 12 })
}

@Extend(Text)
function strengthStyle(strength: PasswordStrength) {
  .titleStyle()
  .margin({ top: 20 })
  .fontColor(passwordStrengthMap[strength])
}

@Styles
function stackStyle() {
  .margin({ left: 16, right: 16, top: 20 })
}