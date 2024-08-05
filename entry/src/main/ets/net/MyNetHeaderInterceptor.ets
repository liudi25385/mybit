import { HttpHeaderOptions, NetError, NetErrorInterceptor, NetHeaderInterceptor  } from '@abner/net';

export class MyNetHeaderInterceptor extends  NetHeaderInterceptor {
  getHeader(l19: HttpHeaderOptions): Promise<Object> {
    throw new Error('Method not implemented.');
  }

}