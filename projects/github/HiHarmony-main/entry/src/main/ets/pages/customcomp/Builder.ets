import { ChildTmp, overBuilder, Tmp } from '../../component/GlobalBuilder'

@Entry
@Component
struct PrivateBuilder {
  @State builder_value: string = 'hello'
  @State objParam: Tmp = new Tmp();

  /**
   * 私有自定义构建函数
   */
  @Builder
  builder() {
    Column() {
      Text(this.builder_value)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
    }
  }

  aboutToAppear(): void {
    setTimeout(() => {
      this.builder_value = 'Hello World'
    }, 3000)
  }

  build() {
    Row() {
      Column() {
        Text(this.builder_value)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
        this.builder()
        Button('点击改变builder_value内容')
          .onClick(() => {
            this.builder_value = 'builder_value被点击了'
          })
        overBuilder({
          str_value: this.objParam.str_value,
          num_value: this.objParam.num_value,
          tmp_value: this.objParam.tmp_value,
          arrayTmp_value: this.objParam.arrayTmp_value
        })
        Button('点击改变全局自定义构建函数的参数值')
          .onClick(() => {
            this.objParam.str_value = 'Hello World'
            this.objParam.num_value = 1
            this.objParam.tmp_value.val = 8
            const child_value: ChildTmp = {
              val:2
            }
            this.objParam.arrayTmp_value.push(child_value)
          })
      }
    }
  }
}