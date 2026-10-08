import { map, mapCommon } from '@kit.MapKit';
import { AsyncCallback } from '@kit.BasicServicesKit';
import { MapStatus } from '../model/MapState';
import { MapService } from '../service/MapService';

@Observed
export class MapViewModel {
  private TAG = 'MapViewModel';
  private mapService = new MapService();

  status: MapStatus = MapStatus.INITIALIZING;
  errorMessage: string = '';

  mapOptions: mapCommon.MapOptions = this.mapService.buildMapOptions();

  private mapController: map.MapComponentController | undefined = undefined;

  buildMapCallback(): AsyncCallback<map.MapComponentController> {
    return async (err, controller) => {
      if (err) {
        console.error(this.TAG,
          `Map initialization failed. Code: ${err.code}; Message: ${err.message}`);
        this.errorMessage = `Initialization failed (code ${err.code})`;
        this.status = MapStatus.ERROR;
        return;
      }

      this.mapController = controller;
      this.mapService.configureMap(controller);
      this.status = MapStatus.READY;
      console.info(this.TAG, 'Map initialized successfully.');
    };
  }

  onPageVisible(): void {
    this.mapController?.show();
  }

  onPageHidden(): void {
    this.mapController?.hide();
  }

  reset(): void {
    this.mapController = undefined;
    this.errorMessage = '';
    this.status = MapStatus.INITIALIZING;
  }
}
