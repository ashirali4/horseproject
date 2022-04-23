import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:horseproject/src/net/firebase_operations.dart';
import 'package:horseproject/src/pages/dashboard/dashboard.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../main.dart';
import '../../../utlis/constants.dart';
import '../../../utlis/enums.dart';
import '../../../utlis/races.dart';
import '../../../widgets/button_round.dart';
import '../../../widgets/calendar_theme.dart';
import '../../../widgets/horse_chart.dart';
import '../../../widgets/image_widget.dart';
import '../../../widgets/textfield.dart';
import '../../others/qr_page.dart';
import 'horses_list.dart';
class AddHorse extends StatefulWidget {
  List<String> data;
  HorseEditType pageType;
  AddHorse({Key? key,required this.data,required this.pageType}) : super(key: key);

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
        firstDate: DateTime(1995, 1),
        locale: const Locale("de", "DE"),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      if(picked.isAfter(DateTime.now())){
        EasyLoading.showToast('Das ausgewählte Datum sollte vor dem heutigen Tag liegen',toastPosition: EasyLoadingToastPosition.bottom);
      }else{
        setState(() {
          //selectedDate = picked;
          text.text = formatter.format(picked);
        });
      }
    }
  }

  TextEditingController name=TextEditingController();
  TextEditingController race=TextEditingController();
  TextEditingController dob=TextEditingController();
  TextEditingController coatcolor=TextEditingController();
  TextEditingController specialmark=TextEditingController();
  TextEditingController pdate=TextEditingController();
  TextEditingController pnumber=TextEditingController();
  TextEditingController mnumber=TextEditingController();
  TextEditingController lifenumber=TextEditingController();
  TextEditingController horseHeight=TextEditingController();
  TextEditingController weightDate=TextEditingController();
  TextEditingController weightId=TextEditingController();
  TextEditingController weidghtText=TextEditingController();


  List<dynamic> weiightHistory = [];
  List<dynamic> weightsdates = [];
  List<dynamic> weightsIds = [];


  String gender='Mare';
  String uploadImagevideoUrl= '';
  String uploadPDF='';
  var data;
  @override
  void initState()  {
    //getHorsedast();
    if(widget.pageType!=HorseEditType.SimpleAddHorse){
     getHorseDetails();
    }
    // TODO: implement initState
    super.initState();
  }

  getHorseDetails() async {
    if(widget.data.length>0 && widget.pageType==HorseEditType.AddHorse){
      bool docExists = await FirebaseDB.checkIfDocExists(widget.data[1]);
      if(docExists){
        await getHorsedast(widget.data[1],widget.data[1]);
        weiightHistory.add(widget.data[2]);
        weightsdates.add(widget.data[4]);
        weightsIds.add(widget.data[5]);
      }else{
        name.text = widget.data[1];
        horseHeight.text= widget.data[3];
        weiightHistory.add(widget.data[2]);
        weightsdates.add(widget.data[4]);
        weightsIds.add(widget.data[5]);
      }
    } else if(widget.pageType==HorseEditType.EditHorse){
      getHorsedast(widget.data[0],widget.data[0]);
    }

    setState(() {

    });
  }


  getHorsedast(String nametofetch,String weightid) async {
   try{
     data=await FirebaseDB.gethorseData(nametofetch);
     var mydata=jsonDecode(data);
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
       horseHeight.text = mydata['lnumber']??'';
       weiightHistory = mydata['whistory'] ?? [];
       weightsdates = mydata['wdates'] ?? [];
       weightsIds = mydata['weightIDS'] ?? [];
       uploadImagevideoUrl = mydata['imageurl']??'';
       uploadPDF = mydata['pdfurl']??'';
     });
   } catch(e){
     print("Erorr " + e.toString());
   }
  }


  void onUpdateImage(String url){
    setState(() {
      uploadImagevideoUrl=url;
    });
  }

  void onUpdatePdf(String url){
    setState(() {
      uploadPDF=url;
    });
  }

  void onWeightAdd(){
    FocusScope.of(context).unfocus();
    if(weightDate==null || weightDate.text==""){
      EasyLoading.showToast('Bitte wählen Sie ein Datum aus..',toastPosition: EasyLoadingToastPosition.bottom);

    }else if(weidghtText==null || weidghtText.text==""){
      EasyLoading.showToast('Bitte geben Sie das Gewicht ein',toastPosition: EasyLoadingToastPosition.bottom);
    }else{
      setState(() {
        weiightHistory.add(weidghtText.text);
        weightsdates.add(weightDate.text);
        weightsIds.add('-');
        weidghtText.clear();
        weightDate.clear();
        weightId.clear();

      });
    }
  }

  void onWeightRemove(int index){
    setState(() {
      weiightHistory.removeAt(index);
      weightsdates.removeAt(index);
      weightsIds.removeAt(index);
    });
  }

  List<charts.Series<WeightList, String>> _createSampleData() {
    List<WeightList> data = [];
    if(weiightHistory.length>0){
      if(weiightHistory.length>8){
        int modeValue = weiightHistory.length%8;
        print("mode value"+ modeValue.toString());
        List<dynamic> newWeightHistory= weiightHistory.sublist(modeValue,weiightHistory.length);
        List<dynamic> newWeightDates= weightsdates.sublist(modeValue,weightsdates.length);
        for(int a=0;a<newWeightHistory.length;a++){
          data.add(  WeightList(newWeightDates[a], int.parse(newWeightHistory[a])));
        }
      }else{
        for(int a=0;a<weiightHistory.length;a++){
          data.add(  WeightList(weightsdates[a], int.parse(weiightHistory[a])));
        }
      }
    }
    return [
      new charts.Series<WeightList, String>(
        id: 'Weights',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (WeightList sales, _) => sales.date,
        measureFn: (WeightList sales, _) => sales.weights,
        data: data,
      )
    ];
  }


  Future<bool> _willPopCallback() async {
    if(widget.pageType==HorseEditType.AddHorse){
      Navigator.of(context).popUntil((route) => route.isFirst);
    }else{
      Navigator.pop(context);
    }
    return true; // return true if the route to be popped
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:_willPopCallback,
      child: Scaffold(
        appBar:   AppBar(
          backgroundColor: BACKGROUND_COLOR_DASHBOARD,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
          title: Text('Pferd'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.only(left: 10,right: 10),
          margin: EdgeInsets.only(left: 10,right: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                 UploadImageWidget(
                  urlpre: uploadImagevideoUrl,
                  text:'Foto/Video hochladen',
                  onUpdate: onUpdateImage,
                  icons: Icons.camera_alt_outlined,
                  widgetType: WidgetType.ImageType,
                ),
                OtherBody(),
                SizedBox(height: 0,),
                UploadImageWidget(
                  urlpre: uploadPDF,
                  text:'Dokumente hochladen',
                  onUpdate: onUpdatePdf,
                  icons: Icons.attachment,
                  widgetType: WidgetType.PDFType,
                ),
                SizedBox(height: 10,),
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: ButtonRound(buttonText: 'Speichern', function:  () async {
                     if(name==null || name.text==''){
                       EasyLoading.showToast('Bitte geben Sie den Pferdenamen ein',toastPosition: EasyLoadingToastPosition.bottom);
                     }else{
                       await FirebaseDB.saveHorse(name: name.text, gender: gender,
                           race: race.text, dob: dob.text, ccolor: coatcolor.text,
                           smark: specialmark.text, pdate: pdate.text, pnumber:
                           pnumber.text, mnumber: mnumber.text, lnumber: lifenumber.text,
                           height : horseHeight.text,weights: weiightHistory,weightsdDates: weightsdates,weightsIDS: weightsIds,
                           imageurl: uploadImagevideoUrl, pdfurl: uploadPDF
                       );
                       EasyLoading.showToast('Pferdedaten wurden gespeichert.',toastPosition: EasyLoadingToastPosition.bottom);

                       if(widget.data.length>0 && widget.pageType==HorseEditType.AddHorse){
                         Navigator.pushAndRemoveUntil(
                             context,
                             MaterialPageRoute(builder: (BuildContext context) => Dashboard()),
                             ModalRoute.withName('/'));
                         Get.to(HorseList(type: ListType.Horse,));
                       } else if(widget.pageType==HorseEditType.EditHorse){
                         Navigator.pop(context);

                       }else{
                         Navigator.pop(context);

                       }
                     }

                    },)),
                SizedBox(height:30,),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget AddWeight(){
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 10,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(08)),
          color: Colors.white),
      child: Padding(
          padding:
          const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Get.to(QRScan());
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(100))
                      ),
                      child: Icon(Icons.qr_code_outlined,color: Colors.white,),
                    ),
                  ),
                  Text('ODER',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),

                  Container(
                      width: 160,
                      child: ButtonRound(buttonText: 'Gewicht hinzufügen', function:  () async {
                        onWeightAdd();
                      },)),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(weightDate==null || weightDate.text==''? ' Wiegedatum' : weightDate.text,style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                  ),),
                  IconButton(onPressed: (){
                    _selectDate(weightDate);
                  }, icon: Icon(Icons.date_range,color: Colors.red,))
                ],
              ),
              Row(
                children: [

                  Expanded(child:  TextFieldApp(hintText: 'Gewicht kg',hintTitle: 'Black Horse',controller: weidghtText,type: TextInputType.number),)
                ],
              ),


              SizedBox(height: 15,),
            ],
          ),),
    );
  }

  Widget OtherBody(){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Name des Pferdes',hintTitle: 'Black Horse',controller: name,type: TextInputType.text,isEnabled: widget.pageType==HorseEditType.EditHorse ? false: true,),
          SizedBox(height: 10,),
          Text(' Geschlecht',style: TextStyle(fontWeight: FontWeight.bold,color: LIGHT_BUTTON_COLOR),),
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
          TextFieldApp(hintText: 'Wettrennen',hintTitle: 'Rasse',controller: race,type: TextInputType.text,
          // endingWidget: DropdownButton<String>(
          //   items: racesList.map((String value) {
          //     return DropdownMenuItem<String>(
          //       value: value,
          //       child: Text(value),
          //     );
          //   }).toList(),
          //   onChanged: (value) {
          //     setState(() {
          //       race.text=value!;
          //     });
          //   },
          // ),
          ),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Geburtsdatum',hintTitle: 'dd/mm/yyyy',controller: dob,
          endingWidget: IconButton(
            icon: Icon(Icons.date_range),
            onPressed: (){
              _selectDate(dob);
            }
          ),
              type: TextInputType.text
          ),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Fellfarbe',hintTitle: 'Red Color',controller: coatcolor,type: TextInputType.text),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Besonderes Zeichen',hintTitle: 'Mark',controller: specialmark,type: TextInputType.text),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Größe cm',hintTitle: 'Horse Height',controller: horseHeight,type: TextInputType.text),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Kaufdatum',hintTitle: 'dd/mm/yyyy',controller: pdate,
            endingWidget: IconButton(
                icon: Icon(Icons.date_range),
                onPressed: (){
                  _selectDate(pdate);
                }
            ),type: TextInputType.text),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Ausweisnummer',hintTitle: '123*****',controller: pnumber,type: TextInputType.number),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Mikrochip-Nummer',hintTitle: '123*****',controller: mnumber,type: TextInputType.number),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Lebensnummer',hintTitle: '123*****',controller: lifenumber,type: TextInputType.number),
          SizedBox(height: 10,),
          AddWeight(),
          SizedBox(height: 10,),
          Text(' Speichern',style: TextStyle(fontWeight: FontWeight.bold,color: LIGHT_BUTTON_COLOR),),
          SizedBox(height: 10,),
          ListTile(

              trailing: Text('Gewicht kg' ,
                style: TextStyle(
                    color: Colors.green,fontSize: 15,fontWeight: FontWeight.bold),),
              title:Text('Datum'+ " - Wiegenummer",style: TextStyle(
                  fontSize: 15,fontWeight: FontWeight.bold),)
          ),
          ListView.builder(
              itemCount: weiightHistory.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context,int index){
                return ListTile(
                    leading: IconButton(
                      onPressed: (){
                        onWeightRemove(index);
                      },
                      icon: Icon(Icons.delete,color: Colors.red,),
                    ),
                    trailing: Text(weiightHistory[index] ,
                      style: TextStyle(
                          color: Colors.green,fontSize: 15),),
                    title:Text(weightsdates[index].toString()+ " - ("+ weightsIds[index]+")")
                );
              }
          ),
          SizedBox(height: 10,),
          // Container(
          //     height: 300,
          //     child: SimpleBarChart(
          //         _createSampleData(), true)),
          // SizedBox(height: 10,),
          Container(
              width: MediaQuery.of(context).size.width,
              child: ButtonRound(buttonText: 'Wiegetermin buchen', function:  () async{
                if (!await launch('https://termine.wirwiegendeinpferd.de/wp/')) throw 'Could not launch';
              },)),
          SizedBox(height: 10,),

        ],
      ),
    );
  }

  Widget ImageWidgetD(String text,IconData icons){
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
