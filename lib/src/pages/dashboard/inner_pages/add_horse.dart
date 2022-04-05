import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:horseproject/src/net/firebase_operations.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../utlis/constants.dart';
import '../../../utlis/races.dart';
import '../../../widgets/button_round.dart';
import '../../../widgets/calendar_theme.dart';
import '../../../widgets/textfield.dart';
class AddHorse extends StatefulWidget {
  var finalData;
  AddHorse({Key? key,this.finalData}) : super(key: key);

  @override
  _AddHorseState createState() => _AddHorseState();
}

class _AddHorseState extends State<AddHorse> {

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(TextEditingController text) async {
    final DateTime? picked = await showDatePicker(

        context: context,
        builder: (context,child) {
          return CalendarTheme(child: child!,);
        },
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        //selectedDate = picked;
        text.text = picked.toString().substring(0,10);
      });
    }
  }

  TextEditingController name=TextEditingController();
  TextEditingController race=TextEditingController();
  TextEditingController dob=TextEditingController();
  TextEditingController coatcolor=TextEditingController();
  TextEditingController specialmark=TextEditingController();
  TextEditingController pdate=TextEditingController(text: DateTime.now().toString().substring(0,10));
  TextEditingController pnumber=TextEditingController();
  TextEditingController mnumber=TextEditingController();
  TextEditingController lifenumber=TextEditingController();
  String gender='Mare';
  var data;
  @override
  void initState() {
    getHorsedast();
    // TODO: implement initState
    super.initState();
  }

  getHorsedast() async {
   try{
     data=widget.finalData;
     var mydata=data;
     setState(() {
       name.text=mydata['name']??'';
       race.text=mydata['race']??'';
       dob.text=mydata['dob']??'';
       coatcolor.text=mydata['ccolor']??'';
       specialmark.text=mydata['smark']??'';
       pdate.text=mydata['pdate']??'';
       pnumber.text=mydata['pnumber']??'';
       mnumber.text=mydata['mnumber']??'';
       lifenumber.text=mydata['lnumber']??'';

     });
   } catch(e){
     print("Erorr " + e.toString());
   }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   AppBar(
        backgroundColor: BACKGROUND_COLOR_DASHBOARD,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
        title: Text('Horse'),
        centerTitle: true,
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
                  child: ButtonRound(buttonText: 'Save Horse', function:  () async {

                    if(name!=null && name.text!=""){
                      await FirebaseDB.saveHorse(name: name.text, gender: gender,
                          race: race.text, dob: dob.text, ccolor: coatcolor.text,
                          smark: specialmark.text, pdate: pdate.text, pnumber:
                          pnumber.text, mnumber: mnumber.text, lnumber: lifenumber.text);
                      EasyLoading.showToast('Horse has been Saved.',toastPosition: EasyLoadingToastPosition.bottom);
                    }

                  },)),
              SizedBox(height:30,),

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
          TextFieldApp(hintText: 'Name of Horse',hintTitle: 'Black Horse',controller: name,),
          SizedBox(height: 10,),
          Text(' Gender',style: TextStyle(fontWeight: FontWeight.bold,color: LIGHT_BUTTON_COLOR),),
          SizedBox(height: 10,),
          ToggleSwitch(
            initialLabelIndex: 0,
            totalSwitches:3,
            minWidth: MediaQuery.of(context).size.width/3.4,
            activeBgColor: [Colors.red],
            labels: ['Mare', 'Gelding', 'Stallion'],
            onToggle: (index) {
              if(index==0){
                gender='Mare';
              }else if(index==1){
                gender='Gelding';
              }else if(index==2){
                gender='Stallion';
              }
              print('switched to: $index');
            },
          ),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Race',hintTitle: 'Select Race',controller: race,
          endingWidget: DropdownButton<String>(
            items: racesList.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                race.text=value!;
              });
            },
          ),isEnabled: false,),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Date of Birth',hintTitle: 'dd/mm/yyyy',controller: dob,
          endingWidget: IconButton(
            icon: Icon(Icons.date_range),
            onPressed: (){
              _selectDate(dob);
            }
          ),
          ),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Coat Color',hintTitle: 'Red Color',controller: coatcolor,),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Special Mark',hintTitle: 'Mark',controller: specialmark,),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Pruchasing Date',hintTitle: 'dd/mm/yyyy',controller: pdate,
            endingWidget: IconButton(
                icon: Icon(Icons.date_range),
                onPressed: (){
                  _selectDate(pdate);
                }
            ),),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Passport Number',hintTitle: '123*****',controller: pnumber,),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Microchip Number',hintTitle: '123*****',controller: mnumber,),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Life Number',hintTitle: '123*****',controller: lifenumber,),

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
