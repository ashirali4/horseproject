import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horseproject/src/pages/others/add_nbote.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../utlis/constants.dart';
import '../../widgets/button_round.dart';

class CalendarValue extends StatefulWidget {
  const CalendarValue({Key? key}) : super(key: key);

  @override
  _CalendarValueState createState() => _CalendarValueState();
}

class _CalendarValueState extends State<CalendarValue> {
  DateTime _selectedDay=DateTime.now().subtract(Duration(days: 1));
  DateTime _focusedDay=DateTime.now().subtract(Duration(days: 1));
  var usersQuery = FirebaseFirestore.instance
      .collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('notes').where('date'
      ,isEqualTo: DateTime.now().subtract(Duration(days: 1)).toString().substring(0,10));

  onUpdate(){
    usersQuery = FirebaseFirestore.instance
        .collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('notes').where('date'
        ,isEqualTo: _focusedDay.toString().substring(0,10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   AppBar(
        backgroundColor: BACKGROUND_COLOR_DASHBOARD,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
        title: Text('Calendar'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _selectedDay,

              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              calendarBuilders: CalendarBuilders(
                selectedBuilder: (context, day,focusdsay) {
                  return Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(
                            Radius.circular(5)
                        )
                    ),
                    child: Center(
                      child: Text(day.day.toString(),style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                  );
                },
                todayBuilder: (context, day,focusdsay){
                  return Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        color: Colors.red.withOpacity(.8),
                        borderRadius: BorderRadius.all(
                            Radius.circular(50)
                        )
                    ),
                    child: Center(
                      child: Text(day.day.toString(),style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                  );
                }
              ),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // update `_focusedDay` here as well
                });
                onUpdate();
              },
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Schedule'),
                InkWell(
                  onTap: (){
                    Get.to(AddNotes(date: _focusedDay.toString().substring(0,10),));
                  },
                  child: Container(
                    height: 40,
                    width: 130,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(
                            Radius.circular(5)
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add,color: Colors.white,),
                        Text('Add Notes',style: TextStyle(
                          color: Colors.white
                        ),)
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20,),
            Expanded(
              child: FirestoreListView<Map<String, dynamic>>(
                query: usersQuery,
                pageSize: 10,
                physics: BouncingScrollPhysics(),
                errorBuilder: (context, error, stackTrace) {
                  return Container();
                },
                itemBuilder: (context, snapshot) {
                  Map<String, dynamic> user = snapshot.data();
                  return StaticView( user,snapshot.id.toString());
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget StaticView(var user,String id) {
    Color mycolor=Colors.green;
    if(user['color']=='orange') {
      mycolor=Colors.orange;
    }else if(user['color']=='blue'){
      mycolor=Colors.blue;
    }

    return InkWell(
      onTap: () {
      },
      child: Container(
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
            color: mycolor),
        child: Padding(
            padding:
            const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.task,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user['heading'],
                                      style: GoogleFonts.raleway(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 05,
                                    ),
                                    Text(
                                        user['description'],
                                      style: GoogleFonts.raleway(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      user['time'],
                                      style: GoogleFonts.raleway(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),

                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }


}
