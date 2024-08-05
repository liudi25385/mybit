import { CommentData, createListRange } from '../../model/CommentModel'

@Component
export struct CommentToolBar {
  @State isOn: boolean = true
  @State commentList: CommentData[] = []

  build() {
    Row() {
      Text('全部评论').fontSize(16).fontWeight(FontWeight.Bold).layoutWeight(1)
      Row() {
        Button('最新').commentButton(this.isOn).onClick(() => {
          this.isOn = true
          this.commentList.sort((a: CommentData, b: CommentData) => {
            return b.time - a.time
          })
        })
        Button('最热').commentButton(!this.isOn).onClick(() => {
          this.isOn = false
          this.commentList.sort((a: CommentData, b: CommentData) => {
            return b.likeNum - a.likeNum
          })
        })
      }.backgroundColor('#ffe6e6e9')
      .border({
        radius: 20
      }).height(32)
    }
    .height(80)
    .padding(20)
  }
}


@Extend(Button)
function commentButton(isOn: boolean) {
  .width(46)
  .height(32)
  .fontSize(12)
  .padding({ left: 5, right: 5 })
  .fontColor(isOn ? '#2f2e33' : '#8e9298')
  .backgroundColor(isOn ? '#fff' : '#ffe6e6e9')
  .border({
    width: 1,
    color: isOn ? '#e4e5e6' : '#ffe6e6e9'
  })
}