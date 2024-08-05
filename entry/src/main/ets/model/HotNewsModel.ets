export class HotNewsModel {
  微博: Array<NewsBean>
  知乎: Array<NewsBean>
  微信: Array<NewsBean>
  百度: Array<NewsBean>
  少数派: Array<NewsBean>
  虎嗅网: Array<NewsBean>
  IT之家: Array<NewsBean>
  哔哩哔哩: Array<NewsBean>

  constructor(微博: Array<NewsBean>, 知乎: Array<NewsBean>, 微信: Array<NewsBean>, 百度: Array<NewsBean>,
    少数派: Array<NewsBean>, 虎嗅网: Array<NewsBean>, IT之家: Array<NewsBean>, 哔哩哔哩: Array<NewsBean>) {
    this.微博 = 微博
    this.知乎 = 知乎
    this.微信 = 微信
    this.百度 = 百度
    this.少数派 = 少数派
    this.虎嗅网 = 虎嗅网
    this.IT之家 = IT之家
    this.哔哩哔哩 = 哔哩哔哩
  }
}

@Observed
export class NewsBean {
  index: number
  title: string
  hot: string
  href: string

  constructor(index: number, title: string, hot: string, href: string) {
    this.index = index
    this.title = title
    this.hot = hot
    this.href = href
  }
}