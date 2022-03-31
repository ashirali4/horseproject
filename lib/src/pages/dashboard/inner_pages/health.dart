import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../net/firebase_operations.dart';
import '../../../utlis/constants.dart';
import '../../../widgets/button_round.dart';
import '../../../widgets/calendar_theme.dart';
import '../../../widgets/textfield.dart';

class Health extends StatefulWidget {
  const Health({Key? key}) : super(key: key);

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


  onSave() async {
    Map<String, dynamic> data = <String, dynamic>{
      "name": name.text,
      "allergies" : alergies.text,
      "blood" : btype.text,
      "medicine" : med.text
    };

    dataDate.forEach((key, value) {
      data[key]=value;
    });
    await FirebaseDB.savedata(data: data,type: 'health');
    EasyLoading.showToast('Health data has been updated.',toastPosition: EasyLoadingToastPosition.bottom);
  }

  onGetData() async {
    try{
      var data= await FirebaseDB.getDataMap('health');
      dataDate.forEach((key, value) {
        dataDate[key]=data[key];
      });
      setState(() {
        name.text=data['name'] ?? '';
        alergies.text=data['allergies'] ?? '';
        btype.text=data['blood'] ?? '';
        med.text=data['medicine'] ?? '';
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
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        dataDate[text] = picked.toString().substring(0, 10);
      });
    }
  }

  @override
  void initState() {
    onGetData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BACKGROUND_COLOR_DASHBOARD,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40))),
        title: Text('Health'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ImageWidget('Upload Photo/Video', Icons.camera_alt_outlined),
              SizedBox(
                height: 10,
              ),
              OtherBody('Liability'),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonRound(
                    buttonText: 'Save Health',
                    function: () {
                      onSave();
                    },
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
            hintText: 'Name of Horse',
            hintTitle: 'Black Horse',
            controller: name,
          ),
          SizedBox(
            height: 10,
          ),
          TextFieldApp(
            hintText: 'Alergiers',
            hintTitle: 'Name of Allergies',
            controller: alergies,
          ),
          SizedBox(
            height: 10,
          ),
          TextFieldApp(
            hintText: 'Blood Type',
            hintTitle: 'Blood group',
            controller: btype,
          ),
          SizedBox(
            height: 10,
          ),
          TextFieldApp(
            hintText: 'Medicine',
            hintTitle: 'Name of Medicine',
            controller: med,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Vaccination',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          healthDateBox('Equine Flu', 'equine_start_date', 'equine_last_date'),
          healthDateBox('Herpes', 'herpes_start_date', 'herpes_last_date'),
          healthDateBox('Druse', 'druse_start_date', 'druse_last_date'),
          healthDateBox('Rabies', 'rabies_start_date', 'rabies_last_date'),
          healthDateBox('Borreliosis', 'borr_start_date', 'borr_last_date'),
          Text(
            'Anthelmintic Therapy',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          healthDateBox('Therapy', 'therpay_start_date', 'therpay_last_date'),
          Text(
            'Farrier',
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
                  child: DateBox('Last Date', () {
                _selectDate(startDate.toString());
              }, startDate)),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: DateBox('Next Date', () {
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
            border: Border.all(width: 1, color: Colors.red),
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
