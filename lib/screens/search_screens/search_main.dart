import 'package:flutter/material.dart';
import 'package:fontisto_flutter/fontisto_flutter.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';
import 'package:hybrid_sailmate/utils/common_util.dart';
import 'package:hybrid_sailmate/widgets/custom_buttons.dart';
import 'package:hybrid_sailmate/widgets/custom_textfields.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:point_of_interest_repository/point_of_interest_repository.dart';

class SearchMain extends StatefulWidget {
  TextEditingController searchKeyController = TextEditingController();
  TextEditingController coordinateController = TextEditingController();

  @override
  _SearchMainState createState() => _SearchMainState();
}

class _SearchMainState extends State<SearchMain> {


  bool isTapedSearchByCoordinate = false;

  List<PointOfInterest> filteredPOIS = <PointOfInterest>[];

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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: _onHandleBack,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            padding: EdgeInsets.fromLTRB(24.0, height < 670 ? 25 : 58, 24.0, 24.0),
            decoration: MainGradientDecoration(),
            child: Column(
              children: [
                Row(
                  children: [
                    CustomBackBtn(function: () {
                      latlngMask.clear();
                      widget.coordinateController.clear();
                      _onHandleBack();
                    },),
                    SizedBox(width: 16.0,),
                    CustomSearchTextField(
                      controller: widget.searchKeyController,
                      isEnabled: !isTapedSearchByCoordinate,
                      hint: 'What are you looking for?',
                      onChanged: (value) {
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
                                      'Or search by coordinate',
                                      style: bottomSheetItemLabel12(),
                                    ),
                                    Icon(Istos.arrow_right_l, size: 12.0, color: mainColorBlue,)
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
                                  filteredPOIS[index].name, style: bottomSheetItemLabel(),
                                ),
                                onTap: () {
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
                      CustomMaskTextField(
                        height: 48.0,
                        strHint: 'N: - - ° - - - ′, E: - - ° - - - ′',
                        strVal: '',
                      ),
                      SizedBox(height: 40.0,),
                      RaisedButton(
                        onPressed: () {
                          print('did tap search by coordinate button');
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)
                        ),
                        color: mainColorBlue,
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        child: Text(
                          'Search by coordinates',
                          style: buttonWhite(),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
