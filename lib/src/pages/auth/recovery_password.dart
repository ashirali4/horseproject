import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';
import 'package:horseproject/src/pages/dashboard/dashboard.dart';
import 'package:horseproject/src/utlis/constants.dart';

import '../../widgets/background_widget.dart';
import '../../widgets/button_round.dart';
import '../../widgets/or_login_with.dart';
import '../../widgets/privacy.dart';
import '../../widgets/textfield.dart';
class RecoverPassword extends StatefulWidget {
  const RecoverPassword({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<RecoverPassword> {
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
          EasyLoading.show(status: 'Please Wait...');
        }
        if (state is AuthFailed){
          final e = state.exception as FirebaseAuthException;
          final newText = e.message;
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
      appBar: AppBar(
        title: Text('    Passwort vergessen',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
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

              SizedBox(height: 40,),
              Container(
                  width: 270,
                  child: ButtonRound(buttonText: 'Jetzt zurücksetzen', function:  (){
                    FocusScope.of(context).unfocus();
                    if(emailCtrl.text!=null && emailCtrl.text!='' ){
                      FirebaseAuth.instance.sendPasswordResetEmail(email:  emailCtrl.text);
                      emailCtrl.clear();
                      EasyLoading.showToast('Bitte überprüfen Sie Ihre E-Mail für weitere Anweisungen.',toastPosition: EasyLoadingToastPosition.bottom);

                    }else{
                      EasyLoading.showToast('Bitte registrierte E-Mail eingeben',toastPosition: EasyLoadingToastPosition.bottom);
                    }
                  },)),
              SizedBox(height: 30,),
              //  OrLoginWith(),
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
