import 'package:flutter/material.dart';
import 'package:horseproject/src/utlis/constants.dart';

import '../../widgets/background_widget.dart';
import '../../widgets/button_round.dart';
import '../../widgets/or_login_with.dart';
import '../../widgets/textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return BackgroundImageWidget(
      elements: Elements(),
    );
  }

  Widget Elements(){
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('    Register',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 35,right: 35,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10,),
              TextFieldApp(hintText: 'First Name',hintTitle: 'John'),
              SizedBox(height: 10,),
              TextFieldApp(hintText: 'Last Name',hintTitle: 'Doe'),
              SizedBox(height: 10,),
              TextFieldApp(hintText: 'Country',hintTitle: 'Russia'),
              SizedBox(height: 10,),
              TextFieldApp(hintText: 'Phone',hintTitle: '+9258798798'),
              SizedBox(height: 10,),
              TextFieldApp(hintText: 'Email',hintTitle: 'johndoe@mail.com'),
              SizedBox(height: 10,),
              TextFieldApp(hintText: 'Password',hintTitle: '*********'),
              SizedBox(height: 10,),
              TextFieldApp(hintText: 'Confirm Password',hintTitle: '*********'),
              SizedBox(height: 40,),
              Container(
                  width: 270,
                  child: ButtonRound(buttonText: 'Register',)),
              SizedBox(height: 30,),

            ],
          ),
        ),
      ),
    );
  }
}
