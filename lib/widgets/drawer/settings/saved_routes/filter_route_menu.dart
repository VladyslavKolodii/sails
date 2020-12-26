import 'package:flutter/material.dart';

import '../../../text_styles.dart';

class FilterRouteMenu extends StatelessWidget {
  final Function(String) didTapFilterItem;

  const FilterRouteMenu({Key key, @required this.didTapFilterItem}) : super(key: key);
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
              Text("Sorting:", style: TextStyles.bottomSheetItemLabelLigtGrey12(),),
              SizedBox(height: 16.0,),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  didTapFilterItem('recently');
                },
                child: Text("Recently added top", style: TextStyles.bottomSheetItemLabelGrey12(),)
              ),
              SizedBox(height: 16.0,),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    didTapFilterItem('oldest');
                  },
                  child: Text("Oldest top", style: TextStyles.bottomSheetItemLabelGrey12(),)
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
                  child: Text("Closer top", style: TextStyles.bottomSheetItemLabelGrey12(),)
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
                    didTapFilterItem('length_shorter');
                  },
                  child: Text("Length shorter", style: TextStyles.bottomSheetItemLabelGrey12(),)
              ),
              SizedBox(height: 16.0,),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop('length_longer');
                    didTapFilterItem('length_longer');
                  },
                  child: Text("Length longer", style: TextStyles.bottomSheetItemLabelGrey12(),)
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
                    didTapFilterItem('name_az');
                  },
                  child: Text("Name A-Z", style: TextStyles.bottomSheetItemLabelGrey12(),)
              ),
              SizedBox(height: 16.0,),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop('name_za');
                    didTapFilterItem('name_za');
                  },
                  child: Text("Name Z-A", style: TextStyles.bottomSheetItemLabelGrey12(),)
              ),
            ],
          ),
        ),
      ),
    );
  }
}

