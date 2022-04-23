import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:horseproject/src/pages/auth/recovery_password.dart';
import 'package:horseproject/src/pages/dashboard/dashboard.dart';
import 'package:horseproject/src/utlis/constants.dart';

import '../../net/firebase_operations.dart';
import '../../widgets/background_widget.dart';
import '../../widgets/button_round.dart';
import '../../widgets/or_login_with.dart';
import '../../widgets/privacy.dart';
import '../../widgets/textfield.dart';
class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void showCustomDialog(EmailFlowController controller) {
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
                // PrivacyPolicy(),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 25,bottom: 10),
                  child: Row(
                    children: [
                      Expanded(child:  ButtonRound(buttonText: 'Cookies ablehnen', function:  (){ Navigator.pop(context);},),),
                      SizedBox(width: 15,),
                      Expanded(child:  ButtonRound(buttonText: 'Cookies zustimmen',buttonColor: Colors.blue,textColor: Colors.white, function:  (){
                        Navigator.pop(context);
                        controller.setEmailAndPassword(
                          emailCtrl.text,
                          passwordCtrl.text,
                        );
                      },),)
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 30,right: 30,bottom: 20),
                //   child: Row(
                //     children: [
                //
                //       Expanded(child:  ButtonRound(buttonText: 'Datenschutz zustimme',buttonColor: Colors.green,textColor: Colors.white, function:  (){
                //         Navigator.pop(context);
                //       },),)
                //     ],
                //   ),
                // )
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
  Widget build(BuildContext context) {
    return AuthFlowBuilder<EmailFlowController>(
      action: AuthAction.signIn,
      listener: (oldState, state, controller) {
        if (state is SignedIn) {
          EasyLoading.dismiss();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Dashboard()));
        }
        if (state is SigningIn){
          EasyLoading.show(status: 'Warten Sie mal...');
        }
        if (state is AuthFailed){
          final e = state.exception as FirebaseAuthException;
          String? newText = 'Ungültige E-Mail oder Passwort.';
          if(e.code=='user-not-found'){
            newText='Benutzer wurde nicht gefunden. Bitte registrieren Sie sich.';
          }else if(e.code=='wrong-password'){
            newText='Ungültige E-Mail oder Passwort.';
          }else if(e.code=='invalid-email'){
            newText='Ihre E-Mail-Adresse ist ungültig';
          }
          EasyLoading.showToast(newText.toString(),toastPosition: EasyLoadingToastPosition.bottom);
        }
      },
      builder: (context, state, controller, _) {
        return BackgroundImageWidget(
          elements: Elements(controller),
        );
      },
    );

  }

  Widget Elements(EmailFlowController controller){
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('    Anmelden',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
        elevation: 0,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 35,right: 35,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Image.asset('assets/introLogo.png'),
              SizedBox(height: 60,),
              TextFieldApp(hintText: 'Email',hintTitle: 'johndoe@mail.com',controller: emailCtrl,type: TextInputType.text,),
              SizedBox(height: 15,),
              TextFieldApp(hintText: 'Passwort',hintTitle: '*********',controller: passwordCtrl,obsecure: true,type: TextInputType.text),
              SizedBox(height: 10,),
              InkWell(
                  onTap: (){
                    Get.to(RecoverPassword());
                  },
                  child: const Text('Passwort vergessen?',style: TextStyle(fontWeight: FontWeight.bold,color: LIGHT_BUTTON_COLOR,fontSize: 15),)),

              SizedBox(height: 40,),
              Container(
                  width: 270,
                  child: ButtonRound(buttonText: 'Anmelden', function:  (){
                    FocusScope.of(context).unfocus();
                    if(emailCtrl.text!=null && emailCtrl.text!='' && passwordCtrl.text!=null && passwordCtrl.text!=''){
                      showCustomDialog(controller);
                    }else{
                      EasyLoading.showToast('Bitte E-Mail & Passwort eingeben',toastPosition: EasyLoadingToastPosition.bottom);
                    }

                  },)),
              SizedBox(height: 20,),
            //  OrLoginWith(),

              Container(
                  width: 270,
                  height: 50,
                  child: ButtonRoundGoogle(buttonText: 'Continue with Google',buttonColor: Colors.white,textColor: LIGHT_BUTTON_COLOR,ontap: (){
                    signInWithGoogle();
                  },)),
              SizedBox(height: 20,),
              PrivacyPolicy(),

            ],
          ),
        ),
      ),
    );
  }


  signInWithGoogle() async {
    print('loginngin');
   try{
     GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
     GoogleSignInAuthentication googleSignInAuthentication =
     await googleSignInAccount!.authentication;
     AuthCredential credential = GoogleAuthProvider.credential(
       accessToken: googleSignInAuthentication.accessToken,
       idToken: googleSignInAuthentication.idToken,
     );
     EasyLoading.show(status: 'Warten Sie mal...');
     await _auth.signInWithCredential(credential);
     await FirebaseDB.addSignWithGoogle(
       firstname: FirebaseAuth.instance.currentUser!.displayName.toString(),
       email: FirebaseAuth.instance.currentUser!.email.toString(),
       id: FirebaseAuth.instance.currentUser!.email.toString(),
     );
     EasyLoading.dismiss();
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Dashboard()));
   } catch(e){
     EasyLoading.showToast(e.toString(),toastPosition: EasyLoadingToastPosition.bottom);
   }
  }

}
