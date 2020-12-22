import 'package:flutter/material.dart';
import 'package:hybrid_sailmate/widgets/common/input_scaffold.dart';
import 'package:hybrid_sailmate/widgets/text_styles.dart';
import 'package:easy_localization/easy_localization.dart';

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
        Text(title, style: TextStyles.bottomSheetItemLabelLigtGrey12(),),
        SizedBox(height: 4.0,),
        InputScaffold(
          child: TextFormField(
            controller: controller,
            textCapitalization: TextCapitalization.none,
            autocorrect: false,
            style: TextStyles.bottomSheetItemLabel12(),
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyles.bottomSheetItemLabelLigtGrey12(),
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

