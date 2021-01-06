import 'package:flutter/material.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';
import 'package:hybrid_sailmate/widgets/custom_buttons.dart';
import 'package:point_of_interest_repository/point_of_interest_repository.dart';

class BottomSheetHeader extends StatelessWidget {
  final PointOfInterest habur;
  final Function onTapRoute, onTapSave;

  const BottomSheetHeader({Key key, @required this.habur, @required this.onTapRoute, @required this.onTapSave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.0, right: 24.0),
      height: 210,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 8.0, top: 8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  child: Image(
                    height: 210.0,
                    width: 170,
                    image: AssetImage('assets/images/image_16.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16.0,),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Select starting point', style: bottomSheetItemLabel(),),
                        Text('Harbour', style: bottomSheetItemLabelGrey12(),),
                        SizedBox(height: 4.0,),
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
                        Text('9 Km from you', style: bottomSheetItemLabelLigtGrey12(),),
                        SizedBox(height: 16.0,),
                        CustomFullRaisedButton(
                          bgColor: mainColorBlue,
                          strColor: Colors.white,
                          btnText: 'Route to',
                          icon: Icons.watch_later_outlined,
                          onPressed: () {

                          },
                        ),
                        SizedBox(height: 8.0,),
                        CustomFullRaisedButton(
                          bgColor: mainColorBlue,
                          strColor: Colors.white,
                          btnText: 'Save place',
                          icon: Icons.favorite_border_outlined,
                          onPressed: () {

                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            child: Container(
              alignment: Alignment.center,
              height: 34.0,
              width: 34.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                color: Colors.lightBlueAccent[100],
              ),
              child: Image(
                height: 12.0,
                width: 12.0,
                image: AssetImage('assets/images/ic_port.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
