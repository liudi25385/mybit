import { Net } from '@abner/net/src/main/ets/utils/Net';
import { HOT_LIST } from '../api/HotNewsApi';
import { HotNewsModel, NewsBean } from '../model/HotNewsModel';
import { router } from '@kit.ArkUI';
import { WebInfoParams } from './WebViewPage';

@Entry
@Component
struct HotNewsPage {
  @State message: string = 'Hello World';
  @State hotNewsModel: HotNewsModel | null = null
  @State tabs: string[] = ['微博', '知乎', '微信', '百度', '少数派', '虎嗅网', 'IT之家', '哔哩哔哩']

  async getData():Promise<HotNewsModel> {
    const data = await Net.get(HOT_LIST).returnData<HotNewsModel>()
    return Promise.resolve(data)
  }

  async aboutToAppear(){
    this.getData().then((result)=>{
      this.hotNewsModel = result
    })
  }

  build() {
    Tabs() {
      if (this.hotNewsModel != null) {
        ForEach(this.tabs, (item: string) => {
          TabContent() {
            if (item == '微博') {
              HotNewsItem({
                itemData: this.hotNewsModel?.微博,
                onRefresh: () => {
                  console.log('加载了刷新功能。。。');
                  this.getData()
                }
              })
            } else if (item == '知乎') {
              HotNewsItem({
                itemData: this.hotNewsModel?.知乎,
                onRefresh: () => {
                  console.log('加载了刷新功能。。。');
                  this.getData()
                }
              })
            } else if (item == '微信') {
              HotNewsItem({
                itemData: this.hotNewsModel?.微信,
                onRefresh: () => {
                  this.getData()
                }
              })
            } else if (item == '百度') {
              HotNewsItem({
                itemData: this.hotNewsModel?.百度,
                onRefresh: () => {
                  this.getData()
                }
              })
            } else if (item == '少数派') {
              HotNewsItem({
                itemData: this.hotNewsModel?.少数派,
                onRefresh: () => {
                  this.getData()
                }
              })
            } else if (item == '虎嗅网') {
              HotNewsItem({
                itemData: this.hotNewsModel?.虎嗅网,
                onRefresh: () => {
                  this.getData()
                }
              })
            } else if (item == 'IT之家') {
              HotNewsItem({
                itemData: this.hotNewsModel?.IT之家,
                onRefresh: () => {
                  this.getData()
                }
              })
            } else if (item == '哔哩哔哩') {
              HotNewsItem({
                itemData: this.hotNewsModel?.哔哩哔哩,
                onRefresh: () => {
                  this.getData()
                }
              })
            }
          }.tabBar(new SubTabBarStyle(item).labelStyle({
            unselectedColor:'#000',
            selectedColor:'#fff80707'
          }))
        })
      }else{
        TabContent(){
          Text('数据加载中...')
        }
      }
    }
    .width('100%')
    .height('100%')
    .scrollable(true)
    .barMode(BarMode.Scrollable)
    .animationDuration(400)
    .fadingEdge(true)
  }
}

@Component
export struct HotNewsItem {
  @Prop itemData: Array<NewsBean> = []
  @State color: ResourceColor[] = ['#ffff0000', '#fff1db0e', '#ff79bc7c', '#000', '#80000000']
  @State isRefresh: boolean = false
  onRefresh = () => {
  }

  build() {
    Refresh({
      refreshing: $$this.isRefresh
    }) {
      List() {
        ForEach(this.itemData, (item: NewsBean) => {
          ListItem() {
            Column({
              space: 10
            }) {
              Row({
                space: 8
              }) {
                Text(`${item.index.toString()}.`).fontColor(item.index <= 3 ? this.color[item.index-1] : this.color[3])
                Text(`${item.title}`)
                  .fontColor(item.index <= 3 ? this.color[item.index-1] : this.color[3])
                  .layoutWeight(1)
                  .maxLines(2)
                  .ellipsisMode(EllipsisMode.END)
                  .textOverflow({
                    overflow: TextOverflow.Ellipsis
                  })
              }.width('100%')
              .justifyContent(FlexAlign.Center)

              // .padding(10)

              Text(`${item.hot}`).fontColor(item.index <= 3 ? this.color[item.index-1] : this.color[4]).fontSize(10)
            }.alignItems(HorizontalAlign.End)
            .padding(10)

          }.onClick(() => {
            router.pushUrl({
              url: 'pages/WebViewPage',
              params: new WebInfoParams(item.href)
            })
          })
        })
      }
      .width('100%')
      .height('100%')
      .sticky(StickyStyle.None)
      .scrollBar(BarState.Off)
      .divider({
        strokeWidth: 0.4,
        color: '#80000000',
        startMargin: 10,
        endMargin: 10
      })
    }.refreshOffset(60)
    .onRefreshing(() => {
      this.onRefresh()
      setTimeout(() => {
        this.isRefresh = false
      }, 2000)
    })
  }
}