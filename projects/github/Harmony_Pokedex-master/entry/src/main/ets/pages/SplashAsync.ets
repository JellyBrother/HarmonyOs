import { router } from '@kit.ArkUI';
import { RouteConstants } from './RouteConstants';
import { SplashViewModel } from '../viewmodel/SplashViewModel';
import { SplashConstants } from '../viewmodel/SplashConstants';

let storage: LocalStorage = new LocalStorage();
let splashViewModel: SplashViewModel = new SplashViewModel(storage)

@Entry(storage)
@Component
struct SplashAsync {

  @LocalStorageProp(SplashConstants.SPLASH_END)
  @Watch('onSplashEnd')
  splashEnd: boolean = false;

  // @Watch callback
  onSplashEnd(splashEnd: boolean): void {
    if (splashEnd) {
      console.info('splashEnd');
      router.replaceUrl({ url: RouteConstants.POKE_LIST })
    }
  }

  build() {
    RelativeContainer() {
      if (this.splashEnd) {
        Text("End")
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .alignRules({
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })
      }
      Text('Pokedex')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          console.info('text click');
        })
    }
    .height('100%')
    .width('100%')
    .onAppear(() => {
      console.log('on appear')
      splashViewModel.performLongRunningTask()
    })
  }
}
