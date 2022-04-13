import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async{
        if (!await launch('https://www.wirwiegendeinpferd.de/Shopservice/Datenschutz/')) throw 'Could not launch';
      },
      child:  Text('Datenschutzerklärung',style: TextStyle(
          color: Colors.black,
          decoration: TextDecoration.underline
      ),)
    );
  }
}
