import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';
import 'package:hybrid_sailmate/widgets/bottomsheet/edit_route_sheet/edit_route_sheet_coordinate.dart';
import 'package:hybrid_sailmate/widgets/common/main_button_decoration.dart';
import 'package:hybrid_sailmate/widgets/global_widget.dart';

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
            decoration: GlobalWidget.MainBoxDecoration(Colors.white),
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
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.4, 0.95],
              colors: [Color(0xFFD6DFF0), Colors.white.withOpacity(0.9), Colors.white],
            )
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      height: 46.0,
                      width: 46.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: BackButton(),
                      )
                  ),
                  Expanded(child: Center(child: Text('Add place', style: bottomSheetTitle()))),
                  SizedBox(width: 46),
                ],
              ),
            ),
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
                      color: Color(0xFFF2F5F9)
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 24,),
                        EditRouteSheetCoordinate(),
                        Container(
                          margin: EdgeInsets.all(24.0),
                          child: _bindAddNote()
                        ),
                        SizedBox(height: 32.0,),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 24.0),
                          child: FlatButton(
                            height: 46.0,
                            onPressed: () {

                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            ),
                            color: mainColorBlue,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Save', style: buttonWhite(),)
                              ],
                            ),
                          ),
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
