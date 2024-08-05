import { router } from '@kit.ArkUI';
import { webview } from '@kit.ArkWeb';

@Entry
@Component
struct WebViewPage {
  @State webInfoParams: WebInfoParams | null = null;
  controller: WebviewController = new webview.WebviewController()

  aboutToAppear(): void {
    this.webInfoParams = router.getParams() as WebInfoParams
  }

  build() {
    RelativeContainer() {
      if (this.webInfoParams != null) {
        Web({
          src: this.webInfoParams.url,
          controller: this.controller
        })
      }
    }
    .height('100%')
    .width('100%')
  }
}

export class WebInfoParams {
  url: string

  constructor(url: string) {
    this.url = url;
  }
}