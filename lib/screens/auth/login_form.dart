import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hybrid_sailmate/utils/const_util.dart';
import 'package:hybrid_sailmate/widgets/custom_buttons.dart';

import '../../widgets/custom_textfields.dart';
import 'bloc/auth_bloc.dart';


class LoginForm extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var email = useState('');

    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          color: mainColorDisabled,
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
                  Text('logo'.tr(), style: logo()),
                ]
              ),
              SizedBox(height: 47),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [Text('login.signIn'.tr(), style: title())]),
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
              CustomFullRaisedButton(
                bgColor: mainColorBlue,
                strColor: Colors.white,
                btnText: 'login.getCodeButton'.tr(),
                height: 60.0,
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(RequestAuthToken(email: email.value));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
