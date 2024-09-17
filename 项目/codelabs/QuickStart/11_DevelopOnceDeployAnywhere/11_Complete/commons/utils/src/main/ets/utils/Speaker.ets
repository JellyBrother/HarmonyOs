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

import { textToSpeech } from '@kit.CoreSpeechKit';
import { BusinessError, emitter } from '@kit.BasicServicesKit';

export class Speaker {
  ttsEngine?: textToSpeech.TextToSpeechEngine;

  extraParam: Record<string, Object> = {
    "queueMode": 0,
    "speed": 1,
    "volume": 2,
    "pitch": 1,
    "languageContext": 'zh-CN',
    "audioType": "pcm",
    "soundChannel": 3,
    "playType": 1
  };
  initParamsInfo: textToSpeech.CreateEngineParams = {
    language: 'zh-CN',
    person: 0,
    online: 1,
    extraParams: {"style": 'interaction-broadcast', "locate": 'CN', "name": 'EngineName'}
  };

  speakParams: textToSpeech.SpeakParams = {
    requestId: Date.now().toString(),
    extraParams: this.extraParam
  };
  speakListener?: textToSpeech.SpeakListener;

  constructor() {
    this.initListener()
    this.createEngine()
  }
  initListener() {
    this.speakListener = {
      onStart(requestId: string, response: textToSpeech.StartResponse) {
      },

      onComplete(requestId: string, response: textToSpeech.CompleteResponse) {
        if (response.type === 1) {
          emitter.emit("eventId");
        }
      },

      onStop(requestId: string, response: textToSpeech.StopResponse) {
        if (response.type === 1) {
          emitter.emit("eventId");
        }
      },

      onData(requestId: string, audio: ArrayBuffer, response: textToSpeech.SynthesisResponse) {
      },

      onError(requestId: string, errorCode: number, errorMessage: string) {
      }
    };
  }

  createEngine() {
    try {
      textToSpeech.createEngine(this.initParamsInfo,
        (err: BusinessError, textToSpeechEngine: textToSpeech.TextToSpeechEngine) => {
          if (!err) {
            this.ttsEngine = textToSpeechEngine;
            this.ttsEngine.setListener(this.speakListener);
          } else {
          }
        });
    } catch (error) {
      let message = (error as BusinessError).message;
      let code = (error as BusinessError).code;
    }
  }

  startSpeak(content: string) {
    this.createEngine();
    this.ttsEngine?.speak(content, this.speakParams);
  }

  stopSpeak() {
    this.shutdownEngine();
    this.ttsEngine?.stop();
  }

  shutdownEngine() {
    this.ttsEngine?.shutdown();
  }
}