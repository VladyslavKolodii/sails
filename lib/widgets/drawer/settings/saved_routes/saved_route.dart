import 'dart:math';

import 'package:align_positioned/align_positioned.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fontisto_flutter/fontisto_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hybrid_sailmate/model/model_route.dart';
import 'package:hybrid_sailmate/model/model_route_latlng.dart';
import 'package:hybrid_sailmate/widgets/alert/dialog_normal.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/edit_route_sheet/edit_route_sheet_coordinate.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/edit_route_sheet/edit_route_sheet_header.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/edit_route_sheet/edit_route_sheet_note.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/saved_route_sheet/saved_route_sheet_about.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/saved_route_sheet/saved_route_sheet_header.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/saved_route_sheet/saved_route_sheet_note.dart';
import 'package:hybrid_sailmate/widgets/common/main_button_decoration.dart';
import 'package:hybrid_sailmate/widgets/drawer/settings/saved_routes/filter_route_menu.dart';
import 'package:hybrid_sailmate/widgets/global_widget.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../../../text_styles.dart';
import '../../main_drawer.dart';

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

  Line _selectedLine;

  final List<ModelRoute> testRoutes = [
    ModelRoute(0, "Scout port 12 34 567 89 123456", 6, "Oct 13, 2020", "Apr 12, 2020", true),
    ModelRoute(1, "Second title of Route", 12, "Oct 13, 2020", "Apr 12, 2020", true),
    ModelRoute(2, "Title of route", 12, "Oct 13, 2020", "Apr 14, 2020", false),
    ModelRoute(3, "Title of route", 12, "Oct 13, 2020", "Apr 14, 2020", false),
    ModelRoute(4, "Second title of Route", 12, "Oct 13, 2020", "Apr 12, 2020", true),
    ModelRoute(5, "Title of route", 12, "Oct 13, 2020", "Apr 14, 2020", false),
    ModelRoute(6, "Title of route", 12, "Oct 13, 2020", "Apr 14, 2020", false),
    ModelRoute(7, "Title of route", 12, "Oct 13, 2020", "Apr 14, 2020", false),
    ModelRoute(8, "Second title of Route", 12, "Oct 13, 2020", "Apr 12, 2020", true),
    ModelRoute(9, "Title of route", 12, "Oct 13, 2020", "Apr 14, 2020", false),
    ModelRoute(10, "Title of route", 12, "Oct 13, 2020", "Apr 14, 2020", false),
    ModelRoute(11, "Title of route", 12, "Oct 13, 2020", "Apr 14, 2020", false),
    ModelRoute(12, "Second title of Route", 12, "Oct 13, 2020", "Apr 12, 2020", true),
    ModelRoute(13, "Title of route", 12, "Oct 13, 2020", "Apr 14, 2020", false),
    ModelRoute(14, "Title of route", 12, "Oct 13, 2020", "Apr 14, 2020", false),
    ModelRoute(15, "Title of route", 12, "Oct 13, 2020", "Apr 14, 2020", false),
    ModelRoute(16, "Second title of Route", 12, "Oct 13, 2020", "Apr 12, 2020", true),
    ModelRoute(17, "Title of route", 12, "Oct 13, 2020", "Apr 14, 2020", false),
  ];
  MapboxMapController _mapController;
  final List<ModelRouteCoordinate> testRouteCoordinates = [
    ModelRouteCoordinate([LatLng(60.20, 22.0), LatLng(60.65, 22.3), LatLng(60.75, 21.5)]),
    ModelRouteCoordinate([LatLng(62.20, 23.0), LatLng(62.75, 22.5)]),
  ];

  void _showExtendedWidget() {
    setState(() {
      isExtendedFloatingButton = !isExtendedFloatingButton;
    });
  }

  void manageSelectedTabBar(int index) {
    for (int i = 0; i < indicators.length; i++) {
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
            child: Text(title, style: indicators[index] ? TextStyles.bottomSheetItemLabel12() : TextStyles.bottomSheetItemLabelGrey12(),)
        ),
        SizedBox(height: 14.0,),
        Visibility(
          visible: indicators[index],
          child: Container(
            width: 38,
            height: 2.0,
            color: mainBlue,
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
                                  style: TextStyles.blackLabel14(),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 12.0,),
                              Visibility(
                                visible: route.isPlanned,
                                child: Image(
                                  image: AssetImage("assets/images/ic_plan.png"),
                                  width: 16.0,
                                  height: 16.0,
                                ),
                              ),
                              Visibility(visible: route.isPlanned,child: SizedBox(width: 4.0,)),
                              Text(route.isPlanned ? "Plan to " + route.date : "Visited " + route.date, style: TextStyles.blackLabel14(),)
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                "Route length-" + route.min.toString() + " nmi",
                                style: TextStyles.bottomSheetItemLabelGrey12(),
                              ),
                              Spacer(),
                              Text(route.addedDate + " added", style: TextStyles.bottomSheetItemLabelGrey12(),),
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
                      image: AssetImage("assets/images/ic_more.png"),
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
                              title: "Are you sure that you want delete this saved route?",
                              content: "The explanation that your data will be deleted. Lorem ipsum dolor.",
                              okStr: "Delete",
                              noStr: "Cancel",
                              okAction: () {
                                Navigator.of(context).pop(true);
                                print("ok tapped 123456789");
                              },
                              noAction: () {
                                Navigator.of(context).pop(false);
                                print("no tapped 123456789");
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
                    foregroundColor: mainBlue,
                    closeOnTap: false,
                    onTap: () {
                      print("updated on $index");
                    },
                  );
                } else {
                  return IconSlideAction(
                    color: Colors.white,
                    icon: Icons.arrow_right_alt_outlined,
                    foregroundColor: Colors.grey.shade300,
                    closeOnTap: false,
                    onTap: () {
                      print("updated on $index");
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
    for (ModelRouteCoordinate model in testRouteCoordinates) {

      for (int i = 0; i < model.routeCoordinates.length; i++) {
        var iconImage = "";
        var iconSize = 0.0;
        var textSize = 0.0;
        var textFiled = "";
        var textColor = "";
        if (i == 0) {
          iconImage = "assets/images/ic_start_marker.png";
          iconSize = 3.0;
          textSize = 11;
          textColor = "#FFFFFF";
          textFiled = "Start";
        } else if (i == model.routeCoordinates.length - 1) {
          iconImage = "assets/images/ic_end_marker.png";
          iconSize = 3.0;
          textSize = 11;
          textColor = "#3D3D3D";
          textFiled = "End";
        } else {
          iconImage = "assets/images/ic_start_marker.png";
          iconSize = 2.0;
          textSize = 8;
          textColor = "#FFFFFF";
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
      accessToken: GlobalWidget.mapApiKey,
      styleString: GlobalWidget.mapboxStyleString,
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
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        barrierColor: barrierColor.withAlpha(100),
        backgroundColor: Colors.transparent,
        builder: (context) => DraggableScrollableSheet(
          initialChildSize: 240 / MediaQuery.of(context).size.height,
          minChildSize: 0.2,
          maxChildSize: 0.95,
          builder: (context, controller) {
            return Container(
              decoration: BoxDecoration(
                  color: Color(0xFFF2F5F9),
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
                    SizedBox(height: 24.0,),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: controller,
                        child: Container(
                          child: Column(
                            children: [
                              SavedRouteSheetHeader(onPressedEdit: () {
                                Navigator.of(context).pop();
                                _showEditRouteBottomsheet();
                              }, onPressedDelete: () async {
                                var dismiss = await showDialog<bool>(context: context,
                                    builder: (context) {
                                      return DialogNormal(
                                        title: "Are you sure that you want delete this saved route?",
                                        content: "The explanation that your data will be deleted. Lorem ipsum dolor.",
                                        okStr: "Delete",
                                        noStr: "Cancel",
                                        okAction: () {
                                          Navigator.of(context).pop(true);
                                          print("ok tapped 123456789");
                                        },
                                        noAction: () {
                                          Navigator.of(context).pop(false);
                                          print("no tapped 123456789");
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
                              SavedRouteSheetNote(),
                              Container(
                                color: Colors.transparent,
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

  void _showEditRouteBottomsheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      barrierColor: barrierColor.withAlpha(100),
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 352 / MediaQuery.of(context).size.height,
        minChildSize: 0.2,
        maxChildSize: 0.95,
        builder: (context, controller) {
          return Container(
            decoration: BoxDecoration(
                color: Color(0xFFF2F5F9),
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
              child: Stack(
                children: [
                  Column(
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
                      SizedBox(height: 24.0,),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: controller,
                          child: Container(
                            child: Column(
                              children: [
                                EditRouteSheetHeader(),
                                SizedBox(height: 24,),
                                EditRouteSheetCoordinate(),
                                SizedBox(height: 24,),
                                EditRouteSheetNote(),
                                Container(
                                  color: Colors.transparent,
                                  height: 200,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    left: 24, bottom: 40, right: 24,
                    child: SizedBox(
                      height: 46.0,
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () async {await showDialog<bool>(context: context,
                            builder: (context) {
                              return DialogNormal(
                                title: "Do you want to save changes?",
                                content: "The explanation that your data will be not saved",
                                okStr: "Save",
                                noStr: "Discard",
                                okAction: () {
                                  Navigator.of(context).pop(true);
                                  print("ok tapped 123456789");
                                },
                                noAction: () {
                                  Navigator.of(context).pop(false);
                                  print("no tapped 123456789");
                                },
                              );
                            }
                          );
                        },
                        color: mainBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Text("Save", style: TextStyles.buttonWhite(),),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      )
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
    // TODO: implement dispose
    _mapController.dispose();
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
              print("1234568798456413" + value);
              setState(() {

              });
            },)
          ),
        ),
      ),
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
        child: Column(
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
                  Expanded(child: Center(child: Text(tr(widget.title), style: TextStyles.bottomSheetTitle()))),
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
                          style: TextStyles.bottomSheetItemLabel12(),
                          onChanged: (value) {
                            print(value);
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Istos.search,
                              size: 16.0,
                              color: mainBlue,
                            ),
                            hintText: "What are you looking for?",
                            hintStyle: TextStyles.bottomSheetItemLabelLigtGrey12(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0,),
                  SizedBox(
                    width: 46.0,
                    height: 46.0,
                    child: Container(
                      decoration: isSelectedList ? GlobalWidget.MainBoxDecoration(mainBlue) : MainButtonDecoration(),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            isSelectedList = true;
                          });
                        },
                        icon: SvgPicture.asset(isSelectedList ? "assets/images/ic_list_blue.svg" : "assets/images/ic_list_inactive.svg"),
                        iconSize: 12.0,
                        color: mainBlue,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0,),
                  SizedBox(
                    width: 46.0,
                    height: 46.0,
                    child: Container(
                      decoration: isSelectedList ? MainButtonDecoration() : GlobalWidget.MainBoxDecoration(mainBlue),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            isSelectedList = false;
                          });
                        },
                        icon: SvgPicture.asset(isSelectedList ? "assets/images/ic_map_view.svg" : "assets/images/ic_map_view_inactive.svg"),
                        iconSize: 12.0,
                        color: Colors.grey,
                      ),
                    ),
                  )
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
                              createTabbar(0, "All(12)"),
                              Container(width: 1, height: 22.0, color: Colors.grey[300],),
                              createTabbar(1, "Plans(4)"),
                              Container(width: 1, height: 22.0, color: Colors.grey[300],),
                              createTabbar(2, "Past(2)"),
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
                                color: Color(0xFFF2F5F9),
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
                    child: Positioned(
                      bottom: 0.0,
                      right: 0.0,
                      child: Transform(
                        transform: Matrix4.translationValues(150, 150, 0),
                        child: Container(
                          width: 410,
                          height: 410,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFE5ECFB),
                          ),
                          child: Transform(
                            transform: Matrix4.translationValues(70, 80, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {

                                  },
                                  child: Text(
                                    "+ Add on the map",
                                    style: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w600, color: mainBlue, decoration: TextDecoration.underline),
                                  ),
                                ),
                                SizedBox(height: 16.0),
                                GestureDetector(
                                  onTap: () {

                                  },
                                  child: Text(
                                    "+ Add by coordinates",
                                    style: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w600, color: mainBlue, decoration: TextDecoration.underline),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 24.0,
                    bottom: 40.0,
                    child: FloatingActionButton(
                      onPressed: _showExtendedWidget,
                      backgroundColor: mainBlue,
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
                          icon: SvgPicture.asset("assets/images/ic_filter_vertical.svg"),
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
