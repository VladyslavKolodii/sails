import 'package:easy_localization/easy_localization.dart';
import 'package:hybrid_sailmate/app.dart';
import 'package:hybrid_sailmate/auth/bloc/auth_bloc.dart';
import 'package:hybrid_sailmate/map/bloc/map_bloc.dart';
import 'package:flutter/material.dart';
import 'package:config_repository/config_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:point_of_interest_repository/point_of_interest_repository.dart';
import 'package:dio/dio.dart';

void main() {
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
        child: Sailmate()
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
      home: App(configRepository: ConfigRepository())
    );
  }
}
