import NavRouterDomeA from './components/NavRouterDomeA'
import NavRouterDomeB from './components/NavRouterDomeB'

@Entry
@Component
struct NavRouterDome {
  build() {
    Navigation() {
      NavRouterDomeA()
      NavRouterDomeB()
    }
    .title('首页')
    .titleMode(NavigationTitleMode.Mini)
  }
}