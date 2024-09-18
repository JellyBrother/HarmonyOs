import NavPathStackChat from './components/NavPathStackChat'
import NavPathStackContacts from './components/NavPathStackContacts'
import NavPathStackFriend from './components/NavPathStackFriend'
import NavPathStackMy from './components/NavPathStackMy'

@Entry
@Component
struct NavPathStackDemo {
  @Provide
  pathStack: NavPathStack = new NavPathStack()
  list: NavItem[] = [
    { name: 'Chat', title: '聊天' },
    { name: 'Contacts', title: '联系人' },
    { name: 'Friend', title: '朋友圈' },
    { name: 'My', title: '我的' },
  ]

  @Builder
  getContextUI(name: string) {
    if (name === "Chat") {
      NavPathStackChat()
    }
    else if (name === "Contacts") {
      NavPathStackContacts()
    }
    else if (name === "Friend") {
      NavPathStackFriend()
    }
    else if (name === "My") {
      NavPathStackMy()
    }
  }

  build() {
    Navigation(this.pathStack) {
      GridRow({ columns: 2 }) {
        ForEach(this.list, (item: NavItem) => {
          GridCol() {
            Text(item.title)
              .height('100%')
              .fontColor(Color.White)
          }
          .height(100)
          .backgroundColor(Color.Green)
          .margin(5)
          .borderRadius(8)
          .onClick(() => {
            // this.pathStack.pushPath({ name: item.name })
            this.pathStack.pushPathByName(item.name, null)
          })
        })
      }
      .padding(5)
    }
    .title("微信主页")
    .titleMode(NavigationTitleMode.Mini)
    .navDestination(this.getContextUI)
  }
}

interface NavItem {
  name: string
  title: string
}

