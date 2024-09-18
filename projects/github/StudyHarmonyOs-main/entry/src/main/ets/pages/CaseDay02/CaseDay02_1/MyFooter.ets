@Component
export default struct MyFooter {
  build() {
    Column({ space: 20 }) {
      Row({ space: 5 }) {
        Row({ space: 5 }) {
          Column({ space: 2 }) {
            Text('灵魂匹配')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
            Text('和懂你的人聊天')
              .fontSize(12)
          }
          .alignItems(HorizontalAlign.Start)

          Image('images/caseday02/1/soul.png')
            .width(46)
        }
        .padding(10)
        .backgroundColor('#f8f2ff')
        .borderRadius(10)

        Row({ space: 5 }) {
          Column({ space: 2 }) {
            Text('有趣的人')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
            Text('发现有趣的灵魂')
              .fontSize(12)
          }
          .alignItems(HorizontalAlign.Start)

          Image('images/caseday02/1/interesting.png')
            .width(46)
        }
        .padding(10)
        .backgroundColor('#fff2e6')
        .borderRadius(10)
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .height(76)

      Row() {
        Image('https://cdn7.axureshop.com/demo2024/2309596/images/%E9%A6%96%E9%A1%B5/u767.svg')
          .width(27)

        Stack() {
          Image('https://cdn7.axureshop.com/demo2024/2309596/images/%E9%A6%96%E9%A1%B5/u770.svg')
            .width(24)
          Image('https://cdn7.axureshop.com/demo2024/2309596/images/%E9%A6%96%E9%A1%B5/u771.svg')
            .width(9)
        }

        Stack() {
          Image('https://cdn7.axureshop.com/demo2024/2309596/images/%E9%A6%96%E9%A1%B5/u774.svg')
            .width(25)
          Row({ space: 2.5 }) {
            Image('https://cdn7.axureshop.com/demo2024/2309596/images/%E9%A6%96%E9%A1%B5/u775.svg')
              .width(3)
            Image('https://cdn7.axureshop.com/demo2024/2309596/images/%E9%A6%96%E9%A1%B5/u775.svg')
              .width(3)
            Image('https://cdn7.axureshop.com/demo2024/2309596/images/%E9%A6%96%E9%A1%B5/u775.svg')
              .width(3)
          }
        }

        Stack() {
          Image('https://cdn7.axureshop.com/demo2024/2309596/images/%E9%A6%96%E9%A1%B5/u770.svg')
            .width(24)
          Row({ space: 2.5 }) {
            Image('https://cdn7.axureshop.com/demo2024/2309596/images/%E9%A6%96%E9%A1%B5/u781.svg')
              .width(4)
            Image('https://cdn7.axureshop.com/demo2024/2309596/images/%E9%A6%96%E9%A1%B5/u781.svg')
              .width(4)
          }
          .margin({
            top: -6,
            right: -2
          })
        }
      }
      .padding({
        top: 10
      })
      .justifyContent(FlexAlign.SpaceAround)
      .width('100%')
      // .height(80)
      .borderWidth({
        top: 1
      })
      .borderColor('#f0f0f0')
    }
  }
}