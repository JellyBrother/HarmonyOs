import { ComplexTypeTest } from './ComplexTypeTest'
import { StateToProp } from './StateToProp'
import { ArrToProp } from './ArrToProp'
import { ArrToClass } from './ArrToClass'

@Component
export struct PropWatcher {
  build() {
    Column() {
      ComplexTypeTest()
      // StateToProp()
      // ArrToProp()
      ArrToClass()
    }
  }
}

