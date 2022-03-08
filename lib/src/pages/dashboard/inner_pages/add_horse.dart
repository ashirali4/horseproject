import 'package:flutter/material.dart';

import '../../../utlis/constants.dart';
import '../../../widgets/button_round.dart';
import '../../../widgets/textfield.dart';
class AddHorse extends StatefulWidget {
  const AddHorse({Key? key}) : super(key: key);

  @override
  _AddHorseState createState() => _AddHorseState();
}

class _AddHorseState extends State<AddHorse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   AppBar(
        backgroundColor: BACKGROUND_COLOR_DASHBOARD,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
        title: Center(child: Text('Horse')),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ImageWidget('Upload Photo/Video',Icons.camera_alt_outlined),
              OtherBody(),
              SizedBox(height: 0,),
              ImageWidget('Upload Documents',Icons.attachment),
              SizedBox(height: 10,),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonRound(buttonText: 'Add Horse',)),

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
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Name of Horse',hintTitle: 'Black Horse'),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Race',hintTitle: '54000'),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Date of Birth',hintTitle: 'dd/mm/yyyy'),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Coat Color',hintTitle: 'Red Color'),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Special Mark',hintTitle: 'Mark'),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Pruchasing Date',hintTitle: 'dd/mm/yyyy'),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Passport Number',hintTitle: '123*****'),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Microchip Number',hintTitle: '123*****'),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Life Number',hintTitle: '123*****'),

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
