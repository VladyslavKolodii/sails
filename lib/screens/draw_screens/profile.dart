import 'package:flutter/material.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';

import '../../widgets/custom_buttons.dart';
import '../../widgets/custom_textfields.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  var isExpanded = false;
  var preEmailContriller = new TextEditingController();
  var newEmailContriller = new TextEditingController();

  Widget _bindChangeEmailUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24.0,),
        InputFieldWithTitle(title: 'Previous Email', hint: 'Enter Previous Email', controller: preEmailContriller),
        SizedBox(height: 16.0,),
        InputFieldWithTitle(title: 'New Email', hint: 'Enter New Email', controller: newEmailContriller),
        SizedBox(height: 24.0,),
        CustomFullRaisedButton(
          bgColor: mainColorDisabled,
          strColor: Colors.white,
          btnText: 'Save',
          onPressed: () {
            setState(() => {
              isExpanded = false
            });
          },
        ),
        SizedBox(height: MediaQuery.of(context).viewInsets.bottom,)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileInfo(title: 'Full Name', value: 'Samantha Jones'),
          SizedBox(height: 16.0,),
          ProfileInfo(title: 'Email', value: 'samantha.jones@gmail.com'),
          SizedBox(height: 36.0,),
          Container(
            width: MediaQuery.of(context).size.width,
            child: CustomFullFlatBtn(
              borderColor: mainColorBlue,
              btnTitle: 'Change Email',
              onPressed: () {
                setState(() => {
                  isExpanded = true
                });
              },
            ),
          ),
          isExpanded
              ?  _bindChangeEmailUI()
              : SizedBox.shrink()
        ],
      ),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  final String title;
  final String value;

  const ProfileInfo({Key key, @required this.title, @required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: bottomSheetItemLabelLigtGrey12(),),
        SizedBox(height: 4.0,),
        Container(
          width: double.infinity,
          height: 46.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.white10, width: 1),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: bottomSheetItemLabel(),)
            ],
          ),
        )
      ],
    );
  }
}

