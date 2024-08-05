import { NetError, NetErrorInterceptor  } from '@abner/net';
import { showToast } from '../utils/ToastUtils';

export class MyNetErrorInterceptor extends  NetErrorInterceptor {
  httpError(error: NetError) {
    //这里进行拦截错误信息
    if (error.getCode() != 200) {
      showToast(error.getMessage())
    }
  }
}