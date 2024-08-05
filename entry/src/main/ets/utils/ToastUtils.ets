import { promptAction } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

export function showToast(content: string){
  try {
    promptAction.showToast({
      message: content,
      duration: 2000
    });
  } catch (error) {
    let message = (error as BusinessError).message
    let code = (error as BusinessError).code
    console.error('TOAST', `showToast args error code is ${code}, message is ${message}`);
  };
}