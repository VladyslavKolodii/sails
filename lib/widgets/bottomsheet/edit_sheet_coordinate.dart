import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';
import 'package:hybrid_sailmate/widgets/custom_textfields.dart';

class EditSheetCoordinate extends StatefulWidget {
  @override
  _EditSheetCoordinateState createState() => _EditSheetCoordinateState();
}

class _EditSheetCoordinateState extends State<EditSheetCoordinate> {

  List<String> testData = [
    '60 °28.0 ′N, 60 °28.0 ′E',
    '',
  ];

  var switchVal = true;

  Widget _bindLocationItem(String str) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 8.0,),
        CustomMaskTextField(
          height: 48.0,
          strVal: str,
          strHint: 'Enter where are you going to navigate',
        ),
        SizedBox(height: 8.0,),
      ],
    );
  }

  Widget _bindRouteLine(int index) {
    return index % 2 == 0 ?
    Column(
      children: [
        Container(
          width: 9,
          height: 9,
          decoration: BoxDecoration(
            color: index == (testData.length - 1) * 2 ? mainColorBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(4.5),
            border: Border.all(
                color: mainColorBlue
            ),
          ),
        ),
      ],
    ) :
    Column(
      children: [
        Container(
          width: 1,
          height: 55,
          color: mainColorBlue,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 24.0, right: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Coordinates', style: bottomSheetTitle(),),
          SizedBox(height: 16.0,),
          Row(
            children: [
              Container(
                width: 9.0,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: testData.length * 2 - 1,
                  itemBuilder: (context, index) {
                    return _bindRouteLine(index);
                  },
                ),
              ),
              SizedBox(width: 16.0,),
              Expanded(
                flex: 1,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: testData.length,
                  itemBuilder: (context, index) {
                    return _bindLocationItem(testData[index]);
                  },
                )
              ),
              IconButton(
                onPressed: () {

                },
                icon: SvgPicture.asset('assets/images/ic_sort_change.svg'),
                iconSize: 24,
              )
            ],
          ),
          SizedBox(height: 8.0,),
          Container(
            margin: EdgeInsets.only(left: 26.0),
            child: SizedBox(
              height: 46.0,
              width: 46.0,
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    latlngMask.clear();
                    testData.add('');
                  });
                },
                padding: EdgeInsets.all(6.0),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Icon(Icons.add, color: mainColorBlue,),
              ),
            ),
          ),
          SizedBox(height: 16.0,),
          Row(
            children: [
              Transform.scale(
                scale: 0.8,
                child: CupertinoSwitch(
                  value: switchVal,
                  onChanged: (val) {
                    setState(() {
                      switchVal = val;
                    });
                  },
                  activeColor: Color(0xFF2DD429),
                ),
              ),
              Text('Show route on the map', style: bottomSheetItemLabel12(),)
            ],
          )
        ],
      ),
    );
  }
}
