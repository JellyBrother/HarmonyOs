// 导入模块
import { worker } from '@kit.ArkTS';

// API 9及之后版本使用：
const worker1: worker.ThreadWorker = new worker.ThreadWorker('entry/ets/workers/MyWorker.ets');