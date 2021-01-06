import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';

class CustomIconBtn extends StatelessWidget {
  final IconData icon;
  final Function function;
  final double iconSize;

  const CustomIconBtn({Key key, this.icon, this.function, this.iconSize = 12.0}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      width: 46,
      child: DecoratedBox(
        decoration: MainButtonDecoration(),
        child: FlatButton(
          onPressed: function,
          child: Icon(icon, color: Colors.grey, size: iconSize),
        ),
      ),
    );
  }
}

class CustomBackBtn extends StatelessWidget {
  final Function function;
  const CustomBackBtn({Key key, this.function}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 46.0,
        width: 46.0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: function != null ? BackButton(onPressed: function) : BackButton(),
        )
    );
  }
}

class CustomSVGBtn extends StatelessWidget {
  final bool isSelected;
  final String selectedIcon;
  final String unSelectedIcon;
  final Function onPressed;

  const CustomSVGBtn({Key key, this.isSelected, this.selectedIcon, this.unSelectedIcon, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 46.0,
      height: 46.0,
      child: Container(
        decoration: !isSelected ? MainButtonDecoration() : MainBoxDecoration(mainColorBlue),
        child: IconButton(
          onPressed: onPressed,
          icon: SvgPicture.asset(isSelected ? selectedIcon : unSelectedIcon),
          iconSize: 12.0,
          color: Colors.grey,
        ),
      ),
    );
  }
}

class CustomFullRaisedButton extends StatelessWidget {
  final Color bgColor;
  final Color strColor;
  final String btnText;
  final Function onPressed;
  final double height;
  final IconData icon;

  const CustomFullRaisedButton({Key key, this.bgColor, this.strColor, this.onPressed, this.btnText, this.height = 46.0, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      // width: double.infinity,
      child: RaisedButton(
        onPressed: onPressed,
        color: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: icon == null ? false : true,
              child: Icon(icon, size: 16.0, color: strColor,),
            ),
            Visibility(
              visible: icon == null ? false : true,
              child: SizedBox(width: 4.0,)
            ),
            Text(btnText, style: buttonWhite().copyWith(color: strColor),)
          ],
        ),
      ),
    );
  }
}

class CustomFullFlatBtn extends StatelessWidget {
  final Color bgColor;
  final Color borderColor;
  final Color strColor;
  final IconData icon;
  final String btnTitle;
  final Function onPressed;

  const CustomFullFlatBtn({Key key, this.bgColor, this.borderColor, this.strColor, this.icon, this.btnTitle, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: FlatButton(
        onPressed: onPressed,
        color: bgColor ?? Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: borderColor != null ? 1.0 : 0.0
          )
        ),
        height: 46.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: icon != null ? true : false,
              child: Icon(icon, color: strColor,)
            ),
            SizedBox(width: icon != null ? 4.0 : 0.0,),
            Text(btnTitle, style: buttonBlue().copyWith(color: strColor ?? mainColorBlue),)
          ],
        ),
      ),
    );
  }
}





