//文字资源转字符串
export function resourceToString(component?: Object, resource?: Resource): string {
  return getContext(component).resourceManager.getStringSync(resource)
}
