import { TutorialView } from '../view/TutorialView';
import { ArticleClass } from '../model/ArticleClass'
import { ArticleDetailPage } from './ArticleDetailPage';
import { Banner } from '../view/Banner';
import { EnablementView } from '../view/EnablementView';
import { BannerDetailPage } from './BannerDetailPage';
import { BannerClass } from '../model/BannerClass';
import { Header } from '../view/Header';

@Component
export struct QuickStartPage {
  @Provide('articlePathStack') articlePathStack: NavPathStack = new NavPathStack();

  @Builder
  quickStartRouter(name: string, param?: ArticleClass | BannerClass) {
    if (name === 'articleDetail') {
      ArticleDetailPage()
    } else if (name === 'bannerDetailPage') {
      BannerDetailPage()
    }
  }

  build() {
    Navigation(this.articlePathStack) {
      Column() {
        Header()
        Scroll() {
          Column() {
            Banner()
            EnablementView()
            TutorialView()
          }
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .align(Alignment.TopStart)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F1F3F5')
    }
    .navDestination(this.quickStartRouter)
    .hideTitleBar(true)
    .mode(NavigationMode.Stack)
  }
}