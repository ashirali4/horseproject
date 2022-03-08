import 'package:flutter/material.dart';

import '../../../utlis/constants.dart';
import '../../../widgets/button_round.dart';
import '../../../widgets/textfield.dart';
class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   AppBar(
        backgroundColor: BACKGROUND_COLOR_DASHBOARD,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
        title: Center(child: Text('Owner')),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ImageWidget(),
              OtherBody(),
              SizedBox(height: 30,),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonRound(buttonText: 'Save Profile',)),
            ],
          ),
        ),
      ),
    );
  }


  Widget OtherBody(){
    return Container(
      child: Column(
        children: [
          Text('Maria Hogain',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
          SizedBox(height: 20,),
          TextFieldApp(hintText: 'Street',hintTitle: '25 H1 Johar Town'),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Zip',hintTitle: '54000'),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Country',hintTitle: 'Russia'),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Phone',hintTitle: '0900786001'),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Email',hintTitle: 'johndoe@mail.com'),

        ],
      ),
    );
  }

  Widget ImageWidget(){
    return Container(
      margin: EdgeInsets.only(top: 20,bottom: 20),
      child: SizedBox(
        child: CircleAvatar(
          radius: 55.0,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            child: Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 15.0,
                child: Icon(
                  Icons.camera_alt,
                  size: 15.0,
                  color: Color(0xFF404040),
                ),
              ),
            ),
            radius: 50.0,
            backgroundImage: NetworkImage(
                'http://writestylesonline.com/wp-content/uploads/2016/08/Follow-These-Steps-for-a-Flawless-Professional-Profile-Picture-1024x1024.jpg'),
          ),
        ),),
    );
  }
}
