import { MapPage } from './MapPage'

@Entry
@Component
struct Index {

  build() {
    RelativeContainer() {
      MapPage()
    }
    .height('100%')
    .width('100%')
  }
}