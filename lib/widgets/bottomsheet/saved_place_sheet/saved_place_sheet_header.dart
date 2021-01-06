import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hybrid_sailmate/model/model_saved_places.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';
import 'package:hybrid_sailmate/widgets/alert/dialog_normal.dart';
import 'package:hybrid_sailmate/widgets/custom_buttons.dart';

class SavedPlaceSheetHeader extends StatelessWidget {

  final ModelSavedPlaces place;
  final Function onTapRoute;
  final Function onTapEdit;

  const SavedPlaceSheetHeader({Key key, this.place, this.onTapRoute, this.onTapEdit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 8.0),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset('assets/images/img_sample.png', width: 126.0, height: 126.0, fit: BoxFit.cover,)
                  ),
                  SizedBox(width: 16.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(place.name, style: bottomSheetItemLabel(),),
                      SizedBox(height: 8.0,),
                      Row(
                        children: [
                          Image(
                            width: 10.0,
                            height: 12.0,
                            image: AssetImage('assets/images/ic_latlng.png'),
                          ),
                          SizedBox(width: 4.0,),
                          Text('60 °28.0 ′N, 60 °28.0 ′E', style: bottomSheetItemLabel12(),),
                        ],
                      ),
                      SizedBox(height: 6.0),
                      Text(
                        place.min.toString() + ' nmi from you',
                        style: bottomSheetItemLabelGrey12(),
                      ),
                      SizedBox(height: 6.0),
                      Text(place.date + ' added', style: bottomSheetItemLabelGrey12(),),
                      SizedBox(height: 6.0),
                      GestureDetector(
                        onTap: () {

                        },
                        child: Text('Hide in map', style: underlineBtn14(),)
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 16.0,),
              CustomFullRaisedButton(
                bgColor: mainColorBlue,
                strColor: Colors.white,
                btnText: 'Route to',
                icon: Icons.watch_later_outlined,
                onPressed: () {

                },
              ),
              SizedBox(height: 16.0,),
              Row(
                children: [
                  CustomFullFlatBtn(
                    onPressed: onTapEdit,
                    borderColor: mainColorBlue,
                    btnTitle: 'Edit',
                  ),
                  SizedBox(width: 24.0,),
                  CustomFullFlatBtn(
                    onPressed: () async {
                      await showDialog<bool>(context: context,
                          builder: (context) {
                            return DialogNormal(
                              title: 'Are you sure that you want delete this saved place?',
                              content: 'The explanation that your data will be deleted. Lorem ipsum dolor.',
                              okStr: 'Delete',
                              noStr: 'Cancel',
                              okAction: () {
                                Navigator.of(context).pop(true);
                                print('ok tapped 123456789');
                              },
                              noAction: () {
                                Navigator.of(context).pop(false);
                                print('no tapped 123456789');
                              },
                            );
                          }
                        );
                    },
                    borderColor: mainColorBlue,
                    btnTitle: 'Delete',
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: 0.0,
          left: 16.0,
          child: Container(
            height: 34.0,
            width: 34.0,
            decoration: BoxDecoration(
              color: Color(0xFFFF4343),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Image.asset('assets/images/ic_heart.png',),
          ),
        ),
      ],
    );
  }
}
