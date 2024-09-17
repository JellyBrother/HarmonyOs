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

import { LiveConstants } from '../constants/LiveConstants';

export class ShopCarModel {
  private shopCarProductList: ShopCarProduct[] = [];
  private shopCarIconList: ShopCarIcon[] = [];

  constructor() {
    LiveConstants.SHOP_CAR_PRODUCT_NAME_LIST.forEach((item: string, index: number) => {
      this.shopCarProductList.push(new ShopCarProduct(LiveConstants.SHOP_CAR_PRODUCT_IMAGE_LIST[index], item,
        LiveConstants.SHOP_CAR_PRODUCT_REMARK_LIST[index], LiveConstants.SHOP_CAR_PRODUCT_DISCOUNTS_LIST[index],
        LiveConstants.SHOP_CAR_PRODUCT_PRICE_LIST[index]));
    });

    LiveConstants.SHOP_CAR_ICON_RESOURCES.forEach((item: Resource, index: number) => {
      this.shopCarIconList.push(new ShopCarIcon(item, LiveConstants.SHOP_CAR_ICON_NAMES[index]));
    });
  }

  getShopCarProductList(): ShopCarProduct[] {
    return this.shopCarProductList;
  }

  getShopCarIconList(): ShopCarIcon[] {
    return this.shopCarIconList;
  }
}

export class ShopCarProduct {
  private image: Resource;
  private name: string;
  private remark: string;
  private discounts: string[];
  private price: number;

  constructor(image: Resource, name: string, remark:string, discounts:string[], price: number) {
    this.name = name;
    this.image = image;
    this.remark = remark;
    this.discounts = discounts;
    this.price = price;
  }

  getName(): string {
    return this.name;
  }

  getImage(): Resource {
    return this.image;
  }

  getPrice(): number {
    return this.price;
  }

  getRemark(): string{
    return this.remark;
  }

  getDiscounts(): string[]{
    return this.discounts;
  }
}

export class ShopCarIcon {
  private icon: Resource;
  private name: string;

  constructor(icon: Resource, name: string) {
    this.icon = icon;
    this.name = name;
  }

  getIcon(): Resource {
    return this.icon;
  }

  getName(): string {
    return this.name;
  }
}