import { http } from '@kit.NetworkKit'

@Entry
@Component
struct HttpDemo {
  @State
  list: object[] = []

  async sendHttp() {
    const req = http.createHttp()
    const res = await req.request('https://zhousg.atomgit.net/harmonyos-next/takeaway.json')
    this.list = JSON.parse(res.result as string)
    req.destroy()
  }

  aboutToAppear(): void {
    this.sendHttp()
  }

  build() {
    Column() {
      Text(JSON.stringify(this.list))
    }
    .height('100%')
  }
}