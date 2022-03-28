import 'package:flutter/material.dart';
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
  DateTime _selectedDay=DateTime.now();
  DateTime _focusedDay=DateTime.now();
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
                  if (day.weekday == DateTime.sunday) {
                    return Container(
                      height: 40,
                      width: 40,
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
                  }
                },
              ),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // update `_focusedDay` here as well
                });
              },
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Schedule'),
                Container(
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
                )
              ],
            )
          ],
        ),
      ),
    );
  }


}
