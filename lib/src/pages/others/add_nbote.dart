import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:horseproject/src/net/firebase_operations.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../utlis/constants.dart';
import '../../widgets/button_round.dart';
import '../../widgets/textfield.dart';
class AddNotes extends StatefulWidget {
  final String date;
  const AddNotes({Key? key,required this.date}) : super(key: key);

  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {

  TextEditingController name=TextEditingController();
  TextEditingController notedesc=TextEditingController();
  String time='';
  String color='green';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BACKGROUND_COLOR_DASHBOARD,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
        title: Text('Add Note'),
        centerTitle: true,
      ),
      floatingActionButton:   Container(
        margin: EdgeInsets.only(left: 20,right: 20,bottom: 20),
          width: MediaQuery.of(context).size.width,
          child: ButtonRound(
            buttonText: 'Add Note',
            function: () {
              onSave();
            },
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              TimePicker(),
              SizedBox(height: 10,),
              TextFieldApp(hintText: 'Title',hintTitle: 'Note heading',controller: name,type: TextInputType.text),
              SizedBox(height: 10,),
              TextFieldApp(hintText: 'Description',hintTitle: 'Note description',controller: notedesc,type: TextInputType.text),
              SizedBox(height: 10,),
              Text('Priority',style: TextStyle(fontSize: 15),),
              SizedBox(height: 10,),
              ToggleSwitch(
                initialLabelIndex: 0,
                totalSwitches:3,
                minWidth: MediaQuery.of(context).size.width/3.4,
                activeBgColors: [[Colors.green],
                  [Colors.blue],
                  [Colors.orange]],
                labels: ['Green', 'Blue', 'Orange'],
                onToggle: (index) {
                  if(index==0){
                    color='green';
                  }else if(index==1){
                    color='blue';
                  }else if(index==2){
                    color='orange';
                  }
                },
              ),
              SizedBox(height: 20,),

            ],
          ),
        ),
      ),
    );
  }

  Widget TimePicker() {
    return InkWell(
      onTap: () async {
        TimeRange result = await showTimeRangePicker(
          context: context,
        );
        setState(() {
          time = result.startTime.format(context).toString() + " - "+ result.endTime.format(context).toString();

        });
       print(time);
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
              Icons.timelapse,
              color: Colors.red,
            ),
            SizedBox(
              width: 3,
            ),
            Text(
             time==""? 'Choose Time': time,
              style: TextStyle(),
            )
          ],
        ),
      ),
    );
  }

  Future<void> onSave() async {
    Map<String, dynamic> data = <String, dynamic>{
      "heading": name.text,
      "description" : notedesc.text,
      "color" : color,
      "time" : time,
      "date" : widget.date,
    };
    await FirebaseDB.savedatatousers(data: data, type: 'notes');
    EasyLoading.showToast('Notes has been Added.',toastPosition: EasyLoadingToastPosition.bottom);
    Navigator.pop(context);
  }
}
