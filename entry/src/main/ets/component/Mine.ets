@Preview
@Component
export struct Mine {
  private outScroller: Scroller = new Scroller();
  @State imageHeight: number = 200
  maxHeight: number = 350
  minHeight: number = 200
  private panOption1: PanGestureOptions = new PanGestureOptions({ direction: PanDirection.Vertical })
  tabTitle:string[] = ['作品','喜欢','收藏']
  productTitle:string[] = ['作品1','作品2','作品3','作品4']

  build() {
    Column() {
      Image($r('app.media.ic_tik_header'))
        .height(this.imageHeight)
        .width('100%')
        .objectFit(ImageFit.Cover)
        .backgroundColor('#000')

      Scroll(this.outScroller) {
        Column({
          space:15
        }) {
          Row({ space: 20 }) {

            Row({ space: 5 }) {
              Text('1533').fontWeight(700)
              Text('获赞').fontColor('#90000000').fontSize(12)
            }

            Row({ space: 5 }) {
              Text('4').fontWeight(700)
              Text('作品').fontColor('#90000000').fontSize(12)
            }

            Row({ space: 5 }) {
              Text('33').fontWeight(700)
              Text('关注').fontColor('#90000000').fontSize(12)
            }

            Row({ space: 5 }) {
              Text('132').fontWeight(700)
              Text('喜欢').fontColor('#90000000').fontSize(12)
            }
          }.justifyContent(FlexAlign.SpaceBetween)
          .width('100%')
          .padding({
            left:10,
            right:10
          })


          Text('万万没想到，拯救不开心~').width('100%').fontColor(Color.Gray).fontSize(12)
          Tabs(){

            ForEach(this.tabTitle,(item:string)=>{
              TabContent(){

                Grid(){
                  ForEach(this.productTitle,(item:string)=>{

                    GridItem(){
                      Text(item).fontColor('#fff')
                    }.backgroundColor('#000')
                  })

                }.columnsTemplate('1fr 1fr 1fr')
                .rowsTemplate('1fr 1fr 1fr')
                .columnsGap(3)
                .rowsGap(3)

              }.tabBar(item).height('100%').width('100%')
            })
          }
        }
      }
      .backgroundColor('#fff')
      .border({
        color: '#fff',
        radius: 8
      })
      .scrollBar(BarState.Off)
      .width('100%')
      .edgeEffect(EdgeEffect.None, {
        alwaysEnabled: true
      })
      .height('100%')
      .layoutWeight(1)
      .margin({
        top: -8
      })
      .padding(10)
    }
    .width('100%').height('100%').parallelGesture(
      PanGesture(this.panOption1)
        .onActionStart((event: GestureEvent) => {
        })
        .onActionUpdate((event: GestureEvent) => {
          if (event) {
            if (this.imageHeight >= this.maxHeight) {
              this.imageHeight = this.maxHeight
              // return
            }
            if (event.offsetY >= 0) {
              if (event.offsetY <= (this.maxHeight - this.minHeight)) {
                this.imageHeight = this.minHeight + event.offsetY
              } else {
                this.imageHeight = this.maxHeight
              }
            }
          }
        })
        .onActionEnd((event: GestureEvent) => {
          this.imageHeight = this.minHeight
        })
    )

  }
}