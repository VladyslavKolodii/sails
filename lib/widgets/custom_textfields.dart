import 'package:flutter/material.dart';
import 'package:fontisto_flutter/fontisto_flutter.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';


class CustomNormalTextField extends StatelessWidget {
  final double height;
  final String strHint;
  final TextEditingController controller;

  const CustomNormalTextField({Key key, this.height, this.strHint, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      width: double.infinity,
      height: height,
      decoration: MainBoxDecoration(Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller,
            style: bottomSheetItemLabel(),
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: strHint,
              hintStyle: bottomSheetItemLabelLigtGrey12()
            ),
          )
        ],
      ),
    );
  }
}

class CustomMaskTextField extends StatelessWidget {
  final double height;
  final String strHint;
  final String strVal;
  final TextEditingController controller;

  const CustomMaskTextField({Key key, this.height, this.strHint, this.strVal, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      width: double.infinity,
      height: height,
      decoration: MainBoxDecoration(Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            enabled: strVal.isEmpty ? true : false,
            initialValue: strVal ?? '',
            style: bottomSheetItemLabel(),
            inputFormatters: [latlngMask],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: strHint ?? '',
              hintStyle: bottomSheetItemLabelLigtGrey12()
            ),
          )
        ],
      ),
    );
  }
}

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

class InputScaffold extends StatelessWidget {
  InputScaffold({ @required this.child, this.color, this.height = 60.0 }) : super();

  final Widget child;
  final Color color;
  final double  height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: color ?? Colors.white,
        border: Border.all(color: Colors.white10, width: 1),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: height == 60.0 ? 10 : 5.0, horizontal: 16),
        child: child,
      ),
    );
  }
}

class CustomSearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Function onChanged;
  final bool isEnabled;

  const CustomSearchTextField({Key key, this.controller, this.hint, this.onChanged, this.isEnabled}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: SizedBox(
        height: 46.0,
        child: DecoratedBox(
          decoration: MainButtonDecoration(),
          child: TextFormField(
            controller: controller,
            style: bottomSheetItemLabel12(),
            enabled: isEnabled,
            onChanged: onChanged,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
              border: InputBorder.none,
              prefixIcon: Icon(
                Istos.search,
                size: 16.0,
                color: mainColorBlue,
              ),
              hintText: hint,
              hintStyle: bottomSheetItemLabelLigtGrey12(),
            ),
          ),
        ),
      ),
    );
  }
}

