import { BasicDataSource } from '../base/BasicDataSource'


/**
 * 数据源类*/
export class DataSource<T> extends BasicDataSource {
  /**
   * 视频数据*/
  private dataArray: T[] = [];

  constructor(el: T[]) {
    super();
    this.dataArray = el;
  }

  public totalCount(): number {
    return this.dataArray.length;
  }

  public getData(index: number): T {
    return this.dataArray[index];
  }

  public addData(index: number, data: T): void {
    this.dataArray.splice(index, 0, data);
    this.notifyDataAdd(index);
  }

  public pushData(data: T): void {
    this.dataArray.push(data);
    this.notifyDataAdd(this.dataArray.length - 1);
  }
}
