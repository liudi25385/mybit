import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { Net } from '@abner/net/src/main/ets/utils/Net';
import { MyNetErrorInterceptor } from '../net/MyNetErrorInterceptor';
import { MyNetHeaderInterceptor } from '../net/MyNetHeaderInterceptor';
import { CustomNetPlugin } from '../net/CustomNetPlugin';
import { BASE_URL } from '../api/HotNewsApi';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');

    Net.getInstance().init({
      baseUrl: BASE_URL, //设置全局baseurl
      connectTimeout: 10000, //设置连接超时
      readTimeout: 10000, //设置读取超时
      netErrorInterceptor: new MyNetErrorInterceptor(), //设置全局错误拦截,需要自行创建,可在这里进行错误处理
      netHeaderInterceptor: new MyNetHeaderInterceptor(), //设置全局头拦截器,需要自行创建
      header: {}, //头参数
      resultTag: ['result'],//接口返回数据data层参数，比如data,items等等
      plugin:[new CustomNetPlugin()]//插件，类似于拦截器
    })
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
