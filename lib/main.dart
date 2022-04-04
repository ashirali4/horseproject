import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:horseproject/src/pages/auth/into.dart';
import 'package:horseproject/src/pages/auth/login.dart';
import 'package:horseproject/src/pages/auth/signup.dart';
import 'package:horseproject/src/pages/dashboard/dashboard.dart';
import 'package:horseproject/src/pages/dashboard/inner_pages/add_horse.dart';
import 'package:horseproject/src/pages/dashboard/inner_pages/contacts.dart';
import 'package:horseproject/src/pages/dashboard/inner_pages/edit_profile.dart';
import 'package:horseproject/src/pages/dashboard/inner_pages/health.dart';
import 'package:horseproject/src/pages/dashboard/inner_pages/insurance.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Horse Riding',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: EasyLoading.init(),
      home: FirebaseAuth.instance.currentUser!=null ? Dashboard() : IntroMobileApp(),
    );
  }
}
