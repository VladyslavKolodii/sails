import 'dart:ui';

import 'package:HybridSailmate/config/config.dart';
import 'package:HybridSailmate/map/map.dart';
import 'package:HybridSailmate/splash/splash.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:config_repository/config_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageRouteWithoutTransition extends MaterialPageRoute {
  PageRouteWithoutTransition({builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}

class App extends StatelessWidget {
  const App({
    Key key,
    @required this.configRepository
  }) : super(key: key);

  final ConfigRepository configRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: configRepository,
      child: BlocProvider(
        create: (_) => ConfigBloc(configRepository: configRepository),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        context.bloc<ConfigBloc>().init();
        return Scaffold(
          body: ColorfulSafeArea(
            overflowRules: OverflowRules.symmetric(vertical: true),
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            color: Colors.white.withOpacity(0.4),
            child: BlocListener<ConfigBloc, MapConfig>(
              listener: (context, state) {
                if (state.mapboxApiKey != null && state.mapboxStyleString != null) {
                  _navigator.pushAndRemoveUntil<void>(
                      PageRouteWithoutTransition(
                        builder: (_) => MapPage(
                          mapboxApiKey: state.mapboxApiKey,
                          mapboxStyleString: state.mapboxStyleString
                        )
                      ),
                      (route) => false,
                    );
                }
              },
              child: child,
            )
          )
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
