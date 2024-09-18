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
import hilog from '@ohos.hilog';

// import { hilog } from '@kit.PerformanceAnalysisKit';

export class Log {
  private static instance: Log;
  private domain: number;
  private prefix: string;
  private format: string = "%{public}s, %{public}s";

  private constructor() {
    this.prefix = 'Log*-*-';
    this.domain = 0xFF00;
  }

  public static getInstance(): Log {
    if (!this.instance) {
      this.instance = new Log()
    }
    return this.instance;
  }

  public debug(...args: Object[]): void {
    hilog.debug(this.domain, this.prefix, this.format, args);
  }

  public info(...args: Object[]): void {
    hilog.info(this.domain, this.prefix, this.format, args);
  }

  public warn(...args: Object[]): void {
    hilog.warn(this.domain, this.prefix, this.format, args);
  }

  public error(...args: Object[]): void {
    hilog.error(this.domain, this.prefix, this.format, args);
  }
}

let Logger: Log = Log.getInstance()
export default Logger

// export default Logger.getInstance()

// export default {
//   Logger: LogUtil.getInstance()
// }
