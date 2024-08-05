import { CommentData } from '../../model/CommentModel'

@Component
export struct CommentBottom {
  @State isLike: boolean = false
  @State isFav: boolean = false
  @State commentContent: string = ''
  @Prop commentList: CommentData[]
  @State input: string = ''
  onUpdate = (input:string) => {}

  build() {
    Row({
      space: 15
    }) {
      Row() {
        Image($r('app.media.ic_edit')).width(20).fillColor('#ff2f2b2b')
        TextInput({
          placeholder: '请输入评价...',
          text: $$this.input
        }).height(40).onSubmit(() => {
          this.onUpdate(this.input)
          this.input = ''
        }).enterKeyType(EnterKeyType.Send).backgroundColor('#ffe5e5e5')
      }
      .layoutWeight(1)
      .backgroundColor('#ffe5e5e5')
      .borderRadius(20)
      .height(40)
      .padding({
        left: 15,
        right: 15
      })

      Image($r('app.media.ic_heart')).width(20).fillColor(this.isLike ? '#fffc6a6a' : '#ff2f2b2b').onClick(() => {
        this.isLike = !this.isLike
      })
      Image($r('app.media.ic_star')).width(20).fillColor(this.isFav ? '#fffc6a6a' : '#ff2f2b2b').onClick(() => {
        this.isFav = !this.isFav
      })
    }.width('100%').backgroundColor('#fff').height(60).padding(20).margin({
      bottom:30
    })
  }
}