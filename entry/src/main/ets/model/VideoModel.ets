@Observed
export class VideoModel {
  video_url: string
  id: number
  title: string
  avatar: string
  isliks: boolean
  isfav: boolean
  like_num: number
  fav_num: number
  username: string
  sharenum: number
  commentnum: number

  constructor(video_url: string, id: number, title: string, avatar: string, isliks: boolean,
    isfav: boolean, like_num: number, fav_num: number, username: string, sharenum: number, commentnum: number) {
    this.video_url = video_url
    this.id = id
    this.title = title
    this.avatar = avatar
    this.isliks = isliks
    this.isfav = isfav
    this.like_num = like_num
    this.fav_num = fav_num
    this.username = username
    this.sharenum = sharenum
    this.commentnum = commentnum
  }
}

export const getVideoData: VideoModel[] = [
  new VideoModel('https://sf1-cdn-tos.huoshanstatic.com/obj/media-fe/xgplayer_doc_video/mp4/xgplayer-demo-360p.mp4', 1, '标题1', '..', false, false, Math.floor(Math.random() * 1200),
    Math.floor(Math.random() * 1000),
    '用户1',
    Math.floor(Math.random() * 1000),
    Math.floor(Math.random() * 1000)),
  new VideoModel('https://stream7.iqilu.com/10339/upload_transcode/202002/09/20200209105011F0zPoYzHry.mp4', 1, '标题1', '..', false, false, Math.floor(Math.random() * 1000),
    Math.floor(Math.random() * 1000),
    '用户2',
    Math.floor(Math.random() * 1000),
    Math.floor(Math.random() * 1000)),
  new VideoModel('https://stream7.iqilu.com/10339/upload_transcode/202002/09/20200209104902N3v5Vpxuvb.mp4', 1, '标题1', '..', false, false, Math.floor(Math.random() * 1000),
    Math.floor(Math.random() * 1000),
    '用户3',
    Math.floor(Math.random() * 1000),
    Math.floor(Math.random() * 1000)),
  new VideoModel('https://vjs.zencdn.net/v/oceans.mp4', 1, '标题1', '..', false, false, Math.floor(Math.random() * 1000),
    Math.floor(Math.random() * 1000),
    '用户4',
    Math.floor(Math.random() * 1000),
    Math.floor(Math.random() * 1000))
]

