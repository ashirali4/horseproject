import 'package:flutter/material.dart';

import '../../widgets/button_round.dart';
class IntroMobileApp extends StatefulWidget {
  const IntroMobileApp({Key? key}) : super(key: key);

  @override
  _IntroMobileAppState createState() => _IntroMobileAppState();
}

class _IntroMobileAppState extends State<IntroMobileApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 35,right: 35,),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/introLogo.png'),
          SizedBox(height: 50,),
          IntroButtons(),
        ],
      ),
    );
  }


  Widget IntroButtons(){
    return Row(
      children: [
        Expanded(child:  ButtonRound(buttonText: 'Sign In',),),
        SizedBox(width: 15,),
        Expanded(child:  ButtonRound(buttonText: 'Register',),)
      ],
    );
  }
}
