import 'dart:convert';
import 'dart:math';

import 'package:circular_widgets/circular_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:horseproject/src/pages/auth/into.dart';
import 'package:horseproject/src/utlis/constants.dart';

import '../../models/dashboard_icons.dart';
import '../../net/firebase_operations.dart';
import '../../widgets/button_round.dart';
import '../../widgets/single_circle_dashboard.dart';
import '../../widgets/textfield.dart';
import '../others/qr_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int length = 5;
  double innerSpacingDivider = 10;
  double radiusOfItemDivider = 5;
  double centerWidgetRadiusDivider = 3;
  String firstname='';
  String lastname= '';
  String country= '';
  String phone= '';
  String email = '';
  var userdata;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              BACKGROUND_COLOR_DASHBOARD,
              Colors.black,
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(3.5, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.decal),
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 25, right: 25,top: 60),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(),
              SizedBox(height: 30,),
              Text(' Kategorien',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700),),
              SizedBox(height: 05,),
              DashBoardCircle(),
              FooterBox(),
            ],
          ),
        ),
      ),
    );
  }

  
  Widget DashBoardCircle(){
    return  Container(
      height: 400,
      child: Column(
        children: <Widget>[
          //Wrap with Expanded for Layout Builder to work, since it requires bounded width and height
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                var smallestBoundary =
                min(constraints.maxHeight, constraints.maxWidth);
                return CircularWidgets(
                  itemsLength: length,
                  itemBuilder: (context, index) {
                    // Can be any widget, preferably a circle
                    return SingleCircle(
                      txt: Dashboard_Icons_List[index].iconname,
                      color: Colors.white,
                      txt2: Dashboard_Icons_List[index].name,
                      function: Dashboard_Icons_List[index].onPress,
                    );
                  },
                  innerSpacing: smallestBoundary / 12,
                  radiusOfItem: 110,
                  centerWidgetRadius: smallestBoundary /2.8,
                  centerWidgetBuilder: (context) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 30,left: 15,right: 15),
                      child: Image.asset('assets/myapplogo.png'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget TopBar(){
    return FutureBuilder(
      future: FirebaseDB.getUsersInfo(),
      builder: (BuildContext context, snapshot) {
        if(snapshot.hasData){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            userdata=  jsonDecode(snapshot.data.toString());
            firstname = userdata['firstName'] ?? '';
            lastname = userdata['lastName'] ?? '';

            return Row(
              children: [
                Expanded(child:  Container(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (BuildContext context) => IntroMobileApp()),
                              ModalRoute.withName('/')
                          );
                        },
                        child: Container(
                          height:50,
                          width: 50,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage('https://media.istockphoto.com/photos/the-owner-and-his-white-horse-are-preparing-to-ridestock-photo-picture-id1184153859?k=20&m=1184153859&s=612x612&w=0&h=NuURZXkBuCPhdj5SxKkmTG0MgOe18Pgv9I4Z-y9LzIc='),
                                  fit: BoxFit.cover
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              border: Border.all(color: Colors.white,width: 2)
                          ),
                        ),
                      ),
                      SizedBox(width: 15,),
                      Container(
                        height: 50,
                        padding: EdgeInsets.only(top: 05,bottom: 05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(firstname+' '+lastname,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                            Text('Horse Owner',style: TextStyle(color: Colors.white),)
                          ],
                        ),
                      )
                    ],
                  ),
                )),
                InkWell(
                  onTap: (){
                    Get.to(QRScan());
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(100))
                    ),
                    child: Icon(Icons.qr_code_outlined,color: Colors.red,),
                  ),
                )
              ],
            );
          }
        }else if (snapshot.hasError){
          return InkWell(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) => IntroMobileApp()),
                    ModalRoute.withName('/')
                );
              },
              child: Text('Refresh to Fetch'));
        }
        return Container();
      },
    );

  }

  Widget FooterBox(){
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      padding: EdgeInsets.only(top: 30,left: 30),
      height: 180,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        image: DecorationImage(
          image: AssetImage(
            'assets/footerbg.png',
          ),
          fit: BoxFit.cover
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Half Pad',style: TextStyle(color: Colors.black,fontSize: 35,fontWeight: FontWeight.bold),),
          SizedBox(height: 05,),
          Container(
              width:170,
              child: Text('Feugiat augue aliquam sodales.',style: TextStyle(color: Colors.black,fontSize: 15,),)),
          SizedBox(height: 10,),
          Container(
              width: 120,
              height: 30,
              child: ButtonRound(buttonText: 'Visit Shop',radius: 50, function:  (){},)),

        ],
      ),
    );
  }

}


