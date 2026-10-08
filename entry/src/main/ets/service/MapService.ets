import { mapCommon, map } from '@kit.MapKit';

export class MapService {

  buildMapOptions(): mapCommon.MapOptions {
    return {
      position: {
        target: {
          latitude: 39.9,
          longitude: 116.4
        },
        zoom: 10
      },
      dayNightMode: mapCommon.DayNightMode.AUTO,
      scaleControlsEnabled: true,
      zoomControlsEnabled: false,
      compassControlsEnabled: true
    };
  }

  configureMap(controller: map.MapComponentController): void {
    controller.setBuildingEnabled(true);
  }
}
