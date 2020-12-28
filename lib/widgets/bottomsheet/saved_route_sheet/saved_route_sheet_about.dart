import 'package:flutter/material.dart';
import 'package:hybrid_sailmate/widgets/global_widget.dart';
import 'package:hybrid_sailmate/widgets/text_styles.dart';

class SavedRouteSheetAbout extends StatefulWidget {
  @override
  _SavedRouteSheetAboutState createState() => _SavedRouteSheetAboutState();
}

class _SavedRouteSheetAboutState extends State<SavedRouteSheetAbout> {

  List<String> testData = [
    "60 °28.0 ′N, 60 °28.0 ′E",
    "60 °28.0 ′N, 60 °28.0 ′E",
    "60 °28.0 ′N, 60 °28.0 ′E",
  ];

  Widget _bindLocationItem(String str) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 8.0,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          width: double.infinity,
          height: 46,
          decoration: GlobalWidget.MainBoxDecoration(Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(str, style: TextStyles.bottomSheetItemLabel()),
            ],
          ),
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
              color: index == (testData.length - 1) * 2 ? mainBlue : Colors.transparent,
              borderRadius: BorderRadius.circular(4.5),
              border: Border.all(
                  color: mainBlue
              ),
            ),
          ),
        ],
      ) :
    Column(
      children: [
        Container(
          width: 1,
          height: 53,
          color: mainBlue,
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
          Text("About route", style: TextStyles.bottomSheetTitle(),),
          SizedBox(height: 8.0,),
          Container(
            height: 76.0,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                    ),
                    height: 76.0,
                    color: Color(0xFFE5ECFB),
                    onPressed: (){

                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Spacer(),
                        Text("3", style: TextStyles.bottomSheetItemLabel(),),
                        Text("ways", style: TextStyles.bottomSheetItemLabelLigtGrey12()),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 24.0,),
                Expanded(
                  flex: 1,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)
                    ),
                    color: Color(0xFFE5ECFB),
                    height: 76.0,
                    onPressed: () {

                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Spacer(),
                        Text("57 hours", style: TextStyles.bottomSheetItemLabel(),),
                        Text("duration", style: TextStyles.bottomSheetItemLabelLigtGrey12()),
                        Spacer(),
                      ],
                    ),
                  ),
                )
              ],
            ),
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
