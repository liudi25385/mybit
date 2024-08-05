import { BaseNetPlugin, NetRequest } from '@abner/net';
import http from '@ohos.net.http';

export class CustomNetPlugin extends BaseNetPlugin {
  //发送Request 请求的所有信息
  willSendRequest(request: NetRequest): void {

  }
  //收到Response响应，响应的所有信息
  didReceive(result: http.HttpResponse): void {

  }

  // 请求之前拦截请求 可以做很多操作，比如添加头参，加密等等,如果需要，可重写方法，否则不用，可删除此方法
  prepareRequest(request: NetRequest): Promise<NetRequest> {
    return new Promise((resolve: Function) => {
      resolve(request)
    });
  }
  //在这里可以修改Response信息,如果需要,可重写此方法，否则不用，可删除此方法
  processResult(request: NetRequest, result: http.HttpResponse): Promise<http.HttpResponse> {
    return new Promise((resolve: Function) => {
      resolve(result)
    });
  }
}