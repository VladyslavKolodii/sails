import 'package:flutter/material.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';
import 'package:hybrid_sailmate/widgets/common/input_scaffold.dart';

class InputFieldWithTitle extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;

  const InputFieldWithTitle({
    Key key, 
    @required this.title,
    @required this.hint,
    @required this.controller,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: bottomSheetItemLabelLigtGrey12(),),
        SizedBox(height: 4.0,),
        InputScaffold(
          child: TextFormField(
            controller: controller,
            textCapitalization: TextCapitalization.none,
            autocorrect: false,
            style: bottomSheetItemLabel12(),
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: hint,
              hintStyle: bottomSheetItemLabelLigtGrey12(),
            ),
            onChanged: (inputValue) {
            },
          ),
          height: 46.0,
        )
      ],
    );
  }
}

