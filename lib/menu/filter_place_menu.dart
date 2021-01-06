import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';

class FilterPlaceMenu extends StatelessWidget {
  final Function(String) didTapFilterItem;

  const FilterPlaceMenu({Key key, this.didTapFilterItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white
        ),
        child: Container(
          padding: EdgeInsets.only(top: 16.0, left: 16.0, bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sorting:', style: bottomSheetItemLabelLigtGrey12(),),
              SizedBox(height: 16.0,),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    didTapFilterItem('recently');
                  },
                  child: Text('Recently added top', style: bottomSheetItemLabelGrey12(),)
              ),
              SizedBox(height: 16.0,),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    didTapFilterItem('oldest');
                  },
                  child: Text('Oldest top', style: bottomSheetItemLabelGrey12(),)
              ),
              SizedBox(height: 16.0,),
              Container(
                height: 1.0,
                width: 118,
                color: Color(0xFFE5ECFB),
              ),
              SizedBox(height: 16.0,),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    didTapFilterItem('closer');
                  },
                  child: Text('Closer top', style: bottomSheetItemLabelGrey12(),)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
