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
  TextEditingController phone = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

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
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('    Sign In',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
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
              TextFieldApp(hintText: 'First Name',hintTitle: 'John',controller: firstname,),
              SizedBox(height: 10,),
              TextFieldApp(hintText: 'Last Name',hintTitle: 'Doe',controller: lastname,),
              SizedBox(height: 10,),
              TextFieldApp(hintText: 'Country',hintTitle: 'Russia',controller: country,),
              SizedBox(height: 10,),
              TextFieldApp(hintText: 'Phone',hintTitle: '+9258798798',controller: phone,),
              SizedBox(height: 10,),
              TextFieldApp(hintText: 'Email',hintTitle: 'johndoe@mail.com',controller: emailCtrl,),
              SizedBox(height: 10,),
              TextFieldApp(hintText: 'Password',hintTitle: '*********',controller: passwordCtrl,obsecure: true,),
              SizedBox(height: 10,),
              TextFieldApp(hintText: 'Confirm Password',hintTitle: '*********',controller: confirmpassword,obsecure: true,),
              SizedBox(height: 40,),
              Container(
                  width: 270,
                  child: ButtonRound(buttonText: 'Register', function: (){
                    FocusScope.of(context).unfocus();
                    if(emailCtrl.text!=null && emailCtrl.text!='' && passwordCtrl.text!=null && passwordCtrl.text!=''){
                     if(passwordCtrl.text==confirmpassword.text){
                       controller.setEmailAndPassword(
                         emailCtrl.text,
                         passwordCtrl.text,
                       );

                     }else{
                       EasyLoading.showToast('Password and Confirm Password not matched.',toastPosition: EasyLoadingToastPosition.bottom);
                     }
                    }else{
                      EasyLoading.showToast('Please enter Email & Password',toastPosition: EasyLoadingToastPosition.bottom);
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
