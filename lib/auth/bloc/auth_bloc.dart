import 'dart:math';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CheckIfAlreadyAuthenticated extends AuthEvent {}

class RequestAuthToken extends AuthEvent {
  const RequestAuthToken({ @required this.email });

  final String email;

  @override
  List<Object> get props => [email];
}

class RequestSignUp extends AuthEvent {
  const RequestSignUp({ @required this.email });

  final String email;

  @override
  List<Object> get props => [email];
}

class AuthenticateWithToken extends AuthEvent {
  const AuthenticateWithToken({ @required this.token });

  final String token;

  @override
  List<Object> get props => [token];
}

class RequestLogout extends AuthEvent {}

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthUnknown extends AuthState {}
class AlreadyAuthenticatedCheckInProgress extends AuthState {}

class AuthInProgress extends AuthState {}
class AuthFailed extends AuthState {}

class AuthTokenSend extends AuthState {}

class Unauthenticated extends AuthState {}

class Authenticated extends AuthState {}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({ @required this.authRepository }) : super(AuthUnknown());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is CheckIfAlreadyAuthenticated) {
      yield AlreadyAuthenticatedCheckInProgress();
      try {
        var session = await Amplify.Auth.fetchAuthSession();
        if (session.isSignedIn) {
          var user = await Amplify.Auth.fetchAuthSession(
            options: CognitoSessionOptions(getAWSCredentials: true),
          ) as CognitoAuthSession;
          print('foobar: ${user.userPoolTokens.idToken}');
          yield Authenticated();
        } else {
          await Amplify.Auth.signOut();
          yield Unauthenticated();
        }
      } on AuthError catch (_) {
        await Amplify.Auth.signOut();
        yield Unauthenticated();
      }
    }

    if (event is RequestAuthToken) {
      yield* _mapAuthTokenRequestedToState(event);
    }

    if (event is RequestSignUp) {
      yield* _mapSignupRequestedToState(event);
    }

    if (event is AuthenticateWithToken) {
      yield* _mapAutheticateWithTokenToState(event);
    }

    if (event is RequestLogout) {
      yield AuthInProgress();
      await Amplify.Auth.signOut();
      yield Unauthenticated();
    }
  }

  Stream<AuthState> _mapAuthTokenRequestedToState(
    RequestAuthToken event,
  ) async* {
    yield AuthInProgress();
    try {
      var username = event.email.toLowerCase();
      await Amplify.Auth.signIn(username: username, password: '');
      yield AuthTokenSend();
    } on AuthError catch (error) {
      if (error.exceptionList.first.exception == 'USER_NOT_FOUND' || error.exceptionList.first.exception == 'PLATFORM_EXCEPTIONS') {
        add(RequestSignUp(email: event.email));
      }
      yield AuthFailed();
    }
  }

Stream<AuthState> _mapSignupRequestedToState(
    RequestSignUp event,
  ) async* {
    yield AuthInProgress();
    try {
      await Amplify.Auth.signUp(
        username: event.email.toLowerCase(),
        password: SecureRandom().nextString(length: 40),
        options: CognitoSignUpOptions(userAttributes: <String, dynamic>{})
      );
      add(RequestAuthToken(email: event.email));
    } on AuthError catch (_) {
      yield AuthFailed();
    }
  }

Stream<AuthState> _mapAutheticateWithTokenToState(
    AuthenticateWithToken event,
  ) async* {
    yield AuthInProgress();
    try {
      var result = await Amplify.Auth.confirmSignIn(confirmationValue: event.token);
      if (result.isSignedIn) {
        yield Authenticated();
      } else {
        yield AuthFailed();
      }
    } on AuthError catch (_) {
      yield AuthFailed();
    }
  }
}

class AuthRepository {

}

class SecureRandom {
  Random _random;
  static const String _defaultCharset =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789=+-^\$*.[]{}()?!@#%&/\\,><\':;|_~`';

  /// Constructor
  SecureRandom() {
    _random = Random.secure();
  }

  /// Generate a strong random string.
  ///
  /// @param length   The length of target random string.
  /// @param charset  Characters used in random string.
  ///                 The default `charset` is 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
  ///
  /// @returns Random string with a fixed length.
  ///
  String nextString({int length, String charset = _defaultCharset}) {
    var ret = '';

    for (var i = 0; i < length; ++i) {
      var random = _random.nextInt(charset.length);
      ret += charset[random];
    }

    return ret;
  }

  /// Generate a strong random integer.
  int nextInt({int max}) {
    return _random.nextInt(max);
  }
}
