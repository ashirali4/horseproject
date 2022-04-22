import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutterfire_ui/i10n.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:horseproject/src/pages/auth/into.dart';
import 'package:horseproject/src/pages/auth/login.dart';
import 'package:horseproject/src/pages/dashboard/dashboard.dart';
import 'package:horseproject/src/utlis/constants.dart';
import 'package:horseproject/src/widgets/button_round.dart';
import 'package:horseproject/src/widgets/privacy.dart';
import 'package:intl/intl.dart';



final DateFormat formatter = DateFormat('dd.MM.yyyy');


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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('de')
      ],
      builder: EasyLoading.init(),
      home: FirebaseAuth.instance.currentUser!=null ? Dashboard() : IntroMobileApp(),
    );
  }
}


