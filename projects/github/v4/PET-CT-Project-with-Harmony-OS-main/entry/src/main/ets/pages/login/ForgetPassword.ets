import router from '@ohos.router';
import {CommonHeader} from '../../components/CommonHeader'

@Entry
@Component
struct ForgetPassword {
  @State password: string = ''
  @State account: string = ''
  @State password_input: string = ''
  @State account_input: string = ''

  build() {
    Column() {
      CommonHeader()
        .margin(20)

      TextInput({placeholder: "登录邮箱"})
        .margin({top:200,bottom:40})
        .width(300)
        .backgroundColor('#B0C4DE')
        .type(InputType.Email)
        .height(50)
        .onChange(value => {
          console.log(value)
          this.account_input = value
        })

      TextInput({placeholder: "新密码"})
        .width(300)
        .backgroundColor('#B0C4DE')
        .type(InputType.Password)
        .height(50)
        .onChange(value => {
          console.log(value)
          this.password_input = value
        })

      Button('修改密码并登录')
        .margin({top:50})
        .width(150)


    }
  }
}