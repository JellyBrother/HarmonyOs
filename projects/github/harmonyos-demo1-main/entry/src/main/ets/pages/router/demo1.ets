import router from "@ohos.router";

class Iparams {
  id: string;
  constructor(id: string) {
    this.id = id;
  }
}
console.log('----', router.getParams());

const  params: object = router.getParams();
console.log('000333---', params);

@Entry
@Component
export struct Demo1 {
  // params1: Iparams = router.getParams();
  build() {
    Column() {
      Text(`demo1-页面---`).onClick(()=> {
        console.log('000666')
        router.showAlertBeforeBackPage({
          message: '确认离开吗？'
        })
        router.back()
      })
    }
  }
}