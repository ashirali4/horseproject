import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../utlis/constants.dart';
import '../../widgets/button_round.dart';

class QRScan extends StatefulWidget {
  const QRScan({Key? key}) : super(key: key);

  @override
  _QRScanState createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   AppBar(
        backgroundColor: BACKGROUND_COLOR_DASHBOARD,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
        title: Text('Scan QR Code'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Place qr code inside the frame to scan please avoid shake to get result quickly',style: TextStyle(fontWeight: FontWeight.w500,color: LIGHT_BUTTON_COLOR),textAlign: TextAlign.center,),
            SizedBox(height: 20,),
            Image.asset('assets/qrscan.png'),
            SizedBox(height: 40,),
            Container(
                width: MediaQuery.of(context).size.width,
                child: ButtonRound(buttonText: 'Scan QR Code', function: (){},)),

          ],
        ),
      ),
    );
  }


}
