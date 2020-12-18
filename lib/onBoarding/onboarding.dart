import 'package:config_repository/config_repository.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hybrid_sailmate/app.dart';
import 'package:hybrid_sailmate/auth/auth.dart';
import 'package:hybrid_sailmate/model/model_onborading.dart';
import 'package:hybrid_sailmate/widgets/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<OnBoardingModel> onBoradingArr = [
    OnBoardingModel('Onborading.Onborading1.title'.tr(), 'Onborading.Onborading1.detail'.tr(), 'assets/images/onboarding1.png'),
    OnBoardingModel('Onborading.Onborading2.title'.tr(), 'Onborading.Onborading2.detail'.tr(), "assets/images/onboarding2.png"),
    OnBoardingModel('Onborading.Onborading3.title'.tr(), 'Onborading.Onborading3.detail'.tr(), "assets/images/onboarding3.png")
  ];

  int _current = 0;

  Widget _createOnboardingScreen(OnBoardingModel model, BuildContext context) {
    return Column(
      children: [
        Image(
          image: AssetImage(model.iamgeUrl),
          height: MediaQuery.of(context).size.height / 2.0 - 36.0,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 80,),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(model.title, style: TextStyles.onBoradingtitle(),)
            ),
            SizedBox(height: 16.0,),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(model.desc, style: TextStyles.bottomSheetItemLabelGrey12(),)
            ),
          ],
        ),
      ],
    );
  }

  _passedOnboarding(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("OnBoarding", true);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => App(configRepository: ConfigRepository())));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return Scaffold(
          body: Stack(
            children: [
              PageView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: onBoradingArr.length,
                onPageChanged: (int pageIndex) {
                  print("current page index + ${_current}");
                  setState(() {
                    _current = pageIndex;
                  });
                },
                itemBuilder: (context, index) {
                  return _createOnboardingScreen(onBoradingArr[index], context);
                },
              ),
              Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: onBoradingArr.map((url) {
                      int index = onBoradingArr.indexOf(url);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current == index ? mainBlue : mainBlue.withOpacity(0.2)
                        ),
                      );
                    }).toList()
                ),
              ),
              Positioned(
                bottom: 40.0,
                left: 40.0,
                right: 40.0,
                child: Container(
                  child: SizedBox(
                    height: 46.0,
                    child: RaisedButton(
                      onPressed: () => {
                        _passedOnboarding(context)
                      },
                      color: mainBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Text("Get started", style: TextStyles.buttonWhite(),),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

