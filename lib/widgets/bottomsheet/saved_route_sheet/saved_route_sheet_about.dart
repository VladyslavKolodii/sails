import 'package:flutter/material.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';
import 'package:hybrid_sailmate/widgets/custom_textfields.dart';
import 'package:hybrid_sailmate/widgets/route_info_widget.dart';

class SavedRouteSheetAbout extends StatefulWidget {
  @override
  _SavedRouteSheetAboutState createState() => _SavedRouteSheetAboutState();
}

class _SavedRouteSheetAboutState extends State<SavedRouteSheetAbout> {

  Widget _bindLocationItem(String str) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 8.0,),
        CustomMaskTextField(
          height: 48.0,
          strVal: str,
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
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About route', style: bottomSheetTitle(),),
          SizedBox(height: 8.0,),
          RouteInfo(
            bgColor: mainColorLightBlue,
            title1: '3',
            subtitle1: 'ways',
            title2: '57 hours',
            subtitle2: 'duration',
          ),
          SizedBox(height: 8.0,),
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
              )
            ],
          )
        ],
      ),
    );
  }
}
