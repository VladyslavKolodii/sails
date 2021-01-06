
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fontisto_flutter/fontisto_flutter.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';
import 'package:hybrid_sailmate/widgets/custom_appbar.dart';
import 'package:hybrid_sailmate/utils/common_util.dart';
import 'package:hybrid_sailmate/widgets/custom_textfields.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class AddPlaceOnMap extends StatefulWidget {
  @override
  _AddPlaceOnMapState createState() => _AddPlaceOnMapState();
}

class _AddPlaceOnMapState extends State<AddPlaceOnMap> {

  MapboxMapController _mapController;

  Widget _buildMapBox() {
    return MapboxMap(
      initialCameraPosition: CameraPosition(target: LatLng(61, 22.5), zoom: 5),
      accessToken: Common.mapApiKey,
      styleString: Common.mapboxStyleString,
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
        decoration: MainGradientDecoration(),
        child: Stack(
          children: [
            Column(
              children: [
                CustomAppBar(strTitle: 'Add place',),
                SizedBox(height: 12.0,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      CustomSearchTextField(
                        isEnabled: true,
                        hint: 'Search',
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
