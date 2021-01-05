import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';

class TermsInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image(
                width: 124.0,
                height: 55.0,
                fit: BoxFit.fill,
                image: AssetImage('assets/images/terms_logo.png'),
              ),
              Positioned(
                left: 57.0,
                top: 18.0,
                child: Text(
                  'Sailmate',
                  style: termslogo(),
                ),
              )
            ],
          ),
          SizedBox(height: 16.0,),
          Text(
            'Aliqua id fugiat nostrud irure ex duis ea quis id quis ad et. Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim. Elit aute irure tempor cupidatat incididunt sint deserunt ut voluptate aute id deserunt nisi.',
            style: bottomSheetItemLabelGrey12(),
          ),
          SizedBox(height: 16.0),
          Text(
            'Sunt qui',
            style: bottomSheetItemLabel(),
          ),
          SizedBox(height: 16.0,),
          Text(
            'Aliqua id fugiat nostrud irure ex duis ea quis id quis ad et. Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim. Elit aute irure tempor cupidatat incididunt sint deserunt ut voluptate aute id deserunt nisi.',
            style: bottomSheetItemLabelGrey12(),
          ),
          SizedBox(height: 16.0),
          Text(
            'Sunt qui',
            style: bottomSheetItemLabel(),
          ),
          SizedBox(height: 16.0,),
          Text(
            'Aliqua id fugiat nostrud irure ex duis ea quis id quis ad et. Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim. Elit aute irure tempor cupidatat incididunt sint deserunt ut voluptate aute id deserunt nisi. \n Aliqua id fugiat nostrud irure ex duis ea quis id quis ad et. Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim. Elit aute irure tempor cupidatat incididunt sint deserunt ut voluptate aute id deserunt nisi. \n Aliqua id fugiat nostrud irure ex duis ea quis id quis ad et. Sunt qui esse pariatur duis deserunt mollit dolore cillum minim tempor enim. Elit aute irure tempor cupidatat incididunt sint deserunt ut voluptate aute id deserunt nisi.',
            style: bottomSheetItemLabelGrey12(),
          ),
        ],
      ),
    );
  }
}

