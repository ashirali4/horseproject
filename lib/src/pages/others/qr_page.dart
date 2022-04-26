import 'package:flutter/material.dart';
import 'package:horseproject/src/utlis/enums.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../utlis/constants.dart';
import '../../widgets/button_round.dart';
import '../dashboard/inner_pages/add_horse.dart';

class QRScan extends StatefulWidget {
  const QRScan({Key? key}) : super(key: key);

  @override
  _QRScanState createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  int value=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   AppBar(
        backgroundColor: BACKGROUND_COLOR_DASHBOARD,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
        title: Text('Scanne QR Code'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20,right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Platziere den QR-Code zum Scannen in den Rahmen',style: TextStyle(fontWeight: FontWeight.w500,color: LIGHT_BUTTON_COLOR),textAlign: TextAlign.center,),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 300,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),
              ),
            ),
          //  Image.asset('assets/qrscan.png'),
            SizedBox(height: 40,),

            // Container(
            //     width: MediaQuery.of(context).size.width,
            //     child: ButtonRound(buttonText: 'Scan QR Code', function: (){
            //       _onQRViewCreated(controller!);
            //     },)),

          ],
        ),
      ),
    );
  }

  //Danny Dorner:Snoopy:450:170:03.04.2022:654321
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if(scanData.code!.contains(':')){
        if(value==0){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddHorse(data: scanData.code!.split(":"),pageType: HorseEditType.AddHorse,)));
          value++;
        }
      }
    });
  }
}
