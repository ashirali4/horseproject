import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../main.dart';
import '../../../net/firebase_operations.dart';
import '../../../utlis/constants.dart';
import '../../../utlis/enums.dart';
import '../../../widgets/button_round.dart';
import '../../../widgets/calendar_theme.dart';
import '../../../widgets/image_widget.dart';
import '../../../widgets/textfield.dart';
class DiaryHorse extends StatefulWidget {
  final String editId;
  final DiaryType type;
  const DiaryHorse({Key? key,required this.type, required this.editId}) : super(key: key);

  @override
  _DiaryHorseState createState() => _DiaryHorseState();
}

class _DiaryHorseState extends State<DiaryHorse> {

  TextEditingController title=TextEditingController();
  TextEditingController startdate=TextEditingController();
  TextEditingController enddate=TextEditingController();
  TextEditingController descriptionm=TextEditingController();
  int moodValue = 1;
  String uploadImagevideoUrl= '';
  int weather=0;
  DateTime selectedDate = DateTime.now();


  Future<void> _selectDate(TextEditingController text) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        builder: (context,child) {
          return CalendarTheme(child: child!,);
        },

        initialDate: selectedDate,
        firstDate: DateTime(1995, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
        setState(() {
          //selectedDate = picked;
          text.text = formatter.format(picked);
        });
    }
  }

  onGetData() async {
    try{
      var data= await FirebaseDB.getDataMapNew('diary',widget.editId);
      setState(() {
        title.text=data['title'] ?? '';
        startdate.text=data['start_date'] ?? '';
        enddate.text=data['end_date'] ?? '';
        descriptionm.text=data['description'] ?? '';
        weather = data['weather'] ?? 0;
        moodValue = data['mood'] ?? 1;
        uploadImagevideoUrl = data['image'] ?? 1;
      });
    }catch (e){
      print("Erorr " + e.toString());
    }

  }

  onSave() async {
    Map<String, dynamic> data = <String, dynamic>{
      "title": title.text,
      "start_date" : startdate.text,
      "end_date" : enddate.text,
      "description" : descriptionm.text,
      "weather" : weather,
      "mood" : moodValue,
      "image" : uploadImagevideoUrl
    };

    await FirebaseDB.saveDiaryData(data: data,type: widget.type,id: widget.editId);
    EasyLoading.showToast('Gesundheitsdaten wurden aktualisiert.',toastPosition: EasyLoadingToastPosition.bottom);
  }



  void onUpdateImage(String url){
    setState(() {
      uploadImagevideoUrl=url;
    });
  }

  @override
  void initState() {
    if(widget.type==DiaryType.Edit){
      onGetData();
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   AppBar(
        backgroundColor:   Color(0xff026c45),
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
        title: Text('Tagebuch Eintrag'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              OtherBody(),
              SizedBox(height: 0,),
              UploadImageWidget(
                urlpre: uploadImagevideoUrl,
                text:'Foto/Video hochladen',
                onUpdate: onUpdateImage,
                icons: Icons.camera_alt_outlined,
                widgetType: WidgetType.ImageType,
              ),
              SizedBox(height: 10,),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonRound(buttonText: 'Speichern', function:  (){
                   if(title!=null && title.text!=''){
                     onSave();
                   }else{
                     EasyLoading.showToast('Bitte geben Sie den Tagebuchtitel ein.',toastPosition: EasyLoadingToastPosition.bottom);

                   }
                  },
                  buttonColor:   Color(0xff026c45),)),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Titel',hintTitle: 'Enter the title',controller: title,type: TextInputType.text),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Startdatum',hintTitle: 'dd/mm/yyyy',controller: startdate,type: TextInputType.text,
            endingWidget: IconButton(
                icon: Icon(Icons.date_range),
                onPressed: (){
                  _selectDate(startdate);
                }
            ),),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Endtermin',hintTitle: 'dd/mm/yyyy',controller: enddate,type: TextInputType.text,
            endingWidget: IconButton(
                icon: Icon(Icons.date_range),
                onPressed: (){
                  _selectDate(enddate);
                }
            ),),
          SizedBox(height: 10,),
          TextFieldAppD(hintText: 'Beschreibung',hintTitle: 'Enter message here',controller: descriptionm,type: TextInputType.text,isDescription: true,),
          SizedBox(height: 10,),
          Text(' Tägliches Wetter',style: TextStyle(fontWeight: FontWeight.bold,color: LIGHT_BUTTON_COLOR),),
          SizedBox(height: 10,),
          ToggleSwitch(
            initialLabelIndex: weather,
            totalSwitches: 4,
            minWidth: MediaQuery.of(context).size.width/4.6,
            activeBgColor: [  Color(0xff026c45)],
            labels: ['Sonne', 'Sonne', 'Regen','Regenbogen'],
            onToggle: (index) {
              setState(() {
                weather=index!;
              });
              print('switched to: $index');
            },
          ),
          SizedBox(height: 10,),
          Text(' Pferdestimmung',style: TextStyle(fontWeight: FontWeight.bold,color: LIGHT_BUTTON_COLOR),),
          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(child:  HorseMoodWidget(1)),
              Expanded(child:  HorseMoodWidget(2)),
              Expanded(child:  HorseMoodWidget(3)),
              Expanded(child:  HorseMoodWidget(4)),
              Expanded(child:  HorseMoodWidget(5)),
            ],
          ),
          SizedBox(height: 05,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 05),
                width: 50,
                child: Text('Schlecht'),
              ),
              Container(
                width: 50,
                child: Text('sehr gut'),
              )
            ],
          )
    ],
      ),
    );
  }

  Widget HorseMoodWidget(int mood){
    return InkWell(
      onTap: (){
        setState(() {
          moodValue=mood;
        });
      },
      child: Container(
        margin: EdgeInsets.only(left: 5,right: 5),
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(7)
          ),
          color: moodValue==mood ?Color(0xff026c45): Colors.white
        ),
        child: Container(
            height: 35,
            width: 35,
            child: Image.asset('assets/horseshoe.png')),
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
