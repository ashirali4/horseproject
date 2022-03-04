import 'package:flutter/material.dart';
import 'package:horseproject/src/utlis/constants.dart';

import '../../widgets/background_widget.dart';
import '../../widgets/button_round.dart';
import '../../widgets/or_login_with.dart';
import '../../widgets/textfield.dart';
class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return BackgroundImageWidget(
      elements: Elements(),
    );
  }

  Widget Elements(){
    return Container(
      child: Container(
        margin: EdgeInsets.only(left: 35,right: 35,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            Image.asset('assets/introLogo.png'),
            SizedBox(height: 60,),
            TextFieldApp(hintText: 'Email',hintTitle: 'johndoe@mail.com'),
            SizedBox(height: 15,),
            TextFieldApp(hintText: 'Password',hintTitle: '*********'),
            SizedBox(height: 40,),
            Container(
                width: 270,
                child: ButtonRound(buttonText: 'Sign In',)),
            SizedBox(height: 30,),
            OrLoginWith(),
            SizedBox(height: 110,),
            Container(
                width: 280,
                height: 50,
                child: ButtonRoundGoogle(buttonText: 'Continue with Google',buttonColor: Colors.white,textColor: LIGHT_BUTTON_COLOR,)),
          ],
        ),
      ),
    );
  }
}
