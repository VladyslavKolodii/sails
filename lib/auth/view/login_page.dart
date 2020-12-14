import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hybrid_sailmate/widgets/onboarding/login/login_form.dart';

class LoginPage extends HookWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: LoginForm());
  }
}
