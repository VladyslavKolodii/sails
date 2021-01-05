import 'package:flutter/material.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';

class SavedRouteSheetHeader extends StatefulWidget {
  final Function onPressedEdit, onPressedDelete;

  const SavedRouteSheetHeader({Key key, this.onPressedEdit, this.onPressedDelete}) : super(key: key);
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
                  child: ClipRRect(child: Image.asset('assets/images/img_sample.png', fit: BoxFit.cover,), borderRadius: BorderRadius.circular(8.0),)
              ),
              SizedBox(width: 16.0,),
              Container(
                height: 126.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Route name', style: bottomSheetItemLabel(),),
                    Text('12 apr 2020 added', style: bottomSheetItemLabelLigtGrey12(),),
                    Row(
                      children: [
                        Image.asset('assets/images/ic_plan.png', width: 16.0, height: 16.0,),
                        SizedBox(width: 6.0,),
                        Text('Plan to Apr 12, 2020', style: bottomSheetItemLabel()),
                      ],
                    ),
                    Text('Route length - 6 nmi', style: bottomSheetItemLabelGrey12(),),
                    GestureDetector(
                        onTap: () {

                        },
                        child: Text('Hide in map', style: underlineBtn14(),)
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
              color: mainColorBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Text('Navigate', style: buttonWhite(),),
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
                            color: mainColorBlue,
                            width: 1.0
                        )
                    ),
                    height: 46.0,
                    onPressed: widget.onPressedEdit,
                    child: Text('Edit', style: buttonBlue(),),
                  ),
                ),
                SizedBox(width: 24.0,),
                Expanded(
                  flex: 1,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(
                            color: mainColorBlue,
                            width: 1.0
                        )
                    ),
                    height: 46.0,
                    onPressed: widget.onPressedDelete,
                    child: Text('Delete', style: buttonBlue()),
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
