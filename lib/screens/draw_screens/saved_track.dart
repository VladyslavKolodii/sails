import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hybrid_sailmate/model/model_saved_tracks.dart';
import 'package:hybrid_sailmate/utils/common_util.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';
import 'package:hybrid_sailmate/widgets/alert/dialog_normal.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/saved_sheet_note.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/saved_track_sheet/saved_track_header.dart';
import 'package:hybrid_sailmate/widgets/custom_appbar.dart';
import 'package:hybrid_sailmate/widgets/custom_buttons.dart';
import 'package:hybrid_sailmate/widgets/custom_textfields.dart';
import 'package:hybrid_sailmate/widgets/route_info_item_widget.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class SavedTracks extends StatefulWidget {
  final String title;

  const SavedTracks({Key key, this.title}) : super(key: key);
  @override
  _SavedTracksState createState() => _SavedTracksState();
}

class _SavedTracksState extends State<SavedTracks> {
  final _scalffoldkey = GlobalKey<ScaffoldState>();
  SlidableController slidableController;
  var isSelectedList = true;
  MapboxMapController _mapController;

  @override
  void initState() {
    slidableController = SlidableController(
        onSlideAnimationChanged: (Animation<double> animation) {
          setState(() {

          });
        },
        onSlideIsOpenChanged: (bool isOpen) {
          setState(() {

          });
        }

    );
    super.initState();
  }

  @override
  void dispose() {
    if (_mapController != null) {
      _mapController.dispose();
    }
    super.dispose();
  }

  Widget _buildListView(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 0.0),
      itemCount: testTracks.length,
      itemBuilder: (context, index) {
        return Slidable.builder(
          key: Key(testTracks[index].id.toString()),
          controller: slidableController,
          direction: Axis.horizontal,
          dismissal: SlidableDismissal(
            child: SlidableDrawerDismissal(),
            closeOnCanceled: true,
            onDismissed: (actionType) {
              setState(() {
                testTracks.removeAt(index);
              });
            },
          ),
          actionPane: SlidableScrollActionPane(),
          actionExtentRatio: 0.25,
          child: onCreateRouteItem(testTracks[index]),
          secondaryActionDelegate: SlideActionBuilderDelegate (
              actionCount: 3,
              builder: (context, index, animation, renderingMode) {
                if(index == 0) {
                  return IconSlideAction(
                    caption: 'Delete',
                    color: Colors.white,
                    icon: Icons.delete_outline,
                    foregroundColor: Color(0xFFFF4343),
                    closeOnTap: false,
                    onTap: () async {
                      var state = Slidable.of(context);
                      var dismiss = await showDialog<bool>(context: context,
                          builder: (context) {
                            return DialogNormal(
                              title: 'Are you sure that you want delete this saved route?',
                              content: 'The explanation that your data will be deleted. Lorem ipsum dolor.',
                              okStr: 'Delete',
                              noStr: 'Cancel',
                              okAction: () {
                                Navigator.of(context).pop(true);
                                print('ok tapped 123456789');
                              },
                              noAction: () {
                                Navigator.of(context).pop(false);
                                print('no tapped 123456789');
                              },
                            );
                          }
                      );
                      if(dismiss) {
                        state.dismiss();
                      }
                    },
                  );
                } else if (index == 1) {
                  return IconSlideAction(
                    caption: 'Hide in map',
                    color: Colors.white,
                    icon: Icons.remove_red_eye_outlined,
                    foregroundColor: mainColorBlue,
                    closeOnTap: false,
                    onTap: () {
                      print('updated on $index');
                    },
                  );
                } else {
                  return IconSlideAction(
                    color: Colors.white,
                    icon: Icons.arrow_right_alt_outlined,
                    foregroundColor: Colors.grey.shade300,
                    closeOnTap: false,
                    onTap: () {
                      print('updated on $index');
                    },
                  );
                }
              }
          ),
        );
      },
    );
  }

  Widget onCreateRouteItem(ModelSavedTracks route) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          SizedBox(height: 24.0,),
          Container(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  route.name,
                                  style: blackLabel14(),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 12.0,),
                              Text('Duration ' + route.duration, style: blackLabel14(),)
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                'Route length-' + route.min.toString() + ' nmi',
                                style: bottomSheetItemLabelGrey12(),
                              ),
                              Spacer(),
                              Text(route.trackedDate + ' tracked', style: bottomSheetItemLabelGrey12(),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Image(
                      image: AssetImage('assets/images/ic_more.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 16.0),
            height: 1.0,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }

  Widget _buildMapBox() {
    return MapboxMap(
      initialCameraPosition: CameraPosition(target: LatLng(61, 22.5), zoom: 5),
      accessToken: Common.mapApiKey,
      styleString: Common.mapboxStyleString,
      myLocationEnabled: false,
      myLocationTrackingMode: MyLocationTrackingMode.Tracking,
      attributionButtonMargins: Point(0, 10000),
      onStyleLoadedCallback: () {
        _initDrawRoute();
      },
      rotateGesturesEnabled: false,
      onMapClick: (point, location) {
        _mapController.updateMyLocationTrackingMode(MyLocationTrackingMode.None);
      },
      onMapCreated: (controller) {
        _mapController = controller;
        _mapController.onLineTapped.add(_onLineTapped);
      },
    );
  }

  void _initDrawRoute() {
    for (var i = 0 ; i < testRouteCoordinates[0].routeCoordinates.length; i++) {
      if (i == 0 || i == testRouteCoordinates[0].routeCoordinates.length - 1) {
        _mapController.addSymbol(SymbolOptions(
            geometry: testRouteCoordinates[0].routeCoordinates[i],
            iconImage: 'assets/images/ic_port_marker.png',
            iconSize: 2.0
        ));
      }
    }

    _mapController.addLine(
      LineOptions(
        geometry: testRouteCoordinates[0].routeCoordinates,
        lineColor: '#3D3D3D',
        lineWidth: 7.0,
        lineOpacity: 0.6,
        draggable: false
      )
    );
  }

  void _onLineTapped(Line line) {
    _mapController.updateLine(line, LineOptions(
      lineOpacity: 1.0,
    ));
    _showBottomSheet();
  }

  void _showBottomSheet() {
    Common.prsentDraggableBottomSheet(
      context,
      240.0,
      Container(
        child: Column(
          children: [
            SavedTrackHeder(onPressedNavigate: () {
              Navigator.of(context).pop();
            }, onPressedDelete: () async {
              var dismiss = await showDialog<bool>(context: context,
                  builder: (context) {
                    return DialogNormal(
                      title: 'Are you sure that you want delete this saved route?',
                      content: 'The explanation that your data will be deleted. Lorem ipsum dolor.',
                      okStr: 'Delete',
                      noStr: 'Cancel',
                      okAction: () {
                        Navigator.of(context).pop(true);
                        print('ok tapped 123456789');
                      },
                      noAction: () {
                        Navigator.of(context).pop(false);
                        print('no tapped 123456789');
                      },
                    );
                  }
              );
              if(dismiss) {
                Navigator.of(context).pop();
              }
            },),
            SizedBox(height: 24.0,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('About route', style: bottomSheetItemLabel().copyWith(color: mainColorGray),),
                  SizedBox(height: 8.0,),
                  Container(
                    height: 76.0,
                    child: Row(
                      children: [
                        RouteInfoItem(bgColor: mainColorLightBlue, title: '57 hours', subtitle: 'duration',)
                      ],
                    )
                  )
                ],
              )
            ),
            SizedBox(height: 8.0,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  Container(
                    width: 22.0,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: testData.length * 2 - 1,
                      itemBuilder: (context, index) {
                        return _bindRouteLine(index);
                      },
                    ),
                  ),
                  SizedBox(width: 12.0,),
                  Expanded(
                      flex: 1,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: testData.length,
                        itemBuilder: (context, index) {
                          return _bindLocationItem(testData[index]);
                        },
                      )
                  )
                ],
              ),
            ),
            SizedBox(height: 8.0,),
            SavedSheetNote(),
            Container(
              color: Colors.transparent,
              height: 200,
            )
          ],
        ),
      ),
      SizedBox.shrink()
    );
  }

  Widget _bindLocationItem(String str) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 8.0,),
        CustomMaskTextField(
          height: 48.0,
          strVal: str,
        ),
        SizedBox(height: 8.0,),
      ],
    );
  }

  Widget _bindRouteLine(int index) {
    return index % 2 == 0 ?
    Column(
      children: [
        Container(
          width: 9,
          height: 9,
          decoration: BoxDecoration(
            color: index == (testData.length - 1) * 2 ? mainColorBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(4.5),
            border: Border.all(
                color: mainColorBlue
            ),
          ),
        ),
      ],
    ) :
    Column(
      children: [
        Container(
          height: 55,
          child: Center(
            child: RotatedBox(
              quarterTurns: -1,
              child: Text('12 min', style: buttonBlue().copyWith(height: 1.0),)
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scalffoldkey,
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.only(top: height < 670 ? 25 : 58),
        decoration: MainGradientDecoration(),
        child: Column(
          children: [
            CustomAppBar(strTitle: tr(widget.title),),
            SizedBox(height: 12.0,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  CustomSearchTextField(
                    isEnabled: true,
                    hint: 'What are you looking for?',
                  ),
                  SizedBox(width: 16.0,),
                  CustomSVGBtn(
                    isSelected: isSelectedList,
                    selectedIcon: 'assets/images/ic_list_blue.svg',
                    unSelectedIcon: 'assets/images/ic_list_inactive.svg',
                    onPressed: () {
                      setState(() {
                        isSelectedList = true;
                      });
                    },
                  ),
                  SizedBox(width: 8.0,),
                  CustomSVGBtn(
                    isSelected: !isSelectedList,
                    selectedIcon: 'assets/images/ic_map_view_inactive.svg',
                    unSelectedIcon: 'assets/images/ic_map_view.svg',
                    onPressed: () {
                      setState(() {
                        isSelectedList = false;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0,),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                      color: mainColorInput,
                    ),
                    child: isSelectedList ?  _buildListView(context) : _buildMapBox(),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Visibility(
                      visible: isSelectedList,
                      child: Container(
                        height: 46.0,
                        width: 46.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(4.0), bottomLeft: Radius.circular(4.0)),
                            boxShadow: [BoxShadow(color: Colors.white, offset: Offset(3, 3))]
                        ),
                        child:IconButton(
                          icon: SvgPicture.asset('assets/images/ic_filter_vertical.svg'),
                          onPressed: () {
                            _scalffoldkey.currentState.openEndDrawer();
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
