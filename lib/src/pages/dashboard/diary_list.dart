import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horseproject/src/pages/dashboard/inner_pages/insurance.dart';
import 'package:horseproject/src/pages/others/qr_page.dart';
import 'package:horseproject/src/utlis/enums.dart';

import '../../net/firebase_operations.dart';
import '../../utlis/constants.dart';
import 'inner_pages/diary.dart';


class DiaryList extends StatefulWidget {
  const DiaryList({Key? key}) : super(key: key);

  @override
  _DiaryListState createState() => _DiaryListState();
}

class _DiaryListState extends State<DiaryList> {
  var usersQuery = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('diary');
  String ScafoldTitle = 'Tagebuch';

  TextEditingController search = TextEditingController();

  showAlertDialog(BuildContext context, String id) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Absagen"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Löschen"),
      onPressed: () {
        FirebaseDB.deleteDiary(weightid: id);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Tagebuch löschen?"),
      content: Text("Sind Sie sicher, dass Sie löschen möchten?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/riding.jpg"), fit: BoxFit.cover)),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Color(0xff026c45).withOpacity(.7),
                    Colors.black,
                  ],
                  stops: [
                    0.0,
                    1.0
                  ])),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Color(0xff026c45),
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40))),
            title: Text(ScafoldTitle),
            centerTitle: true,
          ),
          body: Container(
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: listViewBuilder(),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DiaryHorse(type: DiaryType.Add,editId: '',)),
              );
            },
            label: const Text('Eintrag Hinzufügen'),
            icon: const Icon(Icons.add),
            backgroundColor: Color(0xff026c45),
          ),
        )
      ],
    );
  }

  Widget StaticView(IconData icon, var user, String id) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DiaryHorse(type: DiaryType.Edit,editId: id,)),
        );
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
                                SvgPicture.asset(
                                  "assets/diary.svg",
                                  height: 40,
                                  width: 40,
                                  color: Color(0xff026c45),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user['title'],
                                      style: GoogleFonts.raleway(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 05,
                                    ),
                                    // Text(
                                    //   "Purchase Date : " + user['description'],
                                    //   style: GoogleFonts.raleway(
                                    //     fontSize: 15,
                                    //     color: Colors.black,
                                    //     fontWeight: FontWeight.w600,
                                    //   ),
                                    // ),
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
               IconButton(
                    onPressed: () {
                      showAlertDialog(context, id);
                    },
                    icon: Icon(Icons.delete))
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
        return StaticView(Icons.edit, user, snapshot.id.toString());
      },
    );
  }
}
