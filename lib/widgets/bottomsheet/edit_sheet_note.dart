import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';
import 'package:hybrid_sailmate/widgets/upload_photo_widget.dart';

import '../note_grid_item_widget.dart';

class EditSheetNote extends StatefulWidget {
  @override
  _EditSheetNoteState createState() => _EditSheetNoteState();
}

class _EditSheetNoteState extends State<EditSheetNote> {

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
            UploadPhoto()
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
        NoteGridItem(),
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
