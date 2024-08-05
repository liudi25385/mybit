import { JSON } from '@kit.ArkTS';

@Entry
@Component
struct Index {
  @State dataArr: Array<NewYearCard> = [
    new NewYearCard(1, $r('app.media.bg_00'), $r('app.media.img_00')),
    new NewYearCard(1, $r('app.media.bg_01'), $r('app.media.img_01')),
    new NewYearCard(1, $r('app.media.bg_02'), $r('app.media.img_02')),
    new NewYearCard(1, $r('app.media.bg_03'), $r('app.media.img_03')),
    new NewYearCard(1, $r('app.media.bg_04'), $r('app.media.img_04')),
    new NewYearCard(1, $r('app.media.bg_05'), $r('app.media.img_05')),
  ]
  //遮罩透明度
  @State maskOpacity: number = 0
  @State maskZIndex: number = -1
  //缩放比例
  @State maskScaleRatio: number = 0
  @State dataIndex: number = 0
  @State isGet: boolean = false

  build() {

    Stack() {
      Column() {

        Grid() {
          ForEach(this.dataArr, (item: NewYearCard) => {

            GridItem() {
              Badge({
                count: item.cardCount,
                position: BadgePosition.RightTop,
                style: {
                  fontSize: 14,
                  badgeSize: 20,
                  badgeColor: '#fa2a2d'
                }
              }) {
                Image(item.cardUrl).width(80)
              }
            }
          })
        }.columnsTemplate('1fr 1fr 1fr')
        .rowsTemplate('1fr 1fr')
        .height(300)
        .margin({
          left: 20,
          right: 20,
          top: 100,
          bottom: 100
        })

        Button('立即抽卡')
          .width(200)
          .backgroundColor('#ed5b8c')
          .onClick(() => {
            this.maskOpacity = 1
            this.maskZIndex = 2
            this.maskScaleRatio = 1
            this.dataIndex = Math.floor(Math.random() * 6)
            // this.dataArr[this.dataIndex].cardCount = this.dataArr[this.dataIndex].cardCount + 1
            this.dataArr[this.dataIndex] =
              new NewYearCard(++this.dataArr[this.dataIndex].cardCount, this.dataArr[this.dataIndex].resultCardUrl,
                this.dataArr[this.dataIndex].resultCardUrl)
          })
      }.backgroundColor('#fff')
      .width('100%')
      .height('100%')

      Column({
        space: 50
      }) {
        Text('获得生肖卡').fontColor('#fff').fontSize(16)
        Image(this.dataArr[this.dataIndex].resultCardUrl)
          .width(150)
          .scale({
            x: this.maskScaleRatio,
            y: this.maskScaleRatio
          }).animation({
          duration: 500
        })
        Button('开心收下')
          .width(200)
          .borderRadius(40)
          .border({
            width: 1,
            color: '#fff',
          })
          .backgroundColor('#00ffffff')
          .onClick(() => {
            this.maskOpacity = 0
            this.maskZIndex = -1
            this.maskScaleRatio = 0

            let flag = true
            for (let item of this.dataArr) {
              if (item.cardCount == 0) {
                flag = false
                break
              }
            }
            this.isGet = flag
          })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#cc000000')
      .justifyContent(FlexAlign.SpaceAround)
      .padding({
        top: 200,
        bottom: 200
      })
      .zIndex(this.maskZIndex)
      .opacity(this.maskOpacity)
      .animation({
        duration: 400
      })

      if (this.isGet) {
        Column() {
          Text('恭喜集齐所有卡片，获得手机一部').fontColor(Color.White)
            .fontSize(16)

          Image($r('app.media.hw')).width(240)

          Button('重置重抽')
            .border({
              width: 1,
              radius: 20,
              color: Color.White
            }).backgroundColor('#00ffffff')
            .width(200)
            .onClick(() => {
              this.dataArr = [
                new NewYearCard(0, $r('app.media.bg_00'), $r('app.media.img_00')),
                new NewYearCard(0, $r('app.media.bg_01'), $r('app.media.img_01')),
                new NewYearCard(0, $r('app.media.bg_02'), $r('app.media.img_02')),
                new NewYearCard(0, $r('app.media.bg_03'), $r('app.media.img_03')),
                new NewYearCard(0, $r('app.media.bg_04'), $r('app.media.img_04')),
                new NewYearCard(0, $r('app.media.bg_05'), $r('app.media.img_05')),
              ]
              this.isGet = false
            })
        }.width('100%')
        .height('100%')
        .backgroundColor('#cc000000')
        .justifyContent(FlexAlign.SpaceEvenly)
      }


    }
  }
}

class NewYearCard {
  public cardCount: number = 0;
  public cardUrl: Resource = $r('app.media.img_00')
  public resultCardUrl: Resource = $r('app.media.img_00')

  constructor(cardCount: number, cardUrl: Resource, resultCardUrl: Resource) {
    this.cardCount = cardCount
    this.cardUrl = cardUrl
    this.resultCardUrl = resultCardUrl
  }
}