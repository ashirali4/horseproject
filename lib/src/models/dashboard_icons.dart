import 'package:get/get.dart';
import 'package:horseproject/src/pages/dashboard/inner_pages/add_horse.dart';
import 'package:horseproject/src/pages/dashboard/inner_pages/contacts.dart';
import 'package:horseproject/src/pages/dashboard/inner_pages/edit_profile.dart';
import 'package:horseproject/src/pages/dashboard/inner_pages/health.dart';
import 'package:horseproject/src/pages/dashboard/inner_pages/insurance.dart';

import '../pages/dashboard/inner_pages/bodyvalue.dart';
import '../pages/dashboard/inner_pages/diary.dart';
import '../pages/others/calendar.dart';

class DashboardIcons{
  String name;
  String iconname;
  Function onPress;
  DashboardIcons(this.name,this.iconname,this.onPress);
}

List<DashboardIcons> Dashboard_Icons_List=[
  DashboardIcons('Owner', 'assets/owner.png',(){
    Get.to(EditProfile());
  }),
  DashboardIcons('Horse', 'assets/horse.png',(){
    Get.to(AddHorse(data: [],));
  }),
  DashboardIcons('Diary', 'assets/diary.png',(){
    Get.to(DiaryHorse());
  }),
  DashboardIcons('Contacts', 'assets/contacts.png',(){
    Get.to(ContactHorse());
  }),
  DashboardIcons('Health', 'assets/health.png',(){
    Get.to(Health());
  }),
  DashboardIcons('Insurance', 'assets/insurance.png',(){
    Get.to(Insurance());
  }),
  DashboardIcons('Calenar', 'assets/calendar.png',(){
    Get.to(CalendarValue());
  }),
  DashboardIcons('Body Value', 'assets/heart.png',(){
    Get.to(BodyValue());
  }),
];