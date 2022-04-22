import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horseproject/src/pages/dashboard/inner_pages/insurance.dart';
import 'package:horseproject/src/pages/others/qr_page.dart';

import '../../../net/firebase_operations.dart';
import '../../../utlis/constants.dart';
import '../../../utlis/enums.dart';
import 'add_horse.dart';
import 'health.dart';

class HorseList extends StatefulWidget {
  final ListType type;
  const HorseList({Key? key,required this.type}) : super(key: key);

  @override
  _HorseListState createState() => _HorseListState();
}

class _HorseListState extends State<HorseList> {
  var usersQuery = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('horses');
  String ScafoldTitle = 'Deine Pferde';
  Color screenColor = Colors.deepOrange;


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
        FirebaseDB.deleteHorse(weightid: id);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Pferd löschen?"),
      content: Text("Bist Du sicher, dass Du das Pferd löschen willst?"),
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
    if(widget.type==ListType.Health){
       ScafoldTitle = 'Pferdegesundheit';
       screenColor= Colors.green;
    }else if(widget.type==ListType.Insurance){
       ScafoldTitle = 'Horses Insurance';
       screenColor= Colors.deepPurple;

    }
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
                    screenColor.withOpacity(.1),
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
            backgroundColor: screenColor,
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
          floatingActionButton: widget.type == ListType.Horse ? FloatingActionButton.extended(
            onPressed: () {
               Navigator.push(
                 context,
                 MaterialPageRoute(
                     builder: (context) => AddHorse(
                         data: [], pageType: HorseEditType.SimpleAddHorse)),
               );
            },
            label: const Text('Pferd hinzufügen'),
            icon: const Icon(Icons.add),
            backgroundColor: screenColor,
          ) : SizedBox.shrink(),
        )
      ],
    );
  }

  Widget StaticView(IconData icon, var user, String id) {
    return InkWell(
      onTap: () {
        if(widget.type==ListType.Horse){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => AddHorse(
                      data: [user['name']], pageType: HorseEditType.EditHorse)));
        }else if(widget.type==ListType.Health){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Health(horseID: user['name'],horseImage:user['imageurl'],)),
          );
        }else if(widget.type==ListType.Insurance){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Insurance(horseID: user['name'],horseImage:user['imageurl'],)),
          );
        }
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
                                  "assets/horsep.svg",
                                  height: 40,
                                  width: 40,
                                  color: screenColor,
                                ),
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
                                    // Text(
                                    //   "Purchase Date : " + user['pdate'],
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
               widget.type==ListType.Horse? IconButton(
                   onPressed: () {
                     showAlertDialog(context, id);
                   },
                   icon: Icon(Icons.delete)):SizedBox.shrink()
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
