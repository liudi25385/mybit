/**
 * 视频播放页
 */
import { DataSource } from '../model/DataSource'
import { CommentToolBar } from './comment/CommentToolBar'
import { CommentData, createListRange } from '../model/CommentModel'
import { CommentContent } from './comment/CommentContent'
import { CommentBottom } from './comment/CommentBottom'
import { VideoModel } from '../model/VideoModel'
import { promptAction } from '@kit.ArkUI'

@Component
export struct VideoPlayController {
  @Prop videoList: DataSource<VideoModel>
  @Provide playIndex: number = 0

  build() {
    Swiper() {
      LazyForEach(this.videoList, (item: VideoModel, index: number) => {
        VideoPage({
          item: item,
          index: index
        })
      })
    }
    .autoPlay(false)
    .vertical(true)
    .indicator(false)
    .loop(false)
    .width('100%')
    .height('100%')
    .effectMode(EdgeEffect.None)
    .onChange((index: number) => {
      this.playIndex = index
    })
  }
}

@Component
export struct VideoPage {
  @ObjectLink item: VideoModel
  index: number = 0
  @Consume
  @Watch('updatePlayVideo')
  playIndex: number
  controller: VideoController = new VideoController()
  @State isShowComment: boolean = false
  @State commentList: CommentData[] = []
  @State isPlay: boolean = true
  @State isShowPlayButton: boolean = false
  @Consume
  @Watch('updateTabChange')
  selectedTabIndex: number
  onPlayPauseClick = () => {
    if (this.isPlay) {
      this.controller.pause()
      this.isShowPlayButton = true
    } else {
      this.controller.start()
      this.isShowPlayButton = false
    }
    this.isPlay = !this.isPlay
  }

  updateTabChange() {
    if (this.selectedTabIndex == 3) {
      this.controller.start()
    } else {
      this.controller.pause()
    }
  }

  updatePlayVideo() {
    console.log('当前切换了' + this.index + '  ' + this.playIndex)
    if (this.playIndex == this.index) {
      this.controller.start()
      this.isShowPlayButton = false
    } else {
      this.controller.pause()
      this.isShowPlayButton = false
    }
  }

  build() {
    RelativeContainer() {
      Video({
        src: this.item.video_url,
        controller: this.controller
      })
        .width('100%')
        .height('100%')
        .autoPlay(this.index == this.playIndex)
        .loop(true)
        .controls(false)
        .onClick(this.onPlayPauseClick)

      Column({
        space: 15
      }) {
        Column() {
          Image($r('app.media.ic_like'))
            .width(40)
            .fillColor(this.item.isliks ? '#ffff1a1a' : '#fff')

          Text(this.item.like_num.toString())
            .fontColor(Color.White)
            .fontSize(16)
        }.onClick(() => {
          if (this.item.isliks) {
            this.item.like_num -= 1
          } else {
            this.item.like_num += 1
          }
          this.item.isliks = !this.item.isliks
        })

        Column() {
          Image($r('app.media.ic_message'))
            .width(40)

          Text(this.item.commentnum.toString())
            .fontColor(Color.White)
            .fontSize(16)
        }.onClick(() => {
          if (!this.isShowComment) {
            this.commentList = createListRange()
            this.isShowComment = true
          }
        })

        Column() {
          Image($r('app.media.ic_collect'))
            .width(40)
            .fillColor(this.item.isfav ? '#fffffb00' : '#fff')
          Text(this.item.fav_num.toString())
            .fontColor(Color.White)
            .fontSize(16)
        }.onClick(() => {
          if (this.item.isfav) {
            this.item.fav_num -= 1
          } else {
            this.item.fav_num += 1
          }
          this.item.isfav = !this.item.isfav
        })

        Column() {
          Image($r('app.media.ic_share'))
            .width(40)

          Text(this.item.sharenum.toString())
            .fontColor(Color.White)
            .fontSize(16)
        }.onClick(() => {
          // 分享
          this.item.sharenum += 1
          promptAction.showToast({
            message: '分享成功'
          })
        })

      }
      .height('50%')
      .alignRules({
        right: { anchor: '__container__', align: HorizontalAlign.End },
        top: { anchor: '__container__', align: VerticalAlign.Top },
        bottom: { anchor: '__container__', align: VerticalAlign.Bottom },
      }).margin({
        right: 20
      })

      if (this.isShowPlayButton) {
        Image($r('app.media.ic_play')).width(60).height(60)
          .alignRules({
            right: { anchor: '__container__', align: HorizontalAlign.End },
            left: { anchor: '__container__', align: HorizontalAlign.Start },
            top: { anchor: '__container__', align: VerticalAlign.Top },
            bottom: { anchor: '__container__', align: VerticalAlign.Bottom },
          }).onClick(this.onPlayPauseClick)
      }

    }.width('100%')
    .height('100%')
    //半模态弹层
    .bindSheet($$this.isShowComment, this.showComment(), {
      detents: [SheetSize.MEDIUM, SheetSize.LARGE, 200],
      height: '75%',
      backgroundColor: '#ffefecec',
      showClose: false,
      dragBar: true
    })
  }

  @Builder
  showComment() {
    Column() {
      CommentToolBar({
        commentList: this.commentList
      })

      List() {
        ForEach(this.commentList, (item: CommentData, index) => {
          ListItem() {
            CommentContent({
              //ObjectLink更新方式
              item: item
            })
          }
        })
      }.width('100%').layoutWeight(1)

      CommentBottom({
        commentList: this.commentList,
        //@Prop更新方式
        onUpdate: (input: string) => {
          let data =
            new CommentData(`https://fastly.picsum.photos/id/439/600/600.jpg?hmac=LC9k_bzrN0NhKRyV62fou3ix3cRFZKNfAyXgxGs6zh8`,
              "我", new Date().getTime(), Math.floor(Math.random() * 6), 0, input,
              false)
          this.commentList.splice(0, 0, data)
        }
      })
    }
  }
}

