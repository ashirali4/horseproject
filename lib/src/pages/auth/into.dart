// import 'dart:async';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:horseproject/src/pages/auth/signup.dart';
// import 'package:horseproject/src/utlis/constants.dart';
//
// import '../../widgets/background_widget.dart';
// import '../../widgets/button_round.dart';
// import '../../widgets/or_login_with.dart';
// import '../../widgets/privacy.dart';
// import 'login.dart';
// class IntroMobileApp extends StatefulWidget {
//   const IntroMobileApp({Key? key}) : super(key: key);
//
//   @override
//   _IntroMobileAppState createState() => _IntroMobileAppState();
// }
//
// class _IntroMobileAppState extends State<IntroMobileApp> {
//
//
//
//
//   @override
//   void initState() {
//  //   Timer.run(showCustomDialog);
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BackgroundImageWidget(
//       elements: Elements(),
//     );
//   }
//
//   Widget IntroButtons(){
//     return Row(
//       children: [
//         Expanded(child:  ButtonRound(buttonText: 'Anmelden', function:  (){ Get.to(SignIn());},),),
//         SizedBox(width: 15,),
//         Expanded(child:  ButtonRound(buttonText: 'Registrieren',buttonColor: INTROBUTTONCOLOR,textColor: LIGHT_BUTTON_COLOR, function:  (){
//           Get.to(SignUp());
//         },),)
//       ],
//     );
//   }
//
//
//   Widget Elements(){
//     return Container(
//       child: Container(
//         margin: EdgeInsets.only(left: 35,right: 35,),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset('assets/introLogo.png'),
//             SizedBox(height: 80,),
//             IntroButtons(),
//             SizedBox(height: 40,),
//         //    OrLoginWith(),
//             SizedBox(height: 130,),
//             PrivacyPolicy(),
//             // Container(
//             //     width: 280,
//             //     height: 50,
//             //     child: ButtonRoundGoogle(buttonText: 'Continue with Google',buttonColor: Colors.white,textColor: LIGHT_BUTTON_COLOR,)),
//             //
//           ],
//         ),
//       ),
//     );
//   }
//
// }





import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horseproject/src/pages/auth/signup.dart';
import 'package:horseproject/src/utlis/constants.dart';

import '../../widgets/background_widget.dart';
import '../../widgets/button_round.dart';
import '../../widgets/or_login_with.dart';
import '../../widgets/privacy.dart';
import 'login.dart';
class IntroMobileApp extends StatefulWidget {
  const IntroMobileApp({Key? key}) : super(key: key);

  @override
  _IntroMobileAppState createState() => _IntroMobileAppState();
}

class _IntroMobileAppState extends State<IntroMobileApp> {




  @override
  void initState() {
    //   Timer.run(showCustomDialog);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              BACKGROUND_COLOR_DASHBOARD,
              Colors.black,
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(3.5, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.decal),
      ),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 100),
            child: Image.asset('assets/horsepic.png'),
          ),
          Elements(),
        ],
      )
    );
  }

  Widget IntroButtons(){
    return Row(
      children: [
        Expanded(child:  ButtonRound(buttonText: 'Anmelden', function:  (){ Get.to(SignIn());},buttonColor: INTROBUTTONCOLOR,textColor: LIGHT_BUTTON_COLOR,),),
        SizedBox(width: 15,),
        Expanded(child:  ButtonRound(buttonText: 'Registrieren',buttonColor: INTROBUTTONCOLOR,textColor: LIGHT_BUTTON_COLOR, function:  (){
          Get.to(SignUp());
        },),)
      ],
    );
  }


  Widget Elements(){
    return Container(
      child: Container(
        margin: EdgeInsets.only(left: 35,right: 35,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 150,
                width: 150,
                child: Image.asset('assets/myapplogo.png')),
            SizedBox(height: 15,),
            Text('Wir wiegen Dein Pferd',style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 25
            ),),
            SizedBox(height: 10,),
            Text('Copyright © 2008-2022',style: TextStyle(
                color: Colors.white.withOpacity(.5)
            ),),
            Text('Version 1.0',style: TextStyle(
                color: Colors.white.withOpacity(.5)
            ),),
            SizedBox(height: 50,),
            IntroButtons(),
            SizedBox(height: 40,),
            //    OrLoginWith(),
            PrivacyPolicy(),
            SizedBox(height: 30,),

            // Container(
            //     width: 280,
            //     height: 50,
            //     child: ButtonRoundGoogle(buttonText: 'Continue with Google',buttonColor: Colors.white,textColor: LIGHT_BUTTON_COLOR,)),
            //
          ],
        ),
      ),
    );
  }

}

