import { VideoPlayController } from './VideoController'
import { getVideoData, VideoModel } from '../model/VideoModel'
import { DataSource } from '../model/DataSource'
import { Shop } from './Shop'

@Component
export struct Home {
  @State videoSource: DataSource<VideoModel> = new DataSource<VideoModel>(getVideoData)
  private controller: TabsController = new TabsController()
  @State barOverlap: boolean = true;
  @State barBackgroundColor: string = '#00000000';
  @Provide selectedTabIndex: number = 1

  build() {
    Column() {

      Tabs({ barPosition: BarPosition.Start, index: 1, controller: this.controller }) {
        TabContent() {
          Shop()
        }.tabExtend('团购')

        TabContent() {
          VideoPlayController({
            videoList: this.videoSource
          })
        }.tabExtend('推荐')
      }
      .vertical(false)
      .barMode(BarMode.Fixed)
      .height('100%')
      .width('100%')
      .barBackgroundBlurStyle(BlurStyle.NONE)
      .barOverlap(this.barOverlap)
      .scrollable(true)
      .animationDuration(10)
      .barBackgroundColor(this.barBackgroundColor)
      .onChange((index: number) => {
        this.selectedTabIndex = index
      })
      .barMode(BarMode.Scrollable)
      .fadingEdge(true)
      .scrollable(true)
    }
  }
}

@Extend(TabContent)
function tabExtend(tabTitle:string){
  .tabBar(SubTabBarStyle.of(tabTitle)
    .indicator({
      color: Color.White,
      width: 20
    }).labelStyle({
      selectedColor: '#fff',
      unselectedColor: '#ffc3c3c3'
    }))
}