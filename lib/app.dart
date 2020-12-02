import 'dart:ui';

import 'package:fontisto_flutter/fontisto_flutter.dart';
import 'package:hybrid_sailmate/config/config.dart';
import 'package:hybrid_sailmate/map/map.dart';
import 'package:hybrid_sailmate/splash/splash.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:config_repository/config_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hybrid_sailmate/widgets/drawer/main_drawer.dart';
import 'package:hybrid_sailmate/widgets/main_button_decoration.dart';

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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        context.bloc<ConfigBloc>().init();
        return Scaffold(
          key: _scaffoldKey,
          drawer: Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 40),
            child: ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
              child: SizedBox(
                width: 320,
                child: MainDrawer(),
              ),
            )
          ),
          body: ColorfulSafeArea(
            overflowRules: OverflowRules.symmetric(vertical: true),
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            color: Colors.white.withOpacity(0.4),
            child: Stack(
              children: [
                BlocListener<ConfigBloc, MapConfig>(
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
                ),
                Positioned(
                  left: 24,
                  top: 58,
                  child: SizedBox(
                    height: 46,
                    width: 46,
                    child: DecoratedBox(
                      decoration: MainButtonDecoration(),
                      child: FlatButton(
                        onPressed: () {
                          _scaffoldKey.currentState.openDrawer();
                        },
                        child: Icon(Istos.nav_icon, color: Colors.grey, size: 12),
                      ),
                    ),
                  )
                ),
              ]
            )
          )
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
