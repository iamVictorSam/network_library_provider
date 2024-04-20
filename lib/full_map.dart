import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import 'page.dart';

class FullMapPage extends ExamplePage {
  const FullMapPage({super.key})
      : super(const Icon(Icons.map), 'Full screen map');

  @override
  Widget build(BuildContext context) {
    return const FullMap();
  }
}

class FullMap extends StatefulWidget {
  const FullMap({super.key});

  @override
  State createState() => FullMapState();
}

class FullMapState extends State<FullMap> {
  MapboxMap? mapboxMap;
  var isLight = true;

  _onMapCreated(MapboxMap mapboxMap) {
    this.mapboxMap = mapboxMap;
    mapboxMap.style;
  }

  _onStyleLoadedCallback(StyleLoadedEventData data) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Style loaded :), time: "),
      backgroundColor: Theme.of(context).primaryColor,
      duration: const Duration(seconds: 1),
    ));
  }

  _onCameraChangeListener(CameraChangedEventData data) {
    print("CameraChangedEventData: timestamp: ");
  }

  _onMapIdleListener(MapIdleEventData data) {
    print("MapIdleEventData: timestamp: ");
  }

  _onMapLoadedListener(MapLoadedEventData data) {
    print("MapLoadedEventData: time: ");
  }

  _onMapLoadingErrorListener(MapLoadingErrorEventData data) {
    print("MapLoadingErrorEventData: timestamp: ");
  }

  _onRenderFrameStartedListener(RenderFrameStartedEventData data) {
    print("RenderFrameStartedEventData: timestamp: ");
  }

  _onRenderFrameFinishedListener(RenderFrameFinishedEventData data) {
    print("RenderFrameFinishedEventData: time: ");
  }

  _onSourceAddedListener(SourceAddedEventData data) {
    print("SourceAddedEventData: timestamp: ");
  }

  _onSourceDataLoadedListener(SourceDataLoadedEventData data) {
    print("SourceDataLoadedEventData: time: ");
  }

  _onSourceRemovedListener(SourceRemovedEventData data) {
    print("SourceRemovedEventData: timestamp: ");
  }

  _onStyleDataLoadedListener(StyleDataLoadedEventData data) {
    print("StyleDataLoadedEventData: time: ");
  }

  _onStyleImageMissingListener(StyleImageMissingEventData data) {
    print("StyleImageMissingEventData: timestamp: ");
  }

  _onStyleImageUnusedListener(StyleImageUnusedEventData data) {
    print("StyleImageUnusedEventData: timestamp: ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    setState(
                      () => isLight = !isLight,
                    );
                    if (isLight) {
                      mapboxMap?.loadStyleURI(MapboxStyles.LIGHT);
                    } else {
                      mapboxMap?.loadStyleURI(MapboxStyles.DARK);
                    }
                  },
                  child: const Icon(Icons.swap_horiz)),
              const SizedBox(height: 10),
            ],
          ),
        ),
        body: MapWidget(
          key: const ValueKey("mapWidget"),
          cameraOptions: CameraOptions(
              center: Point(
                  coordinates: Position(
                6.0033416748046875,
                43.70908256335716,
              )).toJson(),
              zoom: 3.0),
          styleUri: MapboxStyles.LIGHT,
          textureView: true,
          onMapCreated: _onMapCreated,
          onStyleLoadedListener: _onStyleLoadedCallback,
          onCameraChangeListener: _onCameraChangeListener,
          onMapIdleListener: _onMapIdleListener,
          onMapLoadedListener: _onMapLoadedListener,
          onMapLoadErrorListener: _onMapLoadingErrorListener,
          onRenderFrameStartedListener: _onRenderFrameStartedListener,
          onRenderFrameFinishedListener: _onRenderFrameFinishedListener,
          onSourceAddedListener: _onSourceAddedListener,
          onSourceDataLoadedListener: _onSourceDataLoadedListener,
          onSourceRemovedListener: _onSourceRemovedListener,
          onStyleDataLoadedListener: _onStyleDataLoadedListener,
          onStyleImageMissingListener: _onStyleImageMissingListener,
          onStyleImageUnusedListener: _onStyleImageUnusedListener,
          resourceOptions: ResourceOptions(
              accessToken:
                  'pk.eyJ1IjoiZ2VmZnkiLCJhIjoiY2xyOHNxYWR4MTV1ZTJrcGFlc3l3dTdweSJ9.z0ti1tOM-44QDQbyet7HoA'),
        ));
  }
}
