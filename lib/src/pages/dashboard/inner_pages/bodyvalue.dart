import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utlis/constants.dart';
import '../../../widgets/button_round.dart';
import '../../../widgets/textfield.dart';
class BodyValue extends StatefulWidget {
  const BodyValue({Key? key}) : super(key: key);

  @override
  _BodyValueState createState() => _BodyValueState();
}

class _BodyValueState extends State<BodyValue> {

  TextEditingController size=TextEditingController();
  TextEditingController weght=TextEditingController();
  TextEditingController lastdate=TextEditingController();
  TextEditingController nextdate=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   AppBar(
        backgroundColor: BACKGROUND_COLOR_DASHBOARD,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
        title: Text('Körperwerte'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              OtherBody('Liability'),
              SizedBox(height: 20,),

              Container(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonRound(buttonText: 'Wiegetermin buchen', function:  () async{
                    if (!await launch('https://termine.wirwiegendeinpferd.de/wp/')) throw 'Could not launch';
                  },)),
              SizedBox(height: 20,),
              OtherColumn(),

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
          TextFieldApp(hintText: 'Size(cm)',hintTitle: '170',controller: size,type: TextInputType.text),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Weight (kg)',hintTitle: '450',controller: weght,type: TextInputType.text),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Last Date',hintTitle: 'dd/mm/yy',controller: lastdate,type: TextInputType.text),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Next Date',hintTitle: 'dd/mm/yy',controller: nextdate,type: TextInputType.text),
          SizedBox(height: 10,),


        ],
      ),
    );
  }


  Widget OtherColumn(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(' Body Values Infographics',style: TextStyle(fontWeight: FontWeight.bold,color: LIGHT_BUTTON_COLOR),),
        SizedBox(height: 20,),
        Image.asset("assets/graph.png"),
        Image.asset("assets/graph2.png"),
        SizedBox(height: 30,),

      ],
    );
  }


}
