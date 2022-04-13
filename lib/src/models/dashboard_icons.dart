import 'package:get/get.dart';
import 'package:horseproject/src/pages/dashboard/inner_pages/add_horse.dart';
import 'package:horseproject/src/pages/dashboard/inner_pages/contacts.dart';
import 'package:horseproject/src/pages/dashboard/inner_pages/edit_profile.dart';
import 'package:horseproject/src/pages/dashboard/inner_pages/health.dart';
import 'package:horseproject/src/pages/dashboard/inner_pages/insurance.dart';
import 'package:horseproject/src/utlis/enums.dart';

import '../pages/dashboard/inner_pages/bodyvalue.dart';
import '../pages/dashboard/inner_pages/diary.dart';
import '../pages/dashboard/inner_pages/horses_list.dart';
import '../pages/others/calendar.dart';

class DashboardIcons{
  String name;
  String iconname;
  Function onPress;
  DashboardIcons(this.name,this.iconname,this.onPress);
}

List<DashboardIcons> Dashboard_Icons_List=[
  DashboardIcons('Eigentümer', 'assets/owner.png',(){
    Get.to(EditProfile());
  }),
  DashboardIcons('Pferd', 'assets/horse.png',(){
    Get.to(HorseList(type: ListType.Horse,));
  }),
  DashboardIcons('Tagebuch', 'assets/diary.png',(){
    Get.to(DiaryHorse());
  }),
  // DashboardIcons('Contacts', 'assets/contacts.png',(){
  //   Get.to(ContactHorse());
  // }),
  DashboardIcons('Gesundheit', 'assets/health.png',(){
    Get.to(HorseList(type: ListType.Health,));
  }),
  DashboardIcons('Versicherung', 'assets/insurance.png',(){
    Get.to(HorseList(type: ListType.Insurance,));
  }),
  // DashboardIcons('Calenar', 'assets/calendar.png',(){
  //   Get.to(CalendarValue());
  // }),
  // DashboardIcons('Body Value', 'assets/heart.png',(){
  //   Get.to(BodyValue());
  // }),
];