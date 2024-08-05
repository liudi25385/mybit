export class DailyImgModel{
  public copyright:string
  public copyrightlink:string
  public title:string
  public url:string

  constructor(copyright: string, copyrightlink: string, title: string, url: string) {
    this.copyright = copyright
    this.copyrightlink = copyrightlink
    this.title = title
    this.url = url
  }
}