import hilog from '@ohos.hilog';

// import { hilog } from '@kit.PerformanceAnalysisKit';

enum LogLevel {
  DEBUG = 'debug',
  INFO = 'info',
  WARN = 'warn',
  ERROR = 'error'
}

export class LogUtil {
  private static domain: number = 0xFF00;
  private static prefix: string = 'Log*-*-';
  private static isLogPrint: boolean = true;
  private static useConsoleLog: boolean = true;
  private static format: string = '%{public}s'

  // private static format: string = "%{public}s, %{public}s";

  // private static instance: LogUtil
  //
  // private constructor() {
  //   this.prefix = 'Log*-*-';
  //   this.domain = 0xFF00;
  // }
  //
  // public static getInstance(): LogUtil {
  //   if (!this.instance) {
  //     this.instance = new LogUtil()
  //   }
  //   return this.instance;
  // }

  static init(domain: number = 0xFF00, prefix: string = 'Log*-*-', isLogPrint: boolean = true, useConsoleLog: boolean = false): void {
    this.domain = domain
    this.prefix = prefix
    this.isLogPrint = isLogPrint
  }

  static debug(tag: string, msg: string): void {
    this.startLog(LogLevel.DEBUG, tag, msg)
  }

  static info(tag: string, msg: string): void {
    this.startLog(LogLevel.INFO, tag, msg)
  }

  static warn(tag: string, msg: string): void {
    this.startLog(LogLevel.WARN, tag, msg)
  }

  static error(tag: string, msg: string): void {
    this.startLog(LogLevel.ERROR, tag, msg)
  }

  private static startLog(logLevel: LogLevel, tag: string, msg: string): void {
    if (!this.isLogPrint) {
      return
    }
    if (this.useConsoleLog) {
      console.log(this.prefix + `  ${tag},${msg}`)
      return
    }
    if (logLevel == LogLevel.DEBUG) {
      hilog.debug(this.domain, this.prefix, this.format, `${tag},${msg}`);
    }
    if (logLevel == LogLevel.INFO) {
      hilog.info(this.domain, this.prefix, this.format, `${tag},${msg}`);
    }
    if (logLevel == LogLevel.WARN) {
      hilog.warn(this.domain, this.prefix, this.format, `${tag},${msg}`);
    }
    if (logLevel == LogLevel.ERROR) {
      hilog.error(this.domain, this.prefix, this.format, `${tag},${msg}`);
    }
  }
}

// export function debug(...args: Object[]): void {
//   LogUtil.debug(args)
// }
//
// export function info(...args: Object[]): void {
//   LogUtil.info(args)
// }
//
// export function warn(...args: Object[]): void {
//   LogUtil.warn(args)
// }
//
// export function error(...args: Object[]): void {
//   LogUtil.error(args)
// }

// export {
//   debug
// } from LogUtil

// let Logger: LogUtil = LogUtil.getInstance()
// export default Logger

// export default LogUtil.getInstance()

// export default {
//   Logger: LogUtil.getInstance()
// }