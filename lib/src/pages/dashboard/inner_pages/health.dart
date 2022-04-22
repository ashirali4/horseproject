import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../main.dart';
import '../../../net/firebase_operations.dart';
import '../../../utlis/constants.dart';
import '../../../utlis/enums.dart';
import '../../../widgets/button_round.dart';
import '../../../widgets/calendar_theme.dart';
import '../../../widgets/image_widget.dart';
import '../../../widgets/textfield.dart';

class Health extends StatefulWidget {
  final String horseID;
  final String horseImage;
  const Health({Key? key,required this.horseID,required this.horseImage}) : super(key: key);

  @override
  _HealthState createState() => _HealthState();
}

class _HealthState extends State<Health> {
  TextEditingController name = TextEditingController();
  TextEditingController alergies = TextEditingController();
  TextEditingController btype = TextEditingController();
  TextEditingController med = TextEditingController();
  Map<String, String> dataDate = {
    'equine_start_date': '',
    'equine_last_date': '',
    'herpes_start_date': '',
    'herpes_last_date': '',
    'druse_start_date': '',
    'druse_last_date': '',
    'rabies_start_date': '',
    'rabies_last_date': '',
    'borr_start_date': '',
    'borr_last_date': '',
    'therpay_start_date': '',
    'therpay_last_date': '',
    'farrier_start_date': '',
    'farrier_last_date': '',
  };

  TextEditingController text1 = TextEditingController();
  TextEditingController text2 = TextEditingController();



  onSave() async {
    Map<String, dynamic> data = <String, dynamic>{
      "name": name.text,
      "allergies" : alergies.text,
      "blood" : btype.text,
      "medicine" : med.text,
      "text1" : text1.text,
      "text2" : text2.text,
    };

    dataDate.forEach((key, value) {
      data[key]=value;
    });
    await FirebaseDB.savedataNew(data: data,type: 'health',horseId: widget.horseID);
    EasyLoading.showToast('Gesundheitsdaten wurden aktualisiert.',toastPosition: EasyLoadingToastPosition.bottom);
  }

  onGetData() async {
    try{
      var data= await FirebaseDB.getDataMapNew('health',widget.horseID);
      dataDate.forEach((key, value) {
        dataDate[key]=data[key];
      });
      setState(() {
        name.text=data['name'] ?? '';
        alergies.text=data['allergies'] ?? '';
        btype.text=data['blood'] ?? '';
        med.text=data['medicine'] ?? '';
        text1.text=data['text1'] ?? '';
        text2.text=data['text2'] ?? '';
      });
    }catch (e){
      print("Erorr " + e.toString());
    }

  }


  Future<void> _selectDate(String text) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        builder: (context, child) {
          return CalendarTheme(
            child: child!,
          );
        },
        locale: const Locale("de", "DE"),
        initialDate: DateTime.now(),
        firstDate: DateTime(1995, 1),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        dataDate[text] = formatter.format(picked);
      });
    }
  }

  @override
  void initState() {
    name.text=widget.horseID;

    onGetData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40))),
        title: Text('Gesundheit'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              UploadImageWidget(
                urlpre: widget.horseImage,
                text:'',
                onUpdate: (){},
                icons: Icons.camera_alt_outlined,
                widgetType: WidgetType.ShowImage,
              ),
              SizedBox(
                height: 10,
              ),
              OtherBody('Haftung'),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonRound(
                    buttonText: 'Speichern',
                    function: () {
                      onSave();
                    },
                    buttonColor: Colors.green,
                  )),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget OtherBody(String text) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          TextFieldApp(
            hintText: 'Name des Pferdes',
            hintTitle: 'Black Horse',
            controller: name,
            type: TextInputType.text,
            isEnabled: false,
          ),
          SizedBox(
            height: 10,
          ),
          TextFieldApp(
            hintText: 'Allergien',
            hintTitle: 'Name of Allergies',
            controller: alergies,
              type: TextInputType.text
          ),
          SizedBox(
            height: 10,
          ),
          TextFieldApp(
            hintText: 'Blutgruppe',
            hintTitle: 'Blood group',
            controller: btype,
              type: TextInputType.text
          ),
          SizedBox(
            height: 10,
          ),
          TextFieldApp(
            hintText: 'Medikamente',
            hintTitle: 'Name of Medicine',
            controller: med,
              type: TextInputType.text
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Impfung',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          SizedBox(height: 10,),
          healthDateBox('Grippe', 'equine_start_date', 'equine_last_date'),
          healthDateBox('Herpes', 'herpes_start_date', 'herpes_last_date'),
          healthDateBox('Druse', 'druse_start_date', 'druse_last_date'),
          healthDateBox('Tollwut', 'rabies_start_date', 'rabies_last_date'),
          healthDateBox('Borreliose', 'borr_start_date', 'borr_last_date'),
          Text(
            'Wurmkur',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          healthDateBox('Therapy', 'therpay_start_date', 'therpay_last_date'),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Medikament',hintTitle: 'Medikament',controller: text1,type: TextInputType.text),
          SizedBox(height: 10,),
          TextFieldApp(hintText: 'Dosis',hintTitle: 'Dosis',controller: text2,type: TextInputType.text),
          SizedBox(height: 10,),

          Text(
            'Hufschmied',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          healthDateBox('', 'farrier_start_date', 'farrier_last_date'),
        ],
      ),
    );
  }

  Widget ImageWidget(String text, IconData icons) {
    return Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: BACKGROUND_COLOR_ADD_HORSE.withOpacity(.3),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        margin: EdgeInsets.only(top: 20, bottom: 20),
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
            SizedBox(
              height: 10,
            ),
            Text(
              text,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )
          ],
        ));
  }

  Widget healthDateBox(String text, String startDate, String nextDate) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ' ' + text,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: LIGHT_BUTTON_COLOR),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                  child: DateBox('Letztes Datum', () {
                _selectDate(startDate.toString());
              }, startDate)),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: DateBox('Nächstes Datum', () {
                _selectDate(nextDate.toString());
              }, nextDate)),
            ],
          )
        ],
      ),
    );
  }

  Widget DateBox(String text, Function onTap, String valuedate) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.green),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.date_range,
              color: Colors.black,
            ),
            SizedBox(
              width: 3,
            ),
            Text(
              dataDate[valuedate] == '' ? text : dataDate[valuedate].toString(),
              style: TextStyle(),
            )
          ],
        ),
      ),
    );
  }
}
