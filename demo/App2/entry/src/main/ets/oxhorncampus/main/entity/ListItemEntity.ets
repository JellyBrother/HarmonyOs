export class ListItemEntity {
  text: string = ""
  path: string = ""

  constructor(text: string, path: string) {
    this.text = text
    this.path = path
  }
}