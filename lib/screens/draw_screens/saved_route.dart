import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hybrid_sailmate/menu/filter_route_menu.dart';
import 'package:hybrid_sailmate/model/model_route.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';
import 'package:hybrid_sailmate/widgets/alert/dialog_normal.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/edit_sheet_coordinate.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/edit_sheet_header.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/edit_sheet_note.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/saved_route_sheet/saved_route_sheet_about.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/saved_route_sheet/saved_route_sheet_header.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/saved_sheet_note.dart';
import 'package:hybrid_sailmate/widgets/custom_appbar.dart';
import 'package:hybrid_sailmate/widgets/custom_buttons.dart';
import 'package:hybrid_sailmate/utils/common_util.dart';
import 'package:hybrid_sailmate/widgets/extended_add.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import '../../widgets/custom_textfields.dart';

class SavedRoutes extends StatefulWidget {

  final String title;

  const SavedRoutes({Key key, this.title}) : super(key: key);

  @override
  _SavedRoutesState createState() => _SavedRoutesState();
}

class _SavedRoutesState extends State<SavedRoutes> {
  List<bool> indicators = [true, false, false];

  SlidableController slidableController;

  var isSelectedList = true;

  var isExtendedFloatingButton = false;

  MapboxMapController _mapController;

  void _showExtendedWidget() {
    setState(() {
      isExtendedFloatingButton = !isExtendedFloatingButton;
    });
  }

  void manageSelectedTabBar(int index) {
    for (var i = 0; i < indicators.length; i++) {
      if (i == index) {
        indicators[i] = true;
      } else {
        indicators[i] = false;
      }
    }
    setState(() {

    });
  }

  Widget createTabbar(int index, String title) {
    return Column(
      children: [
        GestureDetector(
            onTap: () {
              manageSelectedTabBar(index);
            },
            child: Text(title, style: indicators[index] ? bottomSheetItemLabel12() : bottomSheetItemLabelGrey12(),)
        ),
        SizedBox(height: 14.0,),
        Visibility(
          visible: indicators[index],
          child: Container(
            width: 38,
            height: 2.0,
            color: mainColorBlue,
          ),
        )
      ],
    );
  }

  Widget onCreateRouteItem(ModelRoute route) {
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
                              Visibility(
                                visible: route.isPlanned,
                                child: Image(
                                  image: AssetImage('assets/images/ic_plan.png'),
                                  width: 16.0,
                                  height: 16.0,
                                ),
                              ),
                              Visibility(visible: route.isPlanned,child: SizedBox(width: 4.0,)),
                              Text(route.isPlanned ? 'Plan to ' + route.date : 'Visited ' + route.date, style: blackLabel14(),)
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
                              Text(route.addedDate + ' added', style: bottomSheetItemLabelGrey12(),),
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

  Widget _buildListView(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 0.0),
      itemCount: testRoutes.length,
      itemBuilder: (context, index) {
        return Slidable.builder(
          key: Key(testRoutes[index].id.toString()),
          controller: slidableController,
          direction: Axis.horizontal,
          dismissal: SlidableDismissal(
            child: SlidableDrawerDismissal(),
            closeOnCanceled: true,
            onDismissed: (actionType) {
              setState(() {
                testRoutes.removeAt(index);
              });
            },
          ),
          actionPane: SlidableScrollActionPane(),
          actionExtentRatio: 0.25,
          child: onCreateRouteItem(testRoutes[index]),
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

  void _initDrawRoute() {
    for (var model in testRouteCoordinates) {

      for (var i = 0; i < model.routeCoordinates.length; i++) {
        var iconImage = '';
        var iconSize = 0.0;
        var textSize = 0.0;
        var textFiled = '';
        var textColor = '';
        if (i == 0) {
          iconImage = 'assets/images/ic_start_marker.png';
          iconSize = 3.0;
          textSize = 11;
          textColor = '#FFFFFF';
          textFiled = 'Start';
        } else if (i == model.routeCoordinates.length - 1) {
          iconImage = 'assets/images/ic_end_marker.png';
          iconSize = 3.0;
          textSize = 11;
          textColor = '#3D3D3D';
          textFiled = 'End';
        } else {
          iconImage = 'assets/images/ic_start_marker.png';
          iconSize = 2.0;
          textSize = 8;
          textColor = '#FFFFFF';
          textFiled = i.toString();
        }
        _mapController.addSymbol(SymbolOptions(
          geometry: model.routeCoordinates[i],
          iconImage: iconImage,
          iconSize: iconSize,
          textField: textFiled,
          textColor: textColor,
          textSize: textSize,
          textOffset: Offset(0, -0.5)
        ));
      }

      _mapController.addLine(
        LineOptions(
          geometry: model.routeCoordinates,
          lineColor: '#3D3D3D',
          lineWidth: 7.0,
          lineOpacity: 0.6,
          draggable: false,
        ),
      );
    }
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
            SavedRouteSheetHeader(onPressedEdit: () {
              Navigator.of(context).pop();
              _showEditRouteBottomsheet();
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
            SavedRouteSheetAbout(),
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

  void _showEditRouteBottomsheet() {
    Common.prsentDraggableBottomSheet(
      context,
      352,
      Container(
        child: Column(
          children: [
            EditSheetHeader(title: 'Edit route', nameLB: 'Route name', nameHint: 'Enter your route name', dateLB: 'Planned start date', dateHint: 'April 13, 2020',),
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

  final _scalffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scalffoldkey,
      backgroundColor: Colors.transparent,
      endDrawer: Padding(
        padding: const EdgeInsets.only(top: 318, bottom: 120),
        child: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), bottomLeft: Radius.circular(16.0)),
          child: SizedBox(
            width: 150,
            child: FilterRouteMenu(didTapFilterItem: (value) {
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
                    padding: EdgeInsets.only(top: 16.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                        color: Colors.white
                    ),
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              createTabbar(0, 'All(12)'),
                              Container(width: 1, height: 22.0, color: Colors.grey[300],),
                              createTabbar(1, 'Plans(4)'),
                              Container(width: 1, height: 22.0, color: Colors.grey[300],),
                              createTabbar(2, 'Past(2)'),
                            ],
                          ),
                        ),
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

                      },
                      addCoordinate: () {

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
