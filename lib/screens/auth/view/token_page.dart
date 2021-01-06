import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hybrid_sailmate/screens/auth/token_form.dart';

class TokenPage extends HookWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => TokenPage());
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: TokenForm());
  }
}
