export default class Constants {
  static readonly SMALL_SPACE: number = 5;
}

export interface SkeType {
  isMine: boolean;
  isFeed: boolean;
}

export const SkeletonData: SkeType[] = [
  {
    isMine: true,
    isFeed: false
  },
  {
    isMine: true,
    isFeed: true
  },
  {
    isMine: true,
    isFeed: false
  },
  {
    isMine: true,
    isFeed: true
  },
  {
    isMine: true,
    isFeed: false
  },
  {
    isMine: true,
    isFeed: true
  },
  {
    isMine: true,
    isFeed: false
  },
  {
    isMine: true,
    isFeed: true
  },
]