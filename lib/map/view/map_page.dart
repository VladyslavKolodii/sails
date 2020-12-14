import 'package:hybrid_sailmate/map/bloc/map_bloc.dart';
import 'package:hybrid_sailmate/widgets/common/main_button_decoration.dart';
import 'package:hybrid_sailmate/widgets/speed_and_heading_info_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fontisto_flutter/fontisto_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapPage extends HookWidget {
  const MapPage({
    @required this.mapboxApiKey,
    @required this.mapboxStyleString,
    @required this.scaffoldKey
  }) : super();

  final String mapboxApiKey;
  final String mapboxStyleString;
  final GlobalKey<ScaffoldState> scaffoldKey;

  static Route route(String mapboxApiKey, String mapboxStyleString, GlobalKey scaffoldKey) {
    return MaterialPageRoute<void>(
      builder: (_) => MapPage(mapboxApiKey: mapboxApiKey, mapboxStyleString: mapboxStyleString, scaffoldKey: scaffoldKey)
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final bloc = BlocProvider.of<MapBloc>(context);

    var height = MediaQuery.of(context).size.height;

    return Container(
        child: FutureBuilder<Position>(
          future: Geolocator.getCurrentPosition(),
          builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
            var latitude = snapshot.data?.latitude;
            var longitude = snapshot.data?.longitude;
            if (snapshot.hasError) {
              print('Error fetching current location');
            }

            return Center(
              child: Stack(
                children: [
                  BlocConsumer<MapBloc, MapState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is MapInitial) {
                        BlocProvider.of<MapBloc>(context).add(MapCreateRequested(accessToken: mapboxApiKey, styleString: mapboxStyleString));
                      }

                      if (state is MapRendered && latitude != null && longitude != null) {
                        bloc
                          .add(
                            CameraUpdateRequested(location: LatLng(latitude, longitude), zoom: 10)
                          );
                      }

                      if (state is CameraUpdated) {
                        bloc.add(PointOfInterestsRequested());
                      }

                      if (bloc.getMap() != null && state is MapVisible) {
                        return Stack(
                          children: [
                            bloc.getMap(),
                            SpeedAndHeadingInfoBox(top: height < 670 ? 25 : 58),
                            Positioned(
                              bottom: 40,
                              right: 24,
                              child: FloatingActionButton(
                                onPressed: () {
                                  bloc.add(CameraUpdateRequested(location: LatLng(snapshot.data.latitude, snapshot.data.longitude)));
                                  bloc.add(TrackingModeUpdateRequested(mode: MyLocationTrackingMode.Tracking));
                                },
                                child: Icon(Istos.crosshairs),
                              )
                            )
                          ]
                        );
                      }

                      return Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(color: Colors.white.withOpacity(0.98)),
                            ),
                            Center(
                              child: CircularProgressIndicator(),
                            )
                          ],
                        );
                    }
                  ),
                  Positioned(
                    left: 24,
                    top: height < 670 ? 25 : 58,
                    child: SizedBox(
                      height: 46,
                      width: 46,
                      child: DecoratedBox(
                        decoration: MainButtonDecoration(),
                        child: FlatButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: Icon(Istos.nav_icon, color: Colors.grey, size: 12),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            );
          }
        )
    );
  }
}
