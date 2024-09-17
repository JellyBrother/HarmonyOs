// import { CourseLearning } from '@ohos/learning';
import { KnowledgeMap } from '@ohos/map';

@Entry
@Component
struct Index {
  build() {
    Column() {
      // CourseLearning()
      KnowledgeMap()
    }
    .backgroundColor('#F1F3F5')
    .padding({ top: 36, bottom: 28 })
  }
}