
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fontisto_flutter/fontisto_flutter.dart';
import 'package:hybrid_sailmate/model/model_saved_places.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';
import 'package:hybrid_sailmate/widgets/common/main_button_decoration.dart';
import 'package:hybrid_sailmate/widgets/global_widget.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class AddPlaceOnMap extends StatefulWidget {
  @override
  _AddPlaceOnMapState createState() => _AddPlaceOnMapState();
}

class _AddPlaceOnMapState extends State<AddPlaceOnMap> {

  MapboxMapController _mapController;

  final List<ModelSavedPlaces> testPlaces = [
    ModelSavedPlaces(0, 'Point of interest', 'Harbour', 'Oct 13, 2020', 6, LatLng(60.20, 22.0), 'assets/images/img_sample.png'),
    ModelSavedPlaces(1, 'Point of interest', 'Scout port', 'Oct 14, 2020', 8, LatLng(60.25, 22.5), 'assets/images/img_sample.png'),
    ModelSavedPlaces(2, 'Point of interest', 'Harbour', 'Oct 15, 2020', 6, LatLng(60.50, 23.0), 'assets/images/img_sample.png'),
    ModelSavedPlaces(3, 'Point of interest', 'Scout port', 'Oct 18, 2020', 8, LatLng(60.75, 22.25), 'assets/images/img_sample.png'),
    ModelSavedPlaces(4, 'Point of interest', 'Harbour', 'Oct 17, 2020', 6, LatLng(61.00, 22.5), 'assets/images/img_sample.png'),
    ModelSavedPlaces(5, 'Point of interest', 'Scout port', 'Oct 11, 2020', 8, LatLng(61.25, 22.0), 'assets/images/img_sample.png'),
    ModelSavedPlaces(6, 'Point of interest', 'Harbour', 'Oct 10, 2020', 6, LatLng(61.50, 21.75), 'assets/images/img_sample.png'),
    ModelSavedPlaces(7, 'Point of interest', 'Scout port', 'Oct 20, 2020', 8, LatLng(60.00, 22.0), 'assets/images/img_sample.png'),
  ];

  Widget _buildMapBox() {
    return MapboxMap(
      initialCameraPosition: CameraPosition(target: LatLng(61, 22.5), zoom: 5),
      accessToken: GlobalWidget.mapApiKey,
      styleString: GlobalWidget.mapboxStyleString,
      myLocationEnabled: false,
      myLocationTrackingMode: MyLocationTrackingMode.Tracking,
      attributionButtonMargins: Point(0, 10000),
      onStyleLoadedCallback: () {
        _initAddMarkerMap();
      },
      rotateGesturesEnabled: false,
      onMapClick: (point, location) {
        _mapController.updateMyLocationTrackingMode(MyLocationTrackingMode.None);
      },
      onMapCreated: (controller) {
        _mapController = controller;
        // _mapController.onSymbolTapped.add((argument) {
        //   print('symbold tapped');
        //   if (testPlaces != null) {
        //     for(int i = 0; i < testPlaces.length; i ++) {
        //       double distance = calculateDistance(argument.options.geometry, LatLng(testPlaces[i].latLng.latitude, testPlaces[i].latLng.longitude));
        //       if (distance < 0.3) {
        //         _showBottomSheet(testPlaces[i]);
        //       }
        //     }
        //   }
        // });
      },
    );
  }

  void _initAddMarkerMap() {
    for (var model in testPlaces) {
      _mapController.addSymbol(SymbolOptions(
        geometry: LatLng(model.latLng.latitude, model.latLng.longitude),
        iconImage: "assets/images/ic_port_marker.png",
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: height < 670 ? 25 : 58),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.4, 0.95],
            colors: [Color(0xFFD6DFF0), Colors.white.withOpacity(0.9), Colors.white],
          )
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          height: 46.0,
                          width: 46.0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: BackButton(),
                          )
                      ),
                      Expanded(child: Center(child: Text('Add place', style: bottomSheetTitle()))),
                      SizedBox(width: 46),
                    ],
                  ),
                ),
                SizedBox(height: 12.0,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 46.0,
                          child: DecoratedBox(
                            decoration: MainButtonDecoration(),
                            child: TextFormField(
                              style: bottomSheetItemLabel12(),
                              onChanged: (value) {
                                print(value);
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Istos.search,
                                  size: 16.0,
                                  color: mainColorBlue,
                                ),
                                hintText: 'Search',
                                hintStyle: bottomSheetItemLabelLigtGrey12(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.0,),
                Expanded(
                    flex: 1,
                    child: _buildMapBox()
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 152.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0)),
                  boxShadow: [
                    BoxShadow(color: Colors.grey, offset: Offset(3.0, 3.0), blurRadius: 12.0, spreadRadius: 3.0),
                  ]
                ),
                child: Column(
                  children: [
                    SizedBox(height: 16.0,),
                    Container(
                      width: 92,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      ),
                    ),
                    SizedBox(height: 24.0,),
                    Text('Choose point on the map', style: bottomSheetItemLabel(),),
                    SizedBox(height: 24.0,),
                    Text('Or select my current location.', style: underlineBtn14(),)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
