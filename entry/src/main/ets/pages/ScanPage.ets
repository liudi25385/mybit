import { hilog } from '@kit.PerformanceAnalysisKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { scanBarcode, customScan } from '@kit.ScanKit';

@Entry
@Component
struct ScanPage {
  // 设置预览流高度，默认单位：vp
  @State cameraHeight: number = 640;
  // 设置预览流宽度，默认单位：vp
  @State cameraWidth: number = 360;
  private mXComponentController: XComponentController = new XComponentController();

  build() {
    Stack() {
      XComponent({
        id: 'componentId',
        type: 'surface',
        controller: this.mXComponentController
      })
        .onLoad(() => {
          hilog.info(0x0001, '[Scan Sample]', 'onLoad is called')
          // 获取XComponent的surfaceId
          let surfaceId: string = this.mXComponentController.getXComponentSurfaceId();
          hilog.info(0x0001, 'viewControl', `onLoad surfaceId: ${surfaceId}`);
          // 设置ViewControl相应字段
          let viewControl: customScan.ViewControl = {
            width: this.cameraWidth,
            height: this.cameraHeight,
            surfaceId: surfaceId
          };
          customScan.start(viewControl).then((scanResult: Array<scanBarcode.ScanResult>) => {
            hilog.info(0x0001, '[Scan Sample]', `Succeeded in getting ScanResult by promise, scanResult is ${JSON.stringify(scanResult)}`);
          }).catch((error: BusinessError) => {
            hilog.error(0x0001, '[Scan Sample]',
              `Failed to get ScanResult by promise. Code: ${error.code}, message: ${error.message}`);
          })
        })// 预览流宽、高，默认单位vp，支持px、lpx、vp
        .height(this.cameraHeight)
        .width(this.cameraWidth)
        .position({ x: 0, y: 0 })
    }
    .alignContent(Alignment.Bottom)
    .height('100%')
    .width('100%')
    .position({ x: 0, y: 0 })
  }
}