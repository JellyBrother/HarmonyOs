import MyHeader from './MyHeader'
import MyMain from './MyMain'
import MyFooter from './MyFooter'

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    Column() {
      MyHeader()
      MyMain()
      MyFooter()
        .margin({
          top: 20
        })
    }
    .padding({
      top: 20,
      right: 20,
      bottom: 20,
      left: 20
    })
    .height('100%')
    .width('100%')
    .backgroundImage('images/caseday02/1/bg.png', ImageRepeat.NoRepeat)
    .backgroundImageSize(ImageSize.Cover)
    .expandSafeArea()
  }
}
