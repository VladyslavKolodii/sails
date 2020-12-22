import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hybrid_sailmate/map/bloc/map_bloc.dart';
import 'package:hybrid_sailmate/screens/search_screens/search_main.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/bottom_famouse_place.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/bottom_sheet_carousel.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/bottom_sheet_description.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/bottom_sheet_preview.dart';
import 'package:hybrid_sailmate/widgets/common/main_button_decoration.dart';
import 'package:hybrid_sailmate/widgets/drawer/main_drawer.dart';
import 'package:hybrid_sailmate/widgets/global_widget.dart';
import 'package:hybrid_sailmate/widgets/speed_and_heading_info_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:fontisto_flutter/fontisto_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hybrid_sailmate/widgets/text_styles.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:latlong/latlong.dart' as FlutterLatLng;
import 'package:point_of_interest_repository/point_of_interest_repository.dart';
import 'package:progress_hud/progress_hud.dart';

class MapPage extends StatefulWidget {
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
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapboxMapController _mapController;
  List<PointOfInterest> targetInterestPlaces;
  RestClient pointOfInterestRepository;

  LatLng _serachedPoi;

  ProgressHUD progressHUD;

  @override
  void initState() {
    super.initState();

    progressHUD = new ProgressHUD(
      backgroundColor: Colors.black45,
      color: Colors.black,
      containerColor: Colors.white,
      borderRadius: 5.0,
      loading: false,
      text: 'Loading...',
    );
  }

  Future initInterestingData() async {
    http.Response response = await http.get("https://api.sailmate.fi/point_of_interests.json");
    if (response.body.isNotEmpty) {
      var jsonLabel = json.decode(response.body);
      var items = jsonLabel as List;
      var wrapper = items.map<PointOfInterestWrapper>((items) => PointOfInterestWrapper.fromJson(items)).toList();
      targetInterestPlaces = wrapper.map((PointOfInterestWrapper wrapper) => wrapper.point_of_interest).toList();
      Common.gPOIs = targetInterestPlaces;
    } else {
      // progressHUD.state.dismiss();
      print("There is no data");
    }
    if (targetInterestPlaces != null) {
      targetInterestPlaces.map((PointOfInterest poi) {
        if (poi.poi_type == "PORT") {
          _mapController.addSymbol(SymbolOptions(
            geometry: LatLng(poi.lat, poi.lon),
            iconImage: "assets/images/ic_port_marker.png",
          ));
        }
      }).toList();
    }
  }

  void _onhandleRoute(PointOfInterest pointOfInterest) {
    LatLng _myCurrentLocation = LatLng(60.20, 22.0);
    LatLng _destinationLocation = LatLng(pointOfInterest.lat, pointOfInterest.lon);

    _mapController.addLine(
      LineOptions(
        geometry: [
          _myCurrentLocation,
          _destinationLocation
        ],
        lineColor: '#4B7CC6',
        lineWidth: 7.0,
        lineOpacity: 0.9,
        draggable: false,
      ),
    );
  }

  void _showBottomSheet(PointOfInterest harbour) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      barrierColor: barrierColor.withAlpha(200),
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 260 / MediaQuery.of(context).size.height,
        minChildSize: 0.2,
        maxChildSize: 0.95,
        builder: (context, controller) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0),
              )
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0),
              ),
              child: Column(
                children: [
                  SizedBox(height: 16.0,),
                  Row(
                    children: [
                      Spacer(),
                      Container(
                        width: 92,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                        ),
                      ),
                      Spacer()
                    ],
                  ),
                  SizedBox(height: 16.0,),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: controller,
                      child: Container(
                        child: Column(
                          children: [
                            BottomSheetHeader(habur: harbour, onTapRoute: () {
                              print("did tap route button");
                              Navigator.of(context).pop();
                              _onhandleRoute(harbour);
                            }, onTapSave: () {
                              print("did tap save button");
                            },),
                            SizedBox(height: 24.0,),
                            BottomSheetCarousel(harbour: harbour),
                            SizedBox(height: 16.0,),
                            BottomFamousePlace(habur: harbour),
                            BottomSheetDescription(habur: harbour),
                            Container(
                              color: Colors.white,
                              height: 200,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      )
    );
  }



  @override
  Widget build(BuildContext context) {
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
                MapboxMap(
                  initialCameraPosition: CameraPosition(target: LatLng(60, 20), zoom: 10),
                  accessToken: widget.mapboxApiKey,
                  styleString: widget.mapboxStyleString,
                  myLocationEnabled: false,
                  myLocationTrackingMode: MyLocationTrackingMode.Tracking,
                  attributionButtonMargins: Point(0, 10000),
                  onStyleLoadedCallback: () {
                    initInterestingData();
                  },
                  rotateGesturesEnabled: false,
                  onMapClick: (point, location) {
                    _mapController.updateMyLocationTrackingMode(MyLocationTrackingMode.None);
                  },
                  onMapCreated: (controller) {
                    _mapController = controller;
                    _mapController.onSymbolTapped.add((argument) {
                      print('symbold tapped');
                      if (targetInterestPlaces != null) {
                        for(int i = 0; i < targetInterestPlaces.length; i ++) {
                          double distance = calculateDistance(argument.options.geometry, LatLng(targetInterestPlaces[i].lat, targetInterestPlaces[i].lon));
                          if (distance < 0.3) {
                            print("name:" + targetInterestPlaces[i].name);
                            selectedPoint = targetInterestPlaces[i];
                            _showBottomSheet(targetInterestPlaces[i]);
                          }
                        }
                      }
                    });
                  },
                ),
                SpeedAndHeadingInfoBox(top: height < 670 ? 25 : 58),
                Positioned(
                    bottom: 40,
                    right: 24,
                    child: FloatingActionButton(
                      onPressed: () {
                        _mapController.updateMyLocationTrackingMode(MyLocationTrackingMode.Tracking);
                        _mapController.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(latitude, longitude), zoom: 10.0)));
                      },
                      child: Icon(Istos.crosshairs),
                    )
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
                Positioned(
                  left: 86,
                  top: height < 670 ? 25 : 58,
                  child: Container(
                    height: 46,
                    width: 46,
                    child: DecoratedBox(
                      decoration: MainButtonDecoration(),
                      child: FlatButton(
                        onPressed: () {
                          print("seach button tapped");
                          _navigationToSeachMainScreen(context);
                        },
                        child: Icon(Istos.search, color: Colors.grey, size: 16,),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  _navigationToSeachMainScreen(BuildContext context) async {
    _serachedPoi = await Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => SearchMain(),
      ),
    );
    if (_serachedPoi != null) {
      _mapController.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _serachedPoi, zoom: 10.0)));
    }
  }
}

