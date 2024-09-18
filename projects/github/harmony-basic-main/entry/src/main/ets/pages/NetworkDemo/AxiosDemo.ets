import axios, { AxiosResponse } from '@ohos/axios'

@Entry
@Component
struct AxiosDemo {
  async getList() {
    const res = await axios.get<object, AxiosResponse<object, null>>('https://zhousg.atomgit.net/harmonyos-next/takeaway.json')
    AlertDialog.show({ message: JSON.stringify(res.data) })
  }

  aboutToAppear(): void {
    this.getList()
  }

  build() {
    Row() {
    }
    .height('100%')
  }
}