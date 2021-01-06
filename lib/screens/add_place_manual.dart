import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/edit_sheet_coordinate.dart';
import 'package:hybrid_sailmate/widgets/custom_appbar.dart';
import 'package:hybrid_sailmate/widgets/custom_buttons.dart';

class AddPlaceManual extends StatefulWidget {
  @override
  _AddPlaceManualState createState() => _AddPlaceManualState();
}

class _AddPlaceManualState extends State<AddPlaceManual> {

  final _scalffoldkey = GlobalKey<ScaffoldState>();

  Widget _bindAddNote() {
    return Container(
      margin: EdgeInsets.only(right: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Add note', style: bottomSheetTitle(),),
              Spacer(),
              Row(
                children: [
                  SvgPicture.asset('assets/images/ic_camera.svg'),
                  SizedBox(width: 4.0,),
                  Text('Uplaod photo', style: buttonBlue(),)
                ],
              ),
            ],
          ),
          SizedBox(height: 16.0,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            height: 97,
            decoration: MainBoxDecoration(Colors.white),
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              maxLength: null,
              decoration: InputDecoration(
                  hintText: 'Enter your note',
                  border: InputBorder.none
              ),
              style: bottomSheetItemLabel12(),
            ),
          ),
          SizedBox(height: 16.0,),
          // _bindUploadPhoto(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scalffoldkey,
      body: Container(
        padding: EdgeInsets.only(top: height < 670 ? 25 : 58),
        decoration: MainGradientDecoration(),
        child: Column(
          children: [
            CustomAppBar(strTitle: 'Add place',),
            SizedBox(height: 24.0,),
            Container(
              height: 46.0,
              margin: EdgeInsets.symmetric(horizontal: 24.0),
              child: DecoratedBox(
                decoration: MainButtonDecoration(),
                child: TextFormField(
                  style: bottomSheetItemLabel12(),
                  onChanged: (value) {
                    print(value);
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
                    border: InputBorder.none,
                    hintText: 'Enter place name *',
                    hintStyle: bottomSheetItemLabelLigtGrey12(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0,),
            Container(
              height: 46.0,
              margin: EdgeInsets.symmetric(horizontal: 24.0),
              child: DecoratedBox(
                decoration: MainButtonDecoration(),
                child: TextFormField(
                  style: bottomSheetItemLabel12(),
                  onChanged: (value) {
                    print(value);
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
                    border: InputBorder.none,
                    hintText: 'Plan start date',
                    hintStyle: bottomSheetItemLabelLigtGrey12(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.0,),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                      color: mainColorInput
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 24.0,),
                        EditSheetCoordinate(),
                        Container(
                          margin: EdgeInsets.fromLTRB(24.0, 24.0, 0.0, 0.0),
                          child: _bindAddNote()
                        ),
                        SizedBox(height: 16.0,),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 24.0),
                          child: Row(
                            children: [
                              CustomFullFlatBtn(
                                bgColor: mainColorBlue,
                                strColor: Colors.white,
                                btnTitle: 'Save',
                                onPressed: () {

                                },
                              ),
                            ],
                          )
                        ),
                        Container(
                          color: Colors.transparent,
                          height: 200,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
