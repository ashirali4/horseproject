import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../utlis/constants.dart';
import '../../../widgets/button_round.dart';
import '../../../widgets/textfield.dart';
class DiaryHorse extends StatefulWidget {
  const DiaryHorse({Key? key}) : super(key: key);

  @override
  _DiaryHorseState createState() => _DiaryHorseState();
}

class _DiaryHorseState extends State<DiaryHorse> {

  TextEditingController title=TextEditingController();
  TextEditingController startdate=TextEditingController();
  TextEditingController enddate=TextEditingController();
  TextEditingController descriptionm=TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   AppBar(
        backgroundColor: BACKGROUND_COLOR_DASHBOARD,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
        title: Text('Dairy'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              OtherBody(),
              SizedBox(height: 0,),
              ImageWidget('Upload Photo/Video',Icons.camera_alt),
              SizedBox(height: 10,),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonRound(buttonText: 'Save', function:  (){},)),

            ],
          ),
        ),
      ),
    );
  }



  Widget OtherBody(){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Title',hintTitle: 'Enter the title',controller: title,),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Start Date',hintTitle: 'dd/mm/yyyy',controller: startdate,),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'End Date',hintTitle: 'dd/mm/yyyy',controller: enddate,),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Description',hintTitle: 'Enter message here',controller: descriptionm,),
          SizedBox(height: 10,),
          Text(' Daily Weather',style: TextStyle(fontWeight: FontWeight.bold,color: LIGHT_BUTTON_COLOR),),
          SizedBox(height: 10,),
          ToggleSwitch(
            initialLabelIndex: 0,
            totalSwitches: 4,
            minWidth: 90,
            activeBgColor: [Colors.red],
            labels: ['Sun', 'Clouds', 'Rain','Rainbow'],
            onToggle: (index) {
              print('switched to: $index');
            },
          ),
          SizedBox(height: 10,),
          Text(' Horse Mood',style: TextStyle(fontWeight: FontWeight.bold,color: LIGHT_BUTTON_COLOR),),
          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(child:  Container(
                  height: 50,
                  width: 50,
                  child: Image.asset('assets/horseshoe.png')),),
              Expanded(child:  Container(
                  height: 50,
                  width: 50,
                  child: Image.asset('assets/horseshoe.png')),),
              Expanded(child:  Container(
                  height: 50,
                  width: 50,
                  child: Image.asset('assets/horseshoe.png')),),
              Expanded(child:  Container(
                  height: 50,
                  width: 50,
                  child: Image.asset('assets/horseshoe.png')),),
              Expanded(child:  Container(
                  height: 50,
                  width: 50,
                  child: Image.asset('assets/horseshoe.png')),),
            ],
          ),
          SizedBox(height: 05,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                width: 50,
                child: Text('Bad'),
              ),
              Container(
                width: 50,
                child: Text('Super Good'),
              )
            ],
          )
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
