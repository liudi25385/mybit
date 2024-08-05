import { Home } from '../component/Home'
import { showToast } from '../utils/ToastUtils';
import { Mine } from '../component/Mine';
import { SideBar } from '../component/SideBar';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State isShowSideBar: boolean = false
  @State showControlButton: boolean = true
  @State tabPosition: number = 0

  build() {
    SideBarContainer(SideBarContainerType.Embed) {
      //侧边栏
      SideBar()

      //内容区
      RelativeContainer() {
        Tabs({
          barPosition: BarPosition.End
        }) {
          TabContent() {
            Home()
          }.tabBar('首页')

          TabContent().tabBar(this.takeCamera())

          TabContent() {
            Mine()
          }.tabBar('我')
        }
        .width('100%')
        .height('100%')
        .backgroundColor(Color.Transparent)
        .onChange((index: number) => {
          if (index == 0) {
            this.showControlButton = true
          } else {
            this.showControlButton = false
          }
        })
      }
      .height('100%')
      .width('100%')
      .onClick(() => {
        if (this.isShowSideBar) {
          this.isShowSideBar = false
        }
      })
    }
    .sideBarWidth('60%')
    .maxSideBarWidth('60%')
    .showSideBar($$this.isShowSideBar)
    .height('100%')
    .showControlButton(this.showControlButton)
    .controlButton({
      top: 18,
      width: 35,
      height: 28,
      icons: {
        shown: $r('app.media.ic_menu'),
        hidden: $r('app.media.ic_menu'),
        switching: $r('app.media.ic_menu')
      }
    })
    .autoHide(true)
    .alignRules({
      left: { anchor: '__container__', align: HorizontalAlign.Start },
      top: { anchor: '__container__', align: VerticalAlign.Top },
      bottom: { anchor: '__container__', align: VerticalAlign.Bottom },
    })

  }

  @Builder
  takeCamera() {
    Image($r('app.media.ic_add')).width(40)
      .onClick(() => {
        showToast('暂未实现')
      })
  }
}
