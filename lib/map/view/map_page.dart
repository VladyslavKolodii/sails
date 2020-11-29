import 'package:HybridSailmate/map/bloc/map_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:dio/dio.dart';
import 'package:point_of_interest_repository/point_of_interest_repository.dart';

class MapPage extends HookWidget {
  const MapPage({
    @required this.mapboxApiKey,
    @required this.mapboxStyleString
  }) : super();

  final String mapboxApiKey;
  final String mapboxStyleString;

  static Route route(String mapboxApiKey, String mapboxStyleString) {
    return MaterialPageRoute<void>(builder: (_) => MapPage(mapboxApiKey: mapboxApiKey, mapboxStyleString: mapboxStyleString));
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final MapBloc bloc = BlocProvider.of<MapBloc>(context);

    return new Scaffold(
        appBar: AppBar(title: const Text('Sailmate')),
        body: FutureBuilder<Position>(
          future: getCurrentPosition(),
          builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
            if (snapshot.hasError) {
              print('Error fetching current location');
            }

            return Center(
              child: BlocConsumer<MapBloc, MapState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is MapInitial) {
                     BlocProvider.of<MapBloc>(context).add(MapCreateRequested(accessToken: mapboxApiKey, styleString: mapboxStyleString));
                  }

                  if (state is MapRendered) {
                    bloc
                      .add(
                        CameraUpdateRequested(location: LatLng(snapshot.data.latitude, snapshot.data.longitude), zoom: 10)
                      );
                  }

                  if (state is CameraUpdated) {
                    bloc.add(PointOfInterestsRequested());
                  }

                  if (bloc.getMap() != null && state is MapVisible) {
                    return bloc.getMap();
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
              )
            );
          }
        )
    );
  }
}
