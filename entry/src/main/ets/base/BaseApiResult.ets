export interface BaseApiResult<T> {
  code: number
  message: string
  result: T|T[]
}