import { Header } from "../components/Header"
import React from "react";
import { StyleSheet, View, ScrollView } from "react-native";
// import FastImage, {
//   ResizeMode,
//   OnLoadEvent,
//   OnProgressEvent,
// } from "react-native-fast-image";
import FastImage from "@react-native-oh-tpl/react-native-fast-image"

interface IItem {
  name: string, image: string, price: number, discount: number
}

class Item {
  name: string;
  image: string;
  price: number;
  discount: number;

  constructor(name: string, image: string, price: number, discount: number) {
    this.name = name;
    this.image = image;
    this.price = price;
    this.discount = discount;
  }
}

// 全局函数
/*
@Builder function ItemCard (item: IItem) {
  Row() {
    Row({ space: 20}) {
      Column() {
        Image('https://assets.wangxiao.net/images/customer/customer.png').width(100).height(100)
      }.height(100).justifyContent(FlexAlign.Center)
      Column({space: 15}) {
        Text(item.name)
        Text(item.price.toFixed(0))
        if(item.discount) {
          Text(`折扣：${item.discount}`)
        } else {
          Text(`无折扣`)
        }

      }.justifyContent(FlexAlign.Center).width(200).alignItems(HorizontalAlign.Start)
    }.width('90%').backgroundColor('green').alignItems(VerticalAlign.Center).height(120).justifyContent(FlexAlign.Center)
  }.width('100%').justifyContent(FlexAlign.Center)
}
*/

// // 全局样式
// @Styles function CommonStyle() {
//   .width('100%').backgroundColor('#a34343')
// }

@Extend(Text) function CommonText() {
  .fontSize(40).fontColor('#679809')
}

class Person {
  public  name: string;
  public age: number;
  friend: Person | null;

  constructor(name: string, age: number, friend?: Person) {
    this.name = name;
    this.age = age;
    this.friend = friend || null;
  }
}

@Entry
@Component
struct Index {
  // @State message: string = 'Hello World 1000';
  // @State ImageWidth: number = 100;
  public count = 1;
  @State friends: Person[] = [
    new Person('Tom', 23),
    new Person('Tank', 24)
  ];
  build() {
    RelativeContainer() {
      Column({ space: 20}) {
        Text('Alan的好友列表')
        Button('添加好友').onClick(()=> {
          this.friends.push(new Person(`Rota-${this.count++}`, 25))
        })
        ForEach(this.friends, (item: Person, index: number)=> {
          Row() {
            Text(`${item.name}: ${item.age}`)
            Button('删除好友').onClick(()=> {
              this.friends.splice(index, 1);
            })
          }
        })
      }

    }
  }
  // 全局样式
  @Styles CommonSomeStyle() {
    .width('100%').backgroundColor('#123456')
  }

}