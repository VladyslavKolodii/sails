import 'package:flutter/material.dart';
import 'package:fontisto_flutter/fontisto_flutter.dart';
import 'package:hybrid_sailmate/widgets/common/main_button_decoration.dart';
import 'package:hybrid_sailmate/widgets/global_widget.dart';
import 'package:hybrid_sailmate/widgets/text_styles.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:point_of_interest_repository/point_of_interest_repository.dart';

class SearchMain extends StatefulWidget {
  TextEditingController searchKeyController = TextEditingController();
  TextEditingController coordinateController = TextEditingController();

  @override
  _SearchMainState createState() => _SearchMainState();
}

class _SearchMainState extends State<SearchMain> {


  bool isTapedSearchByCoordinate = false;

  List<PointOfInterest> filteredPOIS = List<PointOfInterest>();

  Future<bool> _onHandleBack() {
    if (isTapedSearchByCoordinate) {
      setState(() {
        isTapedSearchByCoordinate = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: _onHandleBack,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.fromLTRB(24.0, height < 670 ? 25 : 58, 24.0, 24.0),
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
              Row(
                children: [
                  SizedBox(
                    height: 46,
                    width: 46,
                    child: DecoratedBox(
                      decoration: MainButtonDecoration(),
                      child: FlatButton(
                        onPressed: () {
                          GlobalWidget.latlngMask.clear();
                          widget.coordinateController.clear();
                          _onHandleBack();
                        },
                        child: Icon(Istos.arrow_left_l, color: Colors.grey, size: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0,),
                  Expanded(
                    child: SizedBox(
                      height: 46.0,
                      child: DecoratedBox(
                        decoration: MainButtonDecoration(),
                        child: TextFormField(
                          controller: widget.searchKeyController,
                          style: TextStyles.bottomSheetItemLabel12(),
                          enabled: !isTapedSearchByCoordinate,
                          onChanged: (value) {
                            print(value);
                            filteredPOIS.clear();
                            setState(() {
                              if (value.isNotEmpty) {
                                for(PointOfInterest poi in Common.gPOIs) {
                                  if (poi.name.contains(value)) {
                                    filteredPOIS.add(poi);
                                  }
                                }
                              } else {
                                filteredPOIS.clear();
                              }

                            });
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
                  )
                ],
              ),
              SizedBox(height: 16.0,),
              Visibility(
                visible: !isTapedSearchByCoordinate,
                child: Expanded(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isTapedSearchByCoordinate = true;
                          });
                        },
                        child: SizedBox(
                          height: 46.0,
                          width: double.infinity,
                          child: DecoratedBox(
                            decoration: MainButtonDecoration(),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Or search by coordinate",
                                    style: TextStyles.bottomSheetItemLabel12(),
                                  ),
                                  Icon(Istos.arrow_right_l, size: 12.0, color: mainBlue,)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.0,),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: filteredPOIS.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                filteredPOIS[index].name, style: TextStyles.bottomSheetItemLabel(),
                              ),
                              onTap: () {
                                print("In search Main: ////// " + '${filteredPOIS[index].lat}' + "/////" + '${filteredPOIS[index].lon}');
                                LatLng selectedPosition = new LatLng(filteredPOIS[index].lat, filteredPOIS[index].lon);
                                Navigator.pop(context, selectedPosition);
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: isTapedSearchByCoordinate,
                child: Column(
                  children: [
                    SizedBox(
                      height: 46.0,
                      width: double.infinity,
                      child: DecoratedBox(
                        decoration: GlobalWidget.MainBoxDecoration(Color(0xff4B7CC6)),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextFormField(
                            controller: widget.coordinateController,
                            style: TextStyles.bottomSheetItemLabel12(),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
                              border: InputBorder.none,
                              hintText: "N: - - ° - - - ′, E: - - ° - - - ′",
                              hintStyle: TextStyles.bottomSheetItemLabelLigtGrey12(),
                            ),
                            inputFormatters: [GlobalWidget.latlngMask],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0,),
                    RaisedButton(
                      onPressed: () {
                        print("did tap search by coordinate button");
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)
                      ),
                      color: mainBlue,
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      child: Text(
                        "Search by coordinates",
                        style: TextStyles.buttonWhite(),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
