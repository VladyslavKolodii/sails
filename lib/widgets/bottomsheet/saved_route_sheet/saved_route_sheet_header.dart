import 'package:flutter/material.dart';

import '../../text_styles.dart';

class SavedRouteSheetHeader extends StatefulWidget {
  @override
  _SavedRouteSheetHeaderState createState() => _SavedRouteSheetHeaderState();
}

class _SavedRouteSheetHeaderState extends State<SavedRouteSheetHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  width: 126.0,
                  height: 126.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: ClipRRect(child: Image.asset("assets/images/img_sample.png", fit: BoxFit.cover,), borderRadius: BorderRadius.circular(8.0),)
              ),
              SizedBox(width: 16.0,),
              Container(
                height: 126.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Route name", style: TextStyles.bottomSheetItemLabel(),),
                    Text("12 apr 2020 added", style: TextStyles.bottomSheetItemLabelLigtGrey12(),),
                    Row(
                      children: [
                        Image.asset("assets/images/ic_plan.png", width: 16.0, height: 16.0,),
                        SizedBox(width: 6.0,),
                        Text("Plan to Apr 12, 2020", style: TextStyles.bottomSheetItemLabel()),
                      ],
                    ),
                    Text("Route length - 6 nmi", style: TextStyles.bottomSheetItemLabelGrey12(),),
                    GestureDetector(
                        onTap: () {

                        },
                        child: Text("Hide in map", style: TextStyles.underlineBtn14(),)
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 16.0,),
          SizedBox(
            height: 46.0,
            width: double.infinity,
            child: RaisedButton(
              onPressed: () => {

              },
              color: mainBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Text("Navigate", style: TextStyles.buttonWhite(),),
            ),
          ),
          SizedBox(height: 16.0,),
          Container(
            height: 46.0,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(
                            color: mainBlue,
                            width: 1.0
                        )
                    ),
                    height: 46.0,
                    onPressed: (){

                    },
                    child: Text("Edit", style: TextStyles.buttonBlue(),),
                  ),
                ),
                SizedBox(width: 24.0,),
                Expanded(
                  flex: 1,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(
                            color: mainBlue,
                            width: 1.0
                        )
                    ),
                    height: 46.0,
                    onPressed: () {

                    },
                    child: Text("Delete", style: TextStyles.buttonBlue()),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
