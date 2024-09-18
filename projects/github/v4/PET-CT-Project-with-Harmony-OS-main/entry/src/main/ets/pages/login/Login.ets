import router from '@ohos.router';
import UserModel from '../../model/UserModel'
import UserTable from '../../database/UserInfoTable'

@Entry
@Component
struct Login {
  @State message1: string = 'PET-CT医学图像分析平台'
  @State message2: string = '请登录/注册'

  @State password_input: string = ''
  @State account_input: string = ''



  build() {
    Column() {

      //Show the welcome text
      Text(this.message1)
        .margin({top:150})
        .fontColor("#36D")
        .fontSize(25)

      Text(this.message2)
        .margin({top:50})
        .fontSize(25)
        .fontWeight(FontWeight.Bold)

      //input account and  password
      TextInput({placeholder: '请输入您的邮箱'})
        .margin({top:50,bottom:20})
        .width(300)
        .backgroundColor('#B0C4DE')
        .type(InputType.Email)
        .height(40)
        .onChange(value => {
          console.log(value)
          this.account_input = value
        })

      TextInput({placeholder: '请输入您的密码'})
        .width(300)
        .backgroundColor('#B0C4DE')
        .type(InputType.Password)
        .height(40)
        .onChange(value => {
          console.log(value)
          this.password_input = value
        })

      //LoginButton
      Button("登录")
        .margin({top:50})
        .width(260)
        .onClick(() => {

        })

      //register or forget password
      Row() {
        Text("注册")
          .margin({top:20, right: 50})
          .onClick(() => {
            router.pushUrl({
              url: 'pages/Register'
            })
          })

        Text("忘记密码")
          .margin({top:20})
          .onClick(() => {
            router.pushUrl({
              url: 'pages/ForgetPassword'
            })
          })
      }

    }
    .width('100%')
  }
}