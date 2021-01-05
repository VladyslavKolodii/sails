import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';
import 'package:hybrid_sailmate/widgets/global_widget.dart';

class SavedRouteSheetNote extends StatefulWidget {
  @override
  _SavedRouteSheetNoteState createState() => _SavedRouteSheetNoteState();
}

class _SavedRouteSheetNoteState extends State<SavedRouteSheetNote> {

  var isAddNote = false;

  Widget _bindAddNote() {
    return Visibility(
      visible: isAddNote,
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
          Row(
            children: [
              SvgPicture.asset('assets/images/ic_camera.svg'),
              SizedBox(width: 4.0,),
              Text('Uplaod photo', style: buttonBlue(),)
            ],
          )
        ],
      ),
    );
  }

  Widget _bindYourNote() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
        SizedBox(height: 4.0,),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (context, index) {
            return _bindYourNoteItem();
          },
        )
      ],
    );
  }

  Widget _bindYourNoteItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 4.0,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Apr 13, 2020', style: bottomSheetItemLabelLigtGrey12(),),
            SizedBox(width: 8.0,),
            Expanded(child: Text('Somenote amet minim. Mollit non deserunt ullamco, ateest dolor do amet sint.', style: bottomSheetItemLabelGrey12(), maxLines: null,))
          ],
        ),
        SizedBox(height: 16.0,),
        ClipRRect(
            child: Image.asset('assets/images/img_sample_1.png', width: double.infinity, height: 160.0, fit: BoxFit.fill,)
        ),
        SizedBox(height: 12.0,),
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
          _bindAddNote(),
          SizedBox(height: isAddNote ? 24.0 : 0.0,),
          _bindYourNote(),
        ],
      ),
    );
  }
}
