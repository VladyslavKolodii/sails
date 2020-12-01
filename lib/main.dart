import 'package:hybrid_sailmate/app.dart';
import 'package:hybrid_sailmate/map/bloc/map_bloc.dart';
import 'package:flutter/material.dart';
import 'package:config_repository/config_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:point_of_interest_repository/point_of_interest_repository.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<MapBloc>(create: (context) => MapBloc(pointOfInterestRepository: RestClient(Dio())))
    ],
    child: App(configRepository: ConfigRepository())));
}
