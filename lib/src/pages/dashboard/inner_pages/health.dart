import 'package:flutter/material.dart';

import '../../../utlis/constants.dart';
import '../../../widgets/button_round.dart';
import '../../../widgets/textfield.dart';
class Health extends StatefulWidget {
  const Health({Key? key}) : super(key: key);

  @override
  _InsuranceState createState() => _InsuranceState();
}

class _InsuranceState extends State<Health> {


  TextEditingController name=TextEditingController();
  TextEditingController address=TextEditingController();
  TextEditingController btype=TextEditingController();
  TextEditingController med=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   AppBar(
        backgroundColor: BACKGROUND_COLOR_DASHBOARD,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
        title: Text('Health'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ImageWidget('Upload Photo/Video',Icons.camera_alt_outlined),
              SizedBox(height: 10,),
              OtherBody('Liability'),
              SizedBox(height: 20,),

              Container(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonRound(buttonText: 'Send Email', function:  (){},)),
              SizedBox(height: 30,),


            ],
          ),
        ),
      ),
    );
  }



  Widget OtherBody(String text){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         SizedBox(height: 10,),
          TextFieldApp(hintText: 'Name of Horse',hintTitle: 'Black Horse',controller: name,),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Alergiers',hintTitle: 'Name of Allergies',controller: address,),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Blood Type',hintTitle: 'Blood group',controller: btype,),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Medicine',hintTitle: 'Name of Medicine',controller: med,),
          SizedBox(height: 10,),
          Text('Vaccination',style: TextStyle(
            fontWeight: FontWeight.w600,fontSize: 20
          ),),
          healthDateBox('Equine Flu'),
          healthDateBox('Herpes'),
          healthDateBox('Druse'),
          healthDateBox('Rabies'),healthDateBox('Borreliosis'),
          Text('Anthelmintic Therapy',style: TextStyle(
              fontWeight: FontWeight.w600,fontSize: 20
          ),),
          healthDateBox('Therapy'),
          Text('Farrier',style: TextStyle(
              fontWeight: FontWeight.w600,fontSize: 20
          ),),
          healthDateBox(''),
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


  Widget healthDateBox(String text){
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(' '+text,style: TextStyle(fontWeight: FontWeight.bold,color: LIGHT_BUTTON_COLOR),),
          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(child: DateBox('Last Date') ),
              SizedBox(width: 20,),
              Expanded(child: DateBox('Nex Date') ),
            ],
          )
        ],
      ),
    );
  }

  Widget DateBox(String text){
    return Container(
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(width: 1,color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.date_range,color: Colors.black,),
          SizedBox(width: 3,),
          Text(text,style: TextStyle(

          ),)
        ],
      ),
    );
  }

}
