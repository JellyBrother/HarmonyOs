// import {testChildren} from '../pages/testChildren'
import {Header} from '../../Component/CommonCOmponent'
@Entry
@Component
struct TestFather {
  @State message: string = '99999';
  @State title:string='00';

  aboutToAppear(): void {
    console.log('ymjjxs')
  }
  aboutToDisappear(): void {
    console.log('ymjjxs')
  }
  aboutToRecycle(): void {
  }


  build() {
    Column() {
      Header({title:this.title})
      testChildren({message:this.message})
    }
    .height('100%')
    .width('100%')
  }


}

@Component
struct  testChildren{
  @Prop message?: string;
  @State isSHow: boolean = true;
  build() {
    Row(){
      if(this.isSHow){
        Text(this.message)
          .onClick(() =>{
            this.isSHow = !this.isSHow
          })
      }

    }
  }
}

