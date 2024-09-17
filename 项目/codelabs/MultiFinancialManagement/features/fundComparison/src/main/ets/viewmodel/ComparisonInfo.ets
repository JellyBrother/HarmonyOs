/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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

/**
 * Comparison information entity class.
 */
export class ComparisonInfo {
  name: ResourceStr;
  code: ResourceStr;
  type: ResourceStr;
  establishedTime: ResourceStr;
  scale: number;
  risksLevel: ResourceStr;
  rating: number;
  dividends: number;
  dividendsCount: number;
  fundManager: ResourceStr;

  constructor(name: ResourceStr, code: ResourceStr, type: ResourceStr, establishedTime: ResourceStr, scale: number,
    risksLevel: ResourceStr, rating: number, dividends: number, dividendsCount: number, fundManager: ResourceStr) {
    this.name = name;
    this.code = code;
    this.type = type;
    this.establishedTime = establishedTime;
    this.scale = scale;
    this.risksLevel = risksLevel;
    this.rating = rating;
    this.dividends = dividends;
    this.dividendsCount = dividendsCount;
    this.fundManager = fundManager;
  }
}