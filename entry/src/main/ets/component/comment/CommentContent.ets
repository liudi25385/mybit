import { CommentData } from '../../model/CommentModel'

@Component
export struct CommentContent {
  @ObjectLink item: CommentData
  likeClick = () => {

  }

  build() {
    Column({
      space: 10
    }) {
      Row({
        space: 10
      }) {
        Image(this.item.avatar).width(20).borderRadius(15)

        Text(this.item.name).fontColor(Color.Gray).fontSize(13)

        Image(this.item.levelIcon).width(20)
      }.width('100%').justifyContent(FlexAlign.Start)

      Text(this.item.commentTxt).width('100%').margin({
        left: 80, right: 20
      }).fontSize(13)

      Row() {
        Text(this.item.timeString).fontSize(10).fontColor(Color.Grey)

        Row({
          space: 5
        }) {
          Image($r(this.item.isLike ? 'app.media.like_select' : 'app.media.like_unselect')).width(15)
          Text(this.item.likeNum.toString()).fontSize(10)
        }.onClick(() => {
          // this.likeClick()

          if (this.item.isLike) {
            this.item.likeNum -= 1
          } else {
            this.item.likeNum += 1
          }
          this.item.isLike = !this.item.isLike
        })
      }.width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({
        left: 80, right: 20
      })
    }.padding({
      left: 20,
      right: 50,
      top: 10,
      bottom: 10
    })
  }
}
