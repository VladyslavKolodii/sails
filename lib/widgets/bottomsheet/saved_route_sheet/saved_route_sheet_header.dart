import 'package:flutter/material.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';
import 'package:hybrid_sailmate/widgets/custom_buttons.dart';

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
          CustomFullRaisedButton(
            bgColor: mainColorBlue,
            strColor: Colors.white,
            btnText: 'Navigate',
            onPressed: () {

            },
          ),
          SizedBox(height: 16.0,),
          Container(
            height: 46.0,
            child: Row(
              children: [
                CustomFullFlatBtn(
                  onPressed: widget.onPressedEdit,
                  borderColor: mainColorBlue,
                  btnTitle: 'Edit',
                ),
                SizedBox(width: 24.0,),
                CustomFullFlatBtn(
                  onPressed: widget.onPressedDelete,
                  borderColor: mainColorBlue,
                  btnTitle: 'Delete',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
