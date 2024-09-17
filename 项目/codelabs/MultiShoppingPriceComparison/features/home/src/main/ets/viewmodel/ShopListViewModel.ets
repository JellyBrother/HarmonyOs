/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { ClassifyConstants } from '../constants/ClassifyConstants';

export class ShopListViewModel {
  private shopList: Array<ShopListItem> = [];

  constructor() {
    ClassifyConstants.SHOP_MATRIX.forEach((item: Array<string>, index: number) =>{
      let shopItemList: Array<ShopItem> = [];
      item.forEach((item: string, itemIndex: number) => {
        shopItemList.push(new ShopItem(item,ClassifyConstants.SHOP_MATRIX_IMAGE[index][itemIndex]));
      })
      this.shopList.push(new ShopListItem(ClassifyConstants.SHOP_TITLE_LIST[index], shopItemList));
    })
  }

  getShopList(): Array<ShopListItem> {
    return this.shopList;
  }
}

export class ShopItem {
  /**
   * Name of the tab.
   */
  private name: string;

  /**
   * Icon of the tab.
   */
  private image: Resource;

  constructor(name: string, image: Resource) {
    this.name = name;
    this.image = image;
  }

  getName(): string {
    return this.name;
  }

  getImage(): Resource {
    return this.image;
  }
}

export class ShopListItem {
  /**
   * Name of the ShopList.
   */
  private name: string;

  /**
   * List of the ShopList.
   */
  private ShopList: Array<ShopItem>;

  constructor(name: string, ShopList: Array<ShopItem>) {
    this.name = name;
    this.ShopList = ShopList;
  }

  getName(): string {
    return this.name;
  }

  getItem(): Array<ShopItem> {
    return this.ShopList;
  }
}

export class BannerList {
  private bannerList: Array<Resource> = [];

  constructor() {
    ClassifyConstants.BANNER_IMAGE.forEach((item: Resource, index: number)=>{
      this.bannerList.push(item)
    })
  }

  getBannerList(): Array<Resource> {
    return this.bannerList;
  }
}