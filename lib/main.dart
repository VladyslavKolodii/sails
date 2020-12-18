import 'package:easy_localization/easy_localization.dart';
import 'package:hybrid_sailmate/app.dart';
import 'package:hybrid_sailmate/auth/bloc/auth_bloc.dart';
import 'package:hybrid_sailmate/map/bloc/map_bloc.dart';
import 'package:flutter/material.dart';
import 'package:config_repository/config_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hybrid_sailmate/onBoarding/onboarding.dart';
import 'package:point_of_interest_repository/point_of_interest_repository.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var isPassedOnBoarding = preferences.getBool("OnBoarding");
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('fi'), Locale('sv')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<MapBloc>(create: (context) => MapBloc(pointOfInterestRepository: RestClient(Dio()))),
          BlocProvider<AuthBloc>(create: (context) => AuthBloc(authRepository: AuthRepository()))
        ],
        child: isPassedOnBoarding != null ? Sailmate() : GoOnBoarding()
      )
    )
  );
}

class Sailmate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home:App(configRepository: ConfigRepository())
    );
  }
}

class GoOnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home:OnBoarding()
    );
  }
}
