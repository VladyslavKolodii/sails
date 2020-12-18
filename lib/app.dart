import 'dart:ui';

import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:hybrid_sailmate/onBoarding/onboarding.dart';
import 'amplifyconfiguration.dart';

import 'package:hybrid_sailmate/auth/bloc/auth_bloc.dart';
import 'package:hybrid_sailmate/auth/view/login_page.dart';
import 'package:hybrid_sailmate/config/config.dart';
import 'package:hybrid_sailmate/map/map.dart';
import 'package:hybrid_sailmate/splash/splash.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:config_repository/config_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hybrid_sailmate/widgets/drawer/main_drawer.dart';

import 'auth/view/token_page.dart';

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

  // ignore: unused_field
  bool _amplifyConfigured = false;
  Amplify amplifyInstance = Amplify();

  var authFlowInitiated = false;

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    var authPlugin = AmplifyAuthCognito();
    await amplifyInstance.addPlugin(
      authPlugins: [authPlugin]
    );

    // Once Plugins are added, configure Amplify
    await amplifyInstance.configure(amplifyconfig);
    try {
      setState(() {
        _amplifyConfigured = true;
      });
    } catch (e) {
      print(e);
    }

  }

  void _initAuthFlow(context) {
    if (!authFlowInitiated) {
      BlocProvider.of<AuthBloc>(context).add(CheckIfAlreadyAuthenticated());
      authFlowInitiated = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    context.bloc<ConfigBloc>().init();
    _initAuthFlow(context);
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
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
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                // _navigator.pushAndRemoveUntil(
                //     PageRouteWithoutTransition(
                //       builder: (_) => BlocBuilder<ConfigBloc, MapConfig>(
                //         builder: (context, state) {
                //           // return MapPage(mapboxApiKey: state.mapboxApiKey, mapboxStyleString: state.mapboxStyleString, scaffoldKey: _scaffoldKey);
                //           return OnBoarding();
                //         },
                //       )
                //     ),
                //     (route) => false
                // );
                if (state is Authenticated) {
                  _navigator.pushAndRemoveUntil(
                    PageRouteWithoutTransition(
                      builder: (_) => BlocBuilder<ConfigBloc, MapConfig>(
                        builder: (context, state) {
                          if (state != null && state.mapboxApiKey != null && state.mapboxStyleString != null) {
                            return MapPage(
                              mapboxApiKey: state.mapboxApiKey,
                              mapboxStyleString: state.mapboxStyleString,
                              scaffoldKey: _scaffoldKey,
                            );
                          }
                          return Center(child: CircularProgressIndicator());
                        }
                      )
                    ),
                    (route) => false
                  );
                }

                if (state is Unauthenticated || state is AuthFailed) {
                  _navigator.pushAndRemoveUntil(
                    PageRouteWithoutTransition(
                      builder: (_) => LoginPage(),
                    ),
                    (route) => false,
                  );
                }

                if (state is AuthTokenSend) {
                  _navigator.pushAndRemoveUntil(
                    PageRouteWithoutTransition(
                      builder: (_) => TokenPage(),
                    ),
                    (route) => false,
                  );
                }

                if (state is AuthInProgress || state is AlreadyAuthenticatedCheckInProgress) {
                  _navigator.pushAndRemoveUntil(
                    PageRouteWithoutTransition(builder: (_) => Center(child: CircularProgressIndicator())),
                    (route) => false
                  );
                }
              },
              child: child
            ),
          )
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
