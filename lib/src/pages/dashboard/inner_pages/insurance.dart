import 'package:flutter/material.dart';

import '../../../utlis/constants.dart';
import '../../../widgets/button_round.dart';
import '../../../widgets/textfield.dart';
class Insurance extends StatefulWidget {
  const Insurance({Key? key}) : super(key: key);

  @override
  _InsuranceState createState() => _InsuranceState();
}

class _InsuranceState extends State<Insurance> {


  TextEditingController name=TextEditingController();
  TextEditingController address=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController vern=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   AppBar(
        backgroundColor: BACKGROUND_COLOR_DASHBOARD,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
        title: Text('Insurance'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ImageWidget('Upload Photo/Video',Icons.camera_alt_outlined),
              SizedBox(height: 10,),
              TextFieldApp(hintText: 'Name of Horse',hintTitle: 'Black Horse',controller: name,),
              SizedBox(height: 10,),
              OtherBody('Liability',name,address,phone,email,vern),
              SizedBox(height: 10,),
              OtherBody('Health Insurance',name,address,phone,email,vern),
              SizedBox(height: 10,),
              OtherBody('Surgical Insurance',name,address,phone,email,vern),
              SizedBox(height: 10,),

              Container(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonRound(buttonText: 'Add New Insurance', function:  (){},)),
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
      TextEditingController controller4, TextEditingController controller5,
      ){
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
          TextFieldApp(hintText: 'Vers. Number',hintTitle: '123****',controller: controller5,),
          SizedBox(height: 10,),
          ImageWidget('Upload Documents',Icons.attach_file),

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
