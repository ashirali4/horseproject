import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:horseproject/src/net/firebase_operations.dart';

import '../../../utlis/constants.dart';
import '../../../utlis/enums.dart';
import '../../../widgets/button_round.dart';
import '../../../widgets/image_widget.dart';
import '../../../widgets/textfield.dart';
import '../../../widgets/user_profile_image_widget.dart';
class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  var data;
  String fname='';
  String lname='';
  TextEditingController country=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController zip=TextEditingController();
  TextEditingController address=TextEditingController();
  String urserProfile='';


  @override
  void initState() {
    getUsersData();
    // TODO: implement initState
    super.initState();
  }

  getUsersData() async {
    data=await FirebaseDB.getUsersInfo();
    var mydata=jsonDecode(data);
    setState(() {
      fname= mydata['firstName'] ?? '';
      lname= mydata['lastName'] ?? '';
      email.text = mydata['email'] ?? '';
      phone.text = mydata['phone'] ?? '';
      country.text = mydata['country'] ?? '';
      address.text = mydata['address'] ?? '';
      zip.text = mydata['zip'] ?? '';
      urserProfile = mydata['userimage'] ?? '';
    });
  }


  onSave() async {
    Map<String, dynamic> data = <String, dynamic>{
      "firstName": fname,
      "lastName" : lname,
      "country" : country.text,
      "phone" : phone.text,
      "email" : email.text,
      "address" : address.text,
      "zip" : zip.text,
      "userimage" : urserProfile
    };
    await FirebaseDB.savedata(data: data,type: 'users');
    EasyLoading.showToast('Profil wurde aktualisiert.',toastPosition: EasyLoadingToastPosition.bottom);
  }

  void onUpdateImage(String url){
    setState(() {
      urserProfile=url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   AppBar(
        backgroundColor: Colors.blue,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
        title:Text('Eigentümer'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              UserProfileImageWidget(
                urlpre: urserProfile,
                text:'',
                onUpdate: onUpdateImage,
                icons: Icons.camera_alt_outlined,
                widgetType: WidgetType.ImageType,
              ),
              OtherBody(),
              SizedBox(height: 30,),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonRound(buttonText: 'Profil speichern', function:  (){
                    onSave();
                  },buttonColor: Colors.blue,)),
              SizedBox(height: 10,),
              SizedBox(height: 10,),
              SizedBox(height: 10,),
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
          Text(fname+' '+lname,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
          SizedBox(height: 20,),
          TextFieldApp(hintText: 'Straße',hintTitle: '25 H1 Johar Town',controller: address,type: TextInputType.text),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'PLZ, Ort',hintTitle: '54000',controller: zip,type: TextInputType.text),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Land',hintTitle: 'Russia',controller: country,type: TextInputType.text),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Telefon',hintTitle: '0900786001',controller: phone,type: TextInputType.phone),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Email',hintTitle: 'johndoe@mail.com',controller: email,type: TextInputType.emailAddress),

        ],
      ),
    );
  }

}
