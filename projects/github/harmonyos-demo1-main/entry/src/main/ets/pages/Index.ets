import router from "@ohos.router"

class RouterInfo {
  url: string;
  title: string;
  constructor(url: string, title: string) {
    this.url = url;
    this.title = title;
  }
}

@Entry
@Component
export struct Router {
  private routers: RouterInfo[] = [
    new RouterInfo("pages/router/demo1", "demo1标题"),
    new RouterInfo("pages/router/demo2", "demo2标题"),
    new RouterInfo("pages/router/demo3", "demo3标题"),
    new RouterInfo("pages/IndexPage", "indexpage标题"),
    new RouterInfo("pages/router/Demo5", "demo5标题")

  ]

  @Builder
  RouterItem(r: RouterInfo, i: number) {
    Row() {
      Text(r.title)
    }.onClick(()=> {
      console.log('000111--', r.url)

      router.pushUrl({
        url: r.url,
        params: {
          a: 1
        }
      }, router.RouterMode.Single, err=> {
        if(err) {
          console.log('路由跳转失败---', err.code, err.message)
        }
      })
    })
  }
  build() {
    Column() {
      List({ space: 15}) {
        ForEach(this.routers, (r: RouterInfo, index: number)=> {
          ListItem() {
            this.RouterItem(r, index);
          }
        })
      }
    }
  }
}