import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';
import 'package:horseproject/src/pages/auth/recovery_password.dart';
import 'package:horseproject/src/pages/dashboard/dashboard.dart';
import 'package:horseproject/src/utlis/constants.dart';

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
                      controller.setEmailAndPassword(
                        emailCtrl.text,
                        passwordCtrl.text,
                      );
                    }else{
                      EasyLoading.showToast('Bitte E-Mail & Passwort eingeben',toastPosition: EasyLoadingToastPosition.bottom);
                    }
                  },)),
              SizedBox(height: 30,),
            //  OrLoginWith(),
              PrivacyPolicy(),
            //   Container(
            //       width: 280,
            //       height: 50,
            //       child: ButtonRoundGoogle(buttonText: 'Continue with Google',buttonColor: Colors.white,textColor: LIGHT_BUTTON_COLOR,)),
             ],
          ),
        ),
      ),
    );
  }
}
