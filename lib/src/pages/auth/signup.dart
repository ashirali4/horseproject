import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:horseproject/src/utlis/constants.dart';

import '../../net/firebase_operations.dart';
import '../../widgets/background_widget.dart';
import '../../widgets/button_round.dart';
import '../../widgets/or_login_with.dart';
import '../../widgets/textfield.dart';
import '../dashboard/dashboard.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController phone = TextEditingController(text: '');
  TextEditingController country = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();


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
      action: AuthAction.signUp,
      listener: (oldState, state, controller) {
        if (state is SignedIn) {
          FirebaseDB.addUsersSignup(firstname: firstname.text, lastname: lastname.text, country: country.text,
              phone: phone.text, email: emailCtrl.text);
          EasyLoading.dismiss();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Dashboard()));
        }
        if (state is SigningIn){
          EasyLoading.show(status: 'Warten Sie mal...');
        }
        if (state is AuthFailed){
          final e = state.exception as FirebaseAuthException;
          String? newText = 'Ihre E-Mail-Adresse ist ungültig.';
          if(e.code=='invalid-email'){
            newText='Ihre E-Mail-Adresse ist ungültig';
          }else if(e.code=='weak-password'){
            newText='Das Passwort sollte 6 Zeichen lang sein';
          }else if(e.code=='email-already-in-use'){
            newText='Diese E-Mail wurde bereits registriert';
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
        title: Text('    Registrieren',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
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
              SizedBox(height: 10,),
              TextFieldApp(hintText: 'Vorname',hintTitle: 'John',controller: firstname,type: TextInputType.text,),
              SizedBox(height: 10,),
              TextFieldApp(hintText: 'Nachname',hintTitle: 'Doe',controller: lastname,type: TextInputType.text),
              SizedBox(height: 10,),
              TextFieldApp(hintText: 'Land',hintTitle: 'Russia',controller: country,type: TextInputType.text),
              SizedBox(height: 10,),
              TextFieldApp(hintText: 'Email',hintTitle: 'johndoe@mail.com',controller: emailCtrl,type: TextInputType.emailAddress),
              SizedBox(height: 10,),
              TextFieldApp(hintText: 'Passwort',hintTitle: '*********',controller: passwordCtrl,obsecure: true,type: TextInputType.visiblePassword,),
              SizedBox(height: 10,),
              TextFieldApp(hintText: 'Passwort bestätigen',hintTitle: '*********',controller: confirmpassword,obsecure: true,type: TextInputType.visiblePassword),
              SizedBox(height: 40,),
              Container(
                  width: 270,
                  child: ButtonRound(buttonText: 'Registrieren', function: (){
                    FocusScope.of(context).unfocus();
                    if(emailCtrl.text!=null && emailCtrl.text!='' && passwordCtrl.text!=null && passwordCtrl.text!=''){
                     if(passwordCtrl.text==confirmpassword.text){
                       showCustomDialog(controller);


                     }else{
                       EasyLoading.showToast('Passwort und Passwort bestätigen stimmen nicht überein.',toastPosition: EasyLoadingToastPosition.bottom);
                     }
                    }else{
                      EasyLoading.showToast('Bitte E-Mail & Passwort eingeben',toastPosition: EasyLoadingToastPosition.bottom);
                    }

                  },)),
              SizedBox(height: 30,),

            ],
          ),
        ),
      ),
    );
  }
}
