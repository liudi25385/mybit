import { router } from '@kit.ArkUI';
import { ParamsObj } from '../model/ParamsObj';
import { showToast } from '../utils/ToastUtils';

@Entry
@Component
struct LoginPage {
  @State isSelect: boolean = false
  account: string = ''
  password: string = ''

  aboutToAppear(): void {
    const params = router.getParams() as ParamsObj
    this.account = params.account
    this.password = params.password
    showToast(`收到传递参数${this.account}`)
  }

  build() {
    Column() {

      Row() {
        Image($r('app.media.jd_cancel'))
          .width(20)

        Text('帮助')
      }.justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .height(50)

      Image($r('app.media.jd_logo'))
        .width(250)

      Row() {

        Text('国家/地址')
          .fontSize(14)
          .layoutWeight(1)
          .fontColor('#666')

        Text('中国（+86）')
          .fontSize(12)
          .fontColor('#666')

        Image($r('app.media.jd_right'))
          .width(15)
          .fillColor('#666')
      }
      .width('100%')
      .height(40)
      .backgroundColor('#fff')
      .borderRadius(20)
      .padding({
        left: 15,
        right: 10
      })

      TextInput({
        placeholder: '请输入手机号',
        text: this.account
      })
        .width('100%')
        .height(40)
        .backgroundColor('#fff')
        .fontSize(14)
        .placeholderColor('#666')
        .borderRadius(20)
        .type(InputType.PhoneNumber)
        .padding({
          left: 15,
          right: 10
        })
        .margin({
          top: 30
        })

      Row() {
        Checkbox()
          .width(10)
          .margin({
            top: 2
          }).select($$this.isSelect)
          .onChange((check: boolean) => {
            this.isSelect = check
          })

        Text() {
          Span('我已阅读并同意')
          Span('《隐私政策》').fontColor('#3274f6')
          Span('《服务协议》').fontColor('#3274f6')
          Span('未注册的手机号将自动注册')
        }.fontSize(12)
        .fontColor('#666')
      }.margin({
        top: 20
      }).alignItems(VerticalAlign.Top)

      Button('登录')
        .width('100%')
        .height(40)
        .backgroundColor('#bf2838')
        .margin({
          top: 30
        })
        .onClick(() => {
          if (this.isSelect) {
            router.back()
          } else {
            showToast('请同意相关协议')
          }
        })

      Row({
        space: 15
      }) {
        Text('新用户注册').fontSize(12).fontColor('#666')
        Text('账户密码登录').fontSize(12).fontColor('#666')
        Text('无法登录？').fontSize(12).fontColor('#666')
      }.margin({
        top: 20
      })

      Blank() // 填充组件

      Column({
        space: 20
      }) {
        Text('其他登录方式')
          .fontColor('#666')
          .fontSize(12)

        Row({
          space: 30
        }) {
          Image($r('app.media.jd_weibo')).width(40).fillColor('#c8493b')
          Image($r('app.media.jd_wechat')).width(40).fillColor('#56a44a')
          Image($r('app.media.jd_QQ')).width(40).fillColor('#4ba0e8')
          Image($r('app.media.jd_huawei')).width(40)
        }
      }.margin({
        bottom: 20
      })
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.jd_login_bg'))
    .backgroundImageSize(ImageSize.Cover)
    .padding(20)
  }
}