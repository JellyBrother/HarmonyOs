import router from '@ohos.router';
import {CommonHeader} from '../../components/CommonHeader'

@Entry
@Component
struct Register {
  @State password: string = ''
  @State account: string = ''
  @State password_input: string = ''
  @State account_input: string = ''

  build() {
    Column() {
      CommonHeader()
        .margin(20)

      TextInput({placeholder: "注册邮箱"})
        .margin({top:200,bottom:40})
        .width(300)
        .backgroundColor('#B0C4DE')
        .type(InputType.Email)
        .height(50)
        .onChange(value => {
          console.log(value)
          this.account_input = value
        })

      TextInput({placeholder: "注册密码"})
        .width(300)
        .backgroundColor('#B0C4DE')
        .type(InputType.Password)
        .height(50)
        .onChange(value => {
          console.log(value)
          this.password_input = value
        })

      Button('注册并登录')
        .margin({top:50})
        .width(150)


    }
  }
}
