import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hybrid_sailmate/menu/filter_place_menu.dart';
import 'package:hybrid_sailmate/model/model_saved_places.dart';
import 'package:hybrid_sailmate/screens/add_place_manual.dart';
import 'package:hybrid_sailmate/screens/add_place_map.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';
import 'package:hybrid_sailmate/widgets/alert/dialog_normal.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/bottom_sheet_carousel.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/edit_sheet_coordinate.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/edit_sheet_header.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/bottom_famouse_place.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/bottom_sheet_description.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/edit_sheet_note.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/saved_place_sheet/saved_place_sheet_header.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/saved_sheet_note.dart';
import 'package:hybrid_sailmate/widgets/extended_add.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../../utils/common_util.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_buttons.dart';
import '../../widgets/custom_textfields.dart';

class SavedPlaces extends StatefulWidget {
  final String title;

  const SavedPlaces({Key key, this.title}) : super(key: key);
  @override
  _SavedPlacesState createState() => _SavedPlacesState();
}

class _SavedPlacesState extends State<SavedPlaces> {

  var isSelectedList = true;
  var isExtendedFloatingButton = false;
  SlidableController slidableController;
  MapboxMapController _mapController;
  final _scalffoldkey = GlobalKey<ScaffoldState>();

  void _showExtendedWidget() {
    setState(() {
      isExtendedFloatingButton = !isExtendedFloatingButton;
    });
  }

  Widget _buildListView(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 12.0),
      itemCount: testPlaces.length,
      itemBuilder: (context, index) {
        return Slidable.builder(
          key: Key(testPlaces[index].id.toString()),
          controller: slidableController,
          direction: Axis.horizontal,
          dismissal: SlidableDismissal(
            child: SlidableDrawerDismissal(),
            closeOnCanceled: true,
            onDismissed: (actionType) {
              setState(() {
                testPlaces.removeAt(index);
              });
            },
          ),
          actionPane: SlidableScrollActionPane(),
          actionExtentRatio: 0.25,
          child: onCreatePlaceItem(testPlaces[index]),
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
                              title: 'Are you sure that you want delete this saved place?',
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

  Widget onCreatePlaceItem(ModelSavedPlaces place) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(place.imgUrl, width: 112.0, height: 126.0, fit: BoxFit.cover,)
              ),
              SizedBox(width: 16.0,),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          place.name,
                          style: blackLabel14(),
                        ),
                        Image.asset('assets/images/ic_more.png'),
                      ],
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      place.type,
                      style: bottomSheetItemLabelLigtGrey12(),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Image(
                          width: 10.0,
                          height: 12.0,
                          image: AssetImage('assets/images/ic_latlng.png'),
                        ),
                        SizedBox(width: 4.0,),
                        Text('60 °28.0 ′N, 60 °28.0 ′E', style: bottomSheetItemLabel12(),),
                      ],
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      place.min.toString() + ' nmi from you',
                      style: bottomSheetItemLabelGrey12(),
                    ),
                    SizedBox(height: 4.0),
                    Text(place.date + ' added', style: bottomSheetItemLabelGrey12(),),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 16.0,),
          Container(height: 1.0, color: Color(0xFFE5CFB),),
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
        _initAddMarkerMap();
      },
      rotateGesturesEnabled: false,
      onMapClick: (point, location) {
        _mapController.updateMyLocationTrackingMode(MyLocationTrackingMode.None);
      },
      onMapCreated: (controller) {
        _mapController = controller;
        _mapController.onSymbolTapped.add((argument) {
          print('symbold tapped');
          if (testPlaces != null) {
            for(var i = 0; i < testPlaces.length; i ++) {
              var distance = Common.calculateDistance(argument.options.geometry, LatLng(testPlaces[i].latLng.latitude, testPlaces[i].latLng.longitude));
              if (distance < 0.3) {
                _showBottomSheet(testPlaces[i]);
              }
            }
          }
        });
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

  void _showBottomSheet(ModelSavedPlaces place) {
    Common.prsentDraggableBottomSheet(
      context,
      310.0,
      Container(
        child: Column(
          children: [
            SavedPlaceSheetHeader(place: place, onTapRoute: () {
              // Navigator.of(context).pop();
            }, onTapEdit: () {
              Navigator.of(context).pop();
              _showEditRouteBottomsheet();
            },),
            SizedBox(height: 24.0,),
            BottomSheetCarousel(),
            SizedBox(height: 16.0,),
            BottomFamousePlace(),
            BottomSheetDescription(),
            SizedBox(height: 24.0,),
            SavedSheetNote(),
            Container(
              color: Colors.white,
              height: 200,
            )
          ],
        ),
      ),
      SizedBox.shrink()
    );
  }

  void _showEditRouteBottomsheet() {
    Common.prsentDraggableBottomSheet(
      context,
      352.0,
      Container(
        child: Column(
          children: [
            EditSheetHeader(title: 'Edit saved place', nameLB: 'Place name', nameHint: 'Enter your place name', dateLB: 'Planned start date', dateHint: 'April 13, 2020',),
            SizedBox(height: 24,),
            EditSheetCoordinate(),
            SizedBox(height: 24,),
            EditSheetNote(),
            Container(
              color: Colors.transparent,
              height: 200,
            )
          ],
        ),
      ),
      CustomFullRaisedButton(
        bgColor: mainColorBlue,
        strColor: Colors.white,
        btnText: 'Save',
        onPressed: () async {
          await showDialog<bool>(context: context,
              builder: (context) {
                return DialogNormal(
                  title: 'Do you want to save changes?',
                  content: 'The explanation that your data will be not saved',
                  okStr: 'Save',
                  noStr: 'Discard',
                  okAction: () {
                    Navigator.of(context).pop(true);
                  },
                  noAction: () {
                    Navigator.of(context).pop(false);
                  },
                );
              }
          );
        },
      ),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scalffoldkey,
      backgroundColor: Colors.transparent,
      endDrawer: Padding(
        padding: const EdgeInsets.only(top: 410, bottom: 210),
        child: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), bottomLeft: Radius.circular(16.0)),
          child: SizedBox(
              width: 150,
              child: FilterPlaceMenu(didTapFilterItem: (value) {
                print('1234568798456413' + value);
                setState(() {

                });
              },)
          ),
        ),
      ),
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
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                        color: Colors.white
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
                                color: mainColorInput,
                              ),
                              child: isSelectedList ?  _buildListView(context) : _buildMapBox(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: isExtendedFloatingButton,
                    child: ExtendedAdd(
                      addMap: () {
                        setState(() {
                          isExtendedFloatingButton = false;
                        });
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddPlaceOnMap()),);
                      },
                      addCoordinate: () {
                        setState(() {
                          isExtendedFloatingButton = false;
                        });
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddPlaceManual()),);
                      },
                    ),
                  ),
                  Positioned(
                    right: 24.0,
                    bottom: 40.0,
                    child: FloatingActionButton(
                      onPressed: _showExtendedWidget,
                      backgroundColor: mainColorBlue,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
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
