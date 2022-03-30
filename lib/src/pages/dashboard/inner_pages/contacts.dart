import 'package:flutter/material.dart';

import '../../../net/firebase_operations.dart';
import '../../../utlis/constants.dart';
import '../../../widgets/button_round.dart';
import '../../../widgets/textfield.dart';
class ContactHorse extends StatefulWidget {
  const ContactHorse({Key? key}) : super(key: key);

  @override
  _ContactHorseState createState() => _ContactHorseState();
}

class _ContactHorseState extends State<ContactHorse> {

  TextEditingController name=TextEditingController();
  TextEditingController address=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController email=TextEditingController();



  TextEditingController name2=TextEditingController();
  TextEditingController address2=TextEditingController();
  TextEditingController phone2=TextEditingController();
  TextEditingController email2=TextEditingController();



  TextEditingController name3=TextEditingController();
  TextEditingController address3=TextEditingController();
  TextEditingController phone3=TextEditingController();
  TextEditingController email3=TextEditingController();


  TextEditingController name4=TextEditingController();
  TextEditingController address4=TextEditingController();
  TextEditingController phone4=TextEditingController();
  TextEditingController email4=TextEditingController();
  
  
  onSave(){
    Map<String, dynamic> data = <String, dynamic>{
      "n1": name,
      "a1" : address,
      "p1" : phone,
      "e1" : email,
      "n2": name2,
      "a2" : address2,
      "p2" : phone2,
      "e2" : email2,
      "n3": name3,
      "a3" : address3,
      "p3" : phone3,
      "e3" : email3,
      "n4": name4,
      "a4" : address4,
      "p4" : phone4,
      "e4" : email4,
    };
    FirebaseDB.saveContacts(data: data);
 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   AppBar(
        backgroundColor: BACKGROUND_COLOR_DASHBOARD,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
        title: Text('Contacts'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              OtherBody('Horse Stable',name,address,phone,email),
              SizedBox(height: 10,),
              OtherBody('Veterinarian',name2,address2,phone2,email2),
              SizedBox(height: 10,),
              OtherBody('Horse Clinic',name3,address3,phone3,email3),
              SizedBox(height: 10,),
              OtherBody('Therapist',name4,address4,phone4,email4),
              SizedBox(height: 10,),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonRound(buttonText: 'Save Contacts', function:  (){},)),
              SizedBox(height: 30,),


            ],
          ),
        ),
      ),
    );
  }



  Widget OtherBody(String text,TextEditingController controller1,
      TextEditingController controller2,
      TextEditingController controller3,
      TextEditingController controller4){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Text(text,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Name',hintTitle: 'Name of Insurer',controller: controller1,),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Address',hintTitle: 'Address here',controller: controller2,),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Phone Number',hintTitle: '+9823423423',controller: controller3,),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Email',hintTitle: 'test@gmail.com',controller: controller4,),
          SizedBox(height: 10,),
        ],
      ),
    );
  }

  Widget ImageWidget(String text,IconData icons){
    return Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: BACKGROUND_COLOR_ADD_HORSE.withOpacity(.3),
            borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        margin: EdgeInsets.only(top: 20,bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20.0,
                child: Icon(
                  icons,
                  size: 22.0,
                  color: BACKGROUND_COLOR_DASHBOARD,
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text(text,style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),)
          ],
        )
    );
  }
}
