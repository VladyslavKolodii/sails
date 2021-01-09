import 'package:flutter/material.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';

class CardInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      child: Container(
        width: double.infinity,
        height: 76,
        padding: EdgeInsets.only(right: 24.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          border: Border.all(color: mainColorLightBlue, width: 1.0),
        ),
        child: Row(
          children: [
            Container(
              height: double.infinity,
              width: 76.0,
              color: mainColorLightBlue,
              child: Icon(Icons.credit_card, size: 16, color: mainColorBlue,),
            ),
            SizedBox(width: 24.0,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('VISA', style: bottomSheetItemLabelLigtGrey12(),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('9827-XXXX', style: bottomSheetItemLabel(),),
                      Text('12/20', style: bottomSheetItemLabel(),),
                      Text('399', style: bottomSheetItemLabel(),),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
