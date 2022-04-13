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

  void showCustomDialog() {
    FirebaseAuth.instance.sendPasswordResetEmail(email: 'ashirali4444@gmail.com');
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            height: 280,
            child: SizedBox.expand(child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                Text('Wir respektieren deine Privatsphäre',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Text('Um diese App zu betreiben verwenden wir Cookies. Ihre Privatsphäre ist uns wichtig und wir versichern Ihnen, dass wir Ihre Daten nur für notwendige Zwecke verwenden und nicht verkaufen.',style: TextStyle(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,),
                ),
                SizedBox(height: 05,),
                PrivacyPolicy(),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 25,bottom: 10),
                  child: Row(
                    children: [
                      Expanded(child:  ButtonRound(buttonText: 'Cookies ablehnen', function:  (){ Navigator.pop(context);},),),
                      SizedBox(width: 15,),
                      Expanded(child:  ButtonRound(buttonText: 'Cookies zustimmen',buttonColor: Colors.blue,textColor: Colors.white, function:  (){
                        Navigator.pop(context);
                      },),)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30,bottom: 20),
                  child: Row(
                    children: [

                      Expanded(child:  ButtonRound(buttonText: 'Datenschutz zustimme',buttonColor: Colors.green,textColor: Colors.white, function:  (){
                        Navigator.pop(context);
                      },),)
                    ],
                  ),
                )
              ],
            )),
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
            decoration: BoxDecoration(color: Colors.white,),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }

        return FadeTransition(
          opacity: anim,
          child: child,
        );
      },
    );
  }



  @override
  void initState() {
    Timer.run(showCustomDialog);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImageWidget(
      elements: Elements(),
    );
  }

  Widget IntroButtons(){
    return Row(
      children: [
        Expanded(child:  ButtonRound(buttonText: 'Anmelden', function:  (){ Get.to(SignIn());},),),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/introLogo.png'),
            SizedBox(height: 80,),
            IntroButtons(),
            SizedBox(height: 40,),
        //    OrLoginWith(),
            SizedBox(height: 130,),
            PrivacyPolicy(),
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
