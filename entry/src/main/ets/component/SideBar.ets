import { PermissionsUtil } from '../utils/PermissionsUtil';
import { scanBarcode, scanCore } from '@kit.ScanKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { showToast } from '../utils/ToastUtils';
import { common, Want } from '@kit.AbilityKit';
import { router } from '@kit.ArkUI';


@Component
export struct SideBar {

  onClickCamera = async () => {
    let isUserGrant: boolean = await PermissionsUtil.requestCameraPermission();
    if (isUserGrant) {
      // 定义扫码参数options
      let options: scanBarcode.ScanOptions =
        { scanTypes: [scanCore.ScanType.ALL], enableMultiMode: true, enableAlbum: true };
      scanBarcode.startScanForResult(getContext(this), options).then((result: scanBarcode.ScanResult) => {
        showToast(`Succeeded in getting ScanResult by promise with options, result is ${JSON.stringify(result)}`)
      }).catch((error: BusinessError) => {
        showToast(`Failed to get ScanResult by promise with options. Code: ${error.code}, message: ${error.message}`)
      })
    } else {
      showToast('用户拒绝相机权限')
    }
  }

  context = getContext(this) as common.UIAbilityContext

  build() {
    //侧边栏
    Column({
      space: 20
    }) {
      Row() {
        TextClock({
          timeZoneOffset: -8
        }).format('aa好')

        Text() {
          ImageSpan($r('app.media.ic_scan'))
            .width(20).verticalAlign(ImageSpanAlignment.CENTER)
          Span('扫一扫').fontSize(12)
        }.padding({
          left: 5,
          right: 10,
          top: 3,
          bottom: 3
        }).backgroundColor('#fff')
        .border({
          radius: 20
        })
      }.width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .onClick(() => {
        AlertDialog.show({
          message: '扫码功能需要开启相机权限',
          title: '温馨提示',
          primaryButton: {
            value: 'ok',
            action: () => {
              this.onClickCamera()
            }
          }
        })
      })

      Column() {
        Row() {
          Text('常用小程序').fontSize(12)

          Text() {
            Span('全部').fontSize(10)
            ImageSpan($r('app.media.ic_right'))
              .width(20).verticalAlign(ImageSpanAlignment.CENTER)
          }
        }.justifyContent(FlexAlign.SpaceBetween)
        .width('100%')

        Grid() {
          GridItem() {
            Text() {
              ImageSpan($r('app.media.ic_alipay')).width(35)
              Span('\r\n支护宝').fontSize(11)
            }
          }.onClick(() => {

            //同模块Abiltiy拉起
            let wantInfo: Want = {
              deviceId: '', //空表示本设备
              bundleName: 'com.mytit.ld',
              moduleName: 'entry',
              abilityName: 'alialibity',
              parameters: {
                info: '来自mytik的参数（同模块alibity）'
              }
            }
            this.context.startAbility(wantInfo)
              .then(() => {
                showToast('启动alibity成功')
              }).catch(() => {
              showToast('启动alibity失败')
            })
          })

          GridItem() {
            Text() {
              ImageSpan($r('app.media.ic_gift')).width(35)
              Span('\r\n抽年卡').fontSize(11)
            }
          }.onClick(() => {
            //同模块Abiltiy拉起
            let wantInfo: Want = {
              deviceId: '', //空表示本设备
              bundleName: 'com.mytit.ld',
              moduleName: 'aliyearcard',
              abilityName: 'AliyearcardAbility',
              parameters: {
                info: '来自mytik的参数（跨模块alibity）'
              }
            }

            this.context.startAbility(wantInfo)
              .then(() => {
                showToast('启动alibity成功')
              }).catch(() => {
              showToast('启动alibity失败')
            })
          })

          GridItem() {
            Text() {
              ImageSpan($r('app.media.ic_scan')).width(35)
              Span('\r\n看热搜').fontSize(11)
            }
          }.onClick(() => {
            router.pushUrl({
              url: 'pages/HotNewsPage'
            })
          })

          GridItem() {
            Text() {
              ImageSpan($r('app.media.ic_login')).width(35)
              Span('\r\n登录页').fontSize(11)
            }
          }.onClick(() => {
            router.pushUrl({
              url: 'pages/LoginPage',
              params: {
                account: '188 8888 8888',
                password: '4321_jd'
              }
            }, router.RouterMode.Single, (err, data) => {
            })
          })
        }.rowsTemplate('1fr 1fr').columnsTemplate('1fr 1fr 1fr').width('100%').height(150)
      }.backgroundColor('#fff')
      .width('100%')
      .border({
        radius: 8
      }).padding(8)

    }.width('60%').backgroundColor('#fff3f3f3').padding({
      left: 20,
      right: 20,
      top: 70
    })
  }
}