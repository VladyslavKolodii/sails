import 'package:flutter/material.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';

import '../../custom_buttons.dart';

class SavedTrackHeder extends StatelessWidget {
  final Function onPressedNavigate, onPressedDelete;

  const SavedTrackHeder({Key key, this.onPressedNavigate, this.onPressedDelete}) : super(key: key);
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
                    Text('Select starting point', style: bottomSheetItemLabel(),),
                    Text('Route length - 6 nmi', style: bottomSheetItemLabelLigtGrey12(),),
                    Text('Duration 57h 44m', style: bottomSheetItemLabelGrey12()),
                    Text('Tracked 12 Apr 2020', style: bottomSheetItemLabelLigtGrey12(),),
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
          SizedBox(height: 16.0,),
          Container(
            height: 46.0,
            child: Row(
              children: [
                CustomFullFlatBtn(
                  onPressed: onPressedNavigate,
                  bgColor: mainColorBlue,
                  btnTitle: 'Edit',
                  strColor: Colors.white,
                ),
                SizedBox(width: 24.0,),
                CustomFullFlatBtn(
                  onPressed: onPressedDelete,
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
