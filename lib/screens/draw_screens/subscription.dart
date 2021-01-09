import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hybrid_sailmate/model/model_subscription.dart';
import 'package:hybrid_sailmate/utils/common_util.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';
import 'package:hybrid_sailmate/widgets/add_card_widget.dart';
import 'package:hybrid_sailmate/widgets/alert/dialog_normal.dart';
import 'package:hybrid_sailmate/widgets/card_widget.dart';
import 'package:hybrid_sailmate/widgets/custom_appbar.dart';
import 'package:hybrid_sailmate/widgets/custom_buttons.dart';
import 'package:hybrid_sailmate/widgets/select_payment_widget.dart';
import 'package:hybrid_sailmate/widgets/subscription_feature_widget.dart';

class SubScription extends StatefulWidget {
  final String title;
  const SubScription({Key key, this.title}) : super(key: key);
  @override
  _SubScriptionState createState() => _SubScriptionState();
}

class _SubScriptionState extends State<SubScription> {
  final _scalffoldkey = GlobalKey<ScaffoldState>();
  List<bool> isExpanded = <bool>[];

  @override
  void initState() {
    for (var model in testSubscriptions) {
      isExpanded.add(false);
    }
    super.initState();
  }

  Widget _buildSubscriptionItem(ModelSubscription model, int index, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: Colors.white,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          child: Container(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: Column(
                    children: [
                      Text(model.mode == SubscriptionMode.savedtrack ? 'Track and Save Features' : 'Scout Features', style: bottomSheetItemLabel(),),
                      SizedBox(height: 16.0,),
                      _buildSubscriptionInfo(model.mode),
                      SizedBox(height: 16.0,),
                      _buildPaymentInfo(model.status, index),
                      Visibility(
                        visible: isExpanded[index],
                        child: Column(
                          children: [
                            SizedBox(height: 24.0,),
                            Container(
                              width: double.infinity,
                              height: 1.0,
                              color: mainColorLightBlue,
                            ),
                            _buildMoreInfo(model, context),
                          ],
                        )
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 0.0,
                  right: 0.0,
                  child: _buildStatusWidget(model.status),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildStatusWidget(SubscriptionStatus status) {
    var width = 0.0;
    var bgColor = Colors.white;
    Widget child;
    if (status == SubscriptionStatus.locked) {
      width = 32.0;
      bgColor = mainColorPremium.withOpacity(0.16);
      child = Icon(Icons.lock_outlined, size: 16.0, color: mainColorPremium,);
    } else if (status == SubscriptionStatus.upgrade) {
      width = 82;
      bgColor = mainColorSCOUT.withOpacity(0.16);
      child = Text('upgrade', style: bottomSheetItemLabel12().copyWith(color: mainColorSCOUT),);
    } else {
      width = 82;
      bgColor = mainColorPOI.withOpacity(0.16);
      child = Text('cancel', style: bottomSheetItemLabel12().copyWith(color: mainColorPOI),);
    }
    return Container(
      height: 32.0,
      width: width,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16.0))
      ),
      child: Center(
        child: child,
      ),
    );
  }

  Widget _buildSubscriptionInfo(SubscriptionMode mode) {
    Widget child;
    if (mode == SubscriptionMode.scout) {
      child = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SubScriptionFeature(title: 'Special harbour maps', icon: SvgPicture.asset('assets/images/ic_sub_port.svg'),),
          SubScriptionFeature(title: 'Scout routes', icon: SvgPicture.asset('assets/images/ic_sub_scout.svg'),),
        ],
      );
    } else {
      child = Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SubScriptionFeature(title: 'Save custom places', icon: SvgPicture.asset('assets/images/ic_sub_save.svg'),),
              SubScriptionFeature(title: 'Offline map', icon: SvgPicture.asset('assets/images/ic_sub_location.svg'),),
            ],
          ),
          SizedBox(height: 4.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SubScriptionFeature(title: 'Route tracking', icon: SvgPicture.asset('assets/images/ic_sub_stopwatch.svg'),),
              SubScriptionFeature(title: 'Location marker', icon: SvgPicture.asset('assets/images/ic_sub_offline.svg'),),
            ],
          )
        ],
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28.0),
      child: Column(
        children: [
          child
        ],
      ),
    );
  }

  Widget _buildPaymentInfo(SubscriptionStatus status, int index) {
    var strContent = '';
    if (status == SubscriptionStatus.locked) {
      strContent = '€19.99 / year';
    } else if (status == SubscriptionStatus.upgrade) {
      strContent = 'next payment July 20, 2021';
    } else {
      strContent = 'could use to July 20, 2021';
    }
    return Container(
      padding: EdgeInsets.only(right: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: mainColorPOI.withOpacity(0.1),
              borderRadius: BorderRadius.only(topRight: Radius.circular(13.0), bottomRight: Radius.circular(13.0))
            ),
            child: Text(strContent, style: bottomSheetItemLabel().copyWith(color: mainColorPOI),),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded[index] = !isExpanded[index];
              });
            },
            child: Text(isExpanded[index] ? 'close' : 'learn more', style: underlineBtn14(),)
          )
        ],
      ),
    );
  }

  Widget _buildMoreInfo(ModelSubscription model, BuildContext context) {
    if (model.status == SubscriptionStatus.cancel) {
      return _buildCancelInfo(model);
    } else if (model.status == SubscriptionStatus.upgrade) {
      return _buildUpgradeInfo(model);
    } else {
      return _buildLockInfo(model, context);
    }
  }

  Widget _buildCancelInfo(ModelSubscription model) {
    return Column(
      children: [
        SizedBox(height: 16.0,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Text('After July 20, 2021 you could not use features becouse you canceled it. Or you could continue subscription', style: bottomSheetItemLabel12(),),
        ),
        SizedBox(height: 16.0,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: [
              CustomFullFlatBtn(
                bgColor: mainColorBlue,
                strColor: Colors.white,
                btnTitle: 'Continue subscription',
                onPressed: () {

                },
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0,),
        Container(
          padding: EdgeInsets.only(left: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('More info', style: bottomSheetItemLabel(),),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
                decoration: BoxDecoration(
                    color: mainColorPOI.withOpacity(0.1),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(13.0), bottomLeft: Radius.circular(13.0))
                ),
                child: Text('€19.99 / year', style: bottomSheetItemLabel().copyWith(color: mainColorPOI),),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.0,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Text('Somenote Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Some description Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
            style: bottomSheetItemLabelLigtGrey12(),
          ),
        )
      ],
    );
  }

  Widget _buildUpgradeInfo(ModelSubscription model) {
    return Column(
      children: [
        SizedBox(height: 16.0,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Credit Card info', style: bottomSheetItemLabel(),),
                  GestureDetector(
                    onTap: () {

                    },
                    child: Text('Change card', style: underlineBtn14(),)
                  )
                ],
              ),
              SizedBox(height: 8.0,),
              CardInfo(),
              SizedBox(height: 16.0,),
              Container(
                width: double.infinity,
                child: Row(
                  children: [
                    CustomFullFlatBtn(
                      borderColor: mainColorBlue,
                      strColor: mainColorBlue,
                      btnTitle: 'Cancel Subscription',
                      onPressed: () async {
                        await showDialog<bool>(context: context,
                          builder: (context) {
                            return DialogNormal(
                              title: 'Are you sure that you want to cancel subscription to Scout Features?',
                              content: 'The explanation that your data will be deleted. Lorem ipsum dolor.',
                              okStr: 'Ok',
                              noStr: 'No, leave it',
                              okAction: () {
                                Navigator.of(context).pop(true);
                              },
                              noAction: () {
                                Navigator.of(context).pop(false);
                              },
                            );
                          }
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0,),
              Text('More info', style: bottomSheetItemLabel(),),
              SizedBox(height: 4.0,),
              Text('Somenote Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Some description Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
                style: bottomSheetItemLabelLigtGrey12(),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildLockInfo(ModelSubscription model, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          SizedBox(height: 16.0,),
          Text('Somenote Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Some description Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
            style: bottomSheetItemLabelLigtGrey12(),
          ),
          SizedBox(height: 16.0,),
          Row(
            children: [
              CustomFullFlatBtn(
                bgColor: mainColorBlue,
                strColor: Colors.white,
                btnTitle: 'Upgrade feature',
                onPressed: () {
                  Common.prensentBottomSheet(context,
                    528.0,
                    AddCard(onPressed: () {
                      Navigator.of(context).pop();
                      _showSelectPaymentBottomSheet(context);
                    },),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSelectPaymentBottomSheet(BuildContext context) {
    Common.prensentBottomSheet(
      context,
      244,
      SelectPayment(onPressed: () {
        Navigator.of(context).pop();
      },)
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scalffoldkey,
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.only(top: height < 670 ? 25 : 58),
        decoration: MainGradientDecoration(),
        child: Column(
          children: [
            CustomAppBar(strTitle: tr(widget.title),),
            SizedBox(height: 16.0,),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                child: Container(
                  padding: EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                    color: mainColorInput,
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 0.0),
                    itemCount: testSubscriptions.length,
                    itemBuilder: (context, index) {
                      var model = testSubscriptions[index];
                      return _buildSubscriptionItem(model, index, context);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
