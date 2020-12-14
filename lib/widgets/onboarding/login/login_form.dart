import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hybrid_sailmate/auth/bloc/auth_bloc.dart';
import 'package:hybrid_sailmate/widgets/common/input_scaffold.dart';
import 'package:hybrid_sailmate/widgets/text_styles.dart';

final background = Color(int.parse('0xffE9E9E9'));
final mainBlue = Color(int.parse('0xff4B7CC6'));

class LoginForm extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var email = useState('');

    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          color: background,
          image: DecorationImage(
            image: AssetImage('assets/images/login_background.png'),
            alignment: Alignment.topLeft
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 40, right: 40, bottom: 40, top: 58),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(image: AssetImage('assets/images/sailmate_rounded.png')),
                  SizedBox(width: 20),
                  Text('logo'.tr(), style: TextStyles.logo()),
                ]
              ),
              SizedBox(height: 47),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [Text('login.signIn'.tr(), style: TextStyles.title())]),
              SizedBox(height: 42),
              InputScaffold(
                child: TextFormField(
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'login.emailInput'.tr()
                  ),
                  onChanged: (inputValue) {
                    email.value = inputValue;
                  },
                )
              ),
              SizedBox(height: 16),
              Row(children: [
                Expanded(child: InputScaffold(
                  color: mainBlue, child: FlatButton(
                    child: Text('login.getCodeButton'.tr(), style: TextStyles.buttonWhite()),
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(RequestAuthToken(email: email.value));
                    },
                  )
                ))
              ])
            ],
          ),
        ),
      ),
    );
  }
}
