import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';
import 'package:hybrid_sailmate/widgets/common/main_button_decoration.dart';

import '../../global_widget.dart';

class EditRouteSheetNote extends StatefulWidget {
  @override
  _EditRouteSheetNoteState createState() => _EditRouteSheetNoteState();
}

class _EditRouteSheetNoteState extends State<EditRouteSheetNote> {

  var isAddNote = false;

  Widget _bindAddNote() {
    return Visibility(
      visible: isAddNote,
      child: Container(
        margin: EdgeInsets.only(right: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Add note', style: bottomSheetTitle(),),
                Spacer(),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        isAddNote = false;
                      });
                    },
                    child: Text('save', style: underlineBtn14(),)
                ),
                SizedBox(width: 24,),
                InkWell(
                  onTap: () {
                    setState(() {
                      isAddNote = false;
                    });
                  },
                  child: Container(
                      height: 24.0,
                      width: 24.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12.0))
                      ),
                      child: Icon(Icons.close, size: 12,color: mainColorBlue,)
                  ),
                )
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
            _bindUploadPhoto(),
          ],
        ),
      ),
    );
  }

  Widget _bindYourNote() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(right: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Your note: ', style: bottomSheetTitle(),),
              Visibility(
                visible: !isAddNote,
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isAddNote = true;
                      });
                    },
                    child: Text('+ Add note', style: underlineBtn14(),)
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 4.0,),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (context, index) {
            var imgCnt = 0;
            if (index == 0) {
              imgCnt = 2;
            } else if (index == 1) {
              imgCnt = 1;
            } else {
              imgCnt = 3;
            }
            return _bindYourNoteItem(imgCnt);
          },
        )
      ],
    );
  }

  Widget _bindYourNoteItem(int imageCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12.0,),
        Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 60.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Apr 13, 2020', style: bottomSheetItemLabelLigtGrey12(),),
                    _bindUploadPhoto()
                  ],
                ),
              ),
              SizedBox(height: 8.0,),
              Container(
                margin: EdgeInsets.only(right: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                          decoration: MainButtonDecoration(),
                          child: Text('Somenote amet minim. Mollit non deserunt ullamco, ateest dolor do amet sint.', style: bottomSheetItemLabelGrey12(), maxLines: null,)
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.all(0.0),
                      icon: Icon(Icons.restore_from_trash_outlined, color: Color(0xFFFF4343), size: 24,),
                    )
                  ],
                ),
              ),
              SizedBox(height: 8.0,),
              Container(
                margin: EdgeInsets.only(right: 60.0),
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  crossAxisCount: 2,
                  childAspectRatio: 143 / 74,
                  children: List.generate(imageCount, (index) {
                    return _bindPhotoCell();
                  }),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 12.0,),
      ],
    );
  }

  Widget _bindPhotoCell() {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 8.0, right: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0))
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            child: Image.asset('assets/images/img_sample_1.png', fit: BoxFit.cover,),
          ),
        ),
        Positioned(
          top: 0.0,
          right: 0.0,
          child: Container(
            height: 24,
            width: 24,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              color: Colors.white
            ),
            child: Icon(Icons.close, size: 8, color: mainColorBlue,),
          ),
        )
      ],
    );
  }

  Widget _bindUploadPhoto() {
    return Row(
      children: [
        SvgPicture.asset('assets/images/ic_camera.svg'),
        SizedBox(width: 4.0,),
        Text('Uplaod photo', style: buttonBlue(),)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _bindAddNote(),
          SizedBox(height: isAddNote ? 24.0 : 0.0,),
          _bindYourNote(),
        ],
      ),
    );
  }
}
