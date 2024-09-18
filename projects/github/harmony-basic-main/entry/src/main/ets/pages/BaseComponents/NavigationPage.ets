import NavRouterDomeA from '../NavDemo/components/NavRouterDomeA'
import NavRouterDomeB from '../NavDemo/components/NavRouterDomeB'

@Entry
@Component
struct NavigationPage {
  build() {
    Navigation() {
      NavRouterDomeA()
      NavRouterDomeB()
    }
    .title('首页')
    .titleMode(NavigationTitleMode.Mini)
  }
}