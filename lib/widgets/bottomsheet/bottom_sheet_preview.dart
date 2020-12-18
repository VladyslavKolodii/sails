import 'package:flutter/material.dart';
import 'package:hybrid_sailmate/widgets/button/icon_button.dart';
import 'package:hybrid_sailmate/widgets/text_styles.dart';
import 'package:point_of_interest_repository/point_of_interest_repository.dart';

class BottomSheetHeader extends StatelessWidget {
  final PointOfInterest habur;

  const BottomSheetHeader({Key key, @required this.habur}) : super(key: key);

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
                    image: AssetImage("assets/images/image_16.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16.0,),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Select starting point', style: TextStyles.bottomSheetItemLabel(),),
                        Text('Harbour', style: TextStyles.bottomSheetItemLabelGrey12(),),
                        SizedBox(height: 4.0,),
                        Row(
                          children: [
                            Image(
                              width: 10.0,
                              height: 12.0,
                              image: AssetImage("assets/images/ic_latlng.png"),
                            ),
                            SizedBox(width: 4.0,),
                            Text("60 °28.0 ′N, 60 °28.0 ′E", style: TextStyles.bottomSheetItemLabel12(),),
                          ],
                        ),
                        Text("9 Km from you", style: TextStyles.bottomSheetItemLabelLigtGrey12(),),
                        SizedBox(height: 16.0,),
                        CustomIconButton(txt: "Route to", icon: Icons.watch_later_outlined, txtColor: Colors.white, iconColor: Colors.white, paddingHorizontal: 31.5, backgroundColor: mainBlue, radius: 8.0, paddingVertical: 10.0),
                        SizedBox(height: 8.0,),
                        CustomIconButton(txt: "Save place", icon: Icons.favorite_border, txtColor: Colors.white, iconColor: Colors.white, paddingHorizontal: 31.5, backgroundColor: mainBlue, radius: 8.0, paddingVertical: 10.0),
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
                image: AssetImage("assets/images/ic_port.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
