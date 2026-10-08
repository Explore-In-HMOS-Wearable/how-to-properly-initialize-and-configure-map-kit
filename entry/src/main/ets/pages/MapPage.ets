import { MapComponent } from '@kit.MapKit';
import { AsyncCallback } from '@kit.BasicServicesKit';
import { map } from '@kit.MapKit';
import { MapViewModel } from '../viewmodel/MapViewModel';
import { MapStatus } from '../model/MapState';

@Entry
@Component
export struct MapPage {
  @State viewModel: MapViewModel = new MapViewModel();

  private mapCallback: AsyncCallback<map.MapComponentController> =
    this.viewModel.buildMapCallback();

  onPageShow(): void {
    this.viewModel.onPageVisible();
  }

  onPageHide(): void {
    this.viewModel.onPageHidden();
  }

  @Builder
  MapView() {
    MapComponent({
      mapOptions: this.viewModel.mapOptions,
      mapCallback: this.mapCallback
    })
      .width('100%')
      .height('100%')
  }

  @Builder
  InitializingOverlay() {
    Column() {
      LoadingProgress()
        .width(32)
        .height(32)
        .color('#58A6FF')
      Text('Initializing map...')
        .fontSize(11)
        .fontColor('#8B949E')
        .margin({ top: 8 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#0D1117')
  }

  @Builder
  ErrorOverlay() {
    Column({ space: 10 }) {
      Text('⚠')
        .fontSize(24)
      Text('Map unavailable')
        .fontSize(12)
        .fontColor('#E6EDF3')
        .fontWeight(FontWeight.Medium)
      Text(this.viewModel.errorMessage)
        .fontSize(10)
        .fontColor('#8B949E')
        .textAlign(TextAlign.Center)
        .width('80%')
      Button('Retry')
        .fontSize(11)
        .height(30)
        .width(80)
        .fontColor('#0D1117')
        .backgroundColor('#58A6FF')
        .onClick(() => {
          this.viewModel.reset();
          this.mapCallback = this.viewModel.buildMapCallback();
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#0D1117')
  }

  build() {
    Stack() {
      if (this.viewModel.status !== MapStatus.ERROR) {
        this.MapView()
      }

      if (this.viewModel.status === MapStatus.INITIALIZING) {
        this.InitializingOverlay()
      }

      if (this.viewModel.status === MapStatus.ERROR) {
        this.ErrorOverlay()
      }
    }
    .width('100%')
    .height('100%')
  }
}
