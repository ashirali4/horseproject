import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horseproject/src/pages/others/qr_page.dart';

import '../../../utlis/constants.dart';
import '../../../utlis/enums.dart';
import 'add_horse.dart';
class HorseList extends StatefulWidget {
  const HorseList({Key? key}) : super(key: key);

  @override
  _HorseListState createState() => _HorseListState();
}

class _HorseListState extends State<HorseList> {
  var usersQuery = FirebaseFirestore.instance
      .collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('horses');

  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: BACKGROUND_COLOR_DASHBOARD,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
        title: Text('Your Horses'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        child:  listViewBuilder(),

      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  QRScan()),
          );
        },
        label: const Text('Add Horse'),
        icon: const Icon(Icons.add),
        backgroundColor: BACKGROUND_COLOR_DASHBOARD,
      ),
    );
  }

  Widget StaticView(IconData icon, var user,String id) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => AddHorse(data: [user['name']], pageType: HorseEditType.EditHorse)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 10,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(08)),
            color: Colors.white),
        child: Padding(
            padding:
            const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset("assets/horsep.svg",height: 40,width: 40,color: BACKGROUND_COLOR_DASHBOARD,),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user['name'],
                                      style: GoogleFonts.raleway(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 05,
                                    ),
                                    Text(
                                     "Purchased: "+ user['pdate'],
                                      style: GoogleFonts.raleway(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),

                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget listViewBuilder() {
    return FirestoreListView<Map<String, dynamic>>(
      query: usersQuery,
      pageSize: 10,
      // query: hospitalsQuery,
      physics: BouncingScrollPhysics(),
      errorBuilder: (context, error, stackTrace) {
        return Text('asfda' + error.toString(),
            style: GoogleFonts.poppins(color: Colors.black));
      },
      itemBuilder: (context, snapshot) {
        Map<String, dynamic> user = snapshot.data();
        print("asd" + snapshot.toString());
        return StaticView(Icons.edit, user,snapshot.id.toString());
      },
    );
  }


}
