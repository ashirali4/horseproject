import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:horseproject/src/pages/auth/into.dart';
import 'package:horseproject/src/pages/auth/login.dart';
import 'package:horseproject/src/pages/auth/signup.dart';
import 'package:horseproject/src/pages/dashboard/dashboard.dart';
import 'package:horseproject/src/pages/dashboard/inner_pages/add_horse.dart';
import 'package:horseproject/src/pages/dashboard/inner_pages/edit_profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Horse Riding',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: EasyLoading.init(),
      home: AddHorse(),
    );
  }
}
