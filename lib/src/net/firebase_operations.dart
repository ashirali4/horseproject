import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('users');
final CollectionReference _mainCollectionIns = _firestore.collection('ins');

final CollectionReference _mainCollectionQuestions = _firestore.collection('requirements');
final CollectionReference _mainusersCollection = _firestore.collection('users');
final CollectionReference horsescol = _firestore.collection('users');
final CollectionReference horsecontacts = _firestore.collection('contacts');

class FirebaseDB {

  static Future<String> addUsersSignup({
    required String firstname,
    required String lastname,
    required String country,
    required String phone,
    required String email
  }) async {

    String status='Failed to Register User';
    DocumentReference documentReferencer =
    _mainusersCollection.doc(FirebaseAuth.instance.currentUser!.uid);

    Map<String, dynamic> data = <String, dynamic>{
      "firstName": firstname,
      "lastName" : lastname,
      "country" : country,
      "phone" : phone,
      "email" : email,
      "address" : "",
      "zip" : "",
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => status='User Registered Successfully')
        .catchError((e) => status=e.toString());
    return status;
  }



  static Future<String> saveHorse({
    required String name,
    required String gender,
    required String race,
    required String dob,
    required String ccolor,
    required String smark,
    required String pdate,
    required String pnumber,
    required String mnumber,
    required String lnumber,
  }) async {

    String status='Failed to Save Horse';
    DocumentReference documentReferencer =
    horsescol.doc(FirebaseAuth.instance.currentUser!.uid).collection('horses').doc(name);

    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "gender" : gender,
      "race" : race,
      "dob" : dob,
      "ccolor" : ccolor,
      "smark" : smark,
      "pdate" : pdate,
      "pnumber" : pnumber,
      "mnumber" : mnumber,
      "lnumber" : lnumber,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => status='Save Horse Successfully')
        .catchError((e) => status=e.toString());
    return status;
  }


  static Future<String> savedata({
    required var data,
    required String type
  }) async {

    String status='Failed to Save Horse';
    try{
      DocumentReference documentReferencer =
      _firestore.collection(type).doc(FirebaseAuth.instance.currentUser!.uid);

      await documentReferencer
          .set(data)
          .whenComplete(() => status='Save Contacts Successfully')
          .catchError((e) => status=e.toString());
      print(status+"a asdfasd");
    }catch(e){
      print("Print - > "+status.toString());
    }
    return status;
  }


  static Future<String> savedatatousers({
    required var data,
    required String type
  }) async {

    String status='Failed to Save Horse';
    try{
      DocumentReference documentReferencer =
      _firestore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection(type).doc();

      await documentReferencer
          .set(data)
          .whenComplete(() => status='Save Contacts Successfully')
          .catchError((e) => status=e.toString());
      print(status+"a asdfasd");
    }catch(e){
      print("Print - > "+status.toString());
    }
    return status;
  }


  static Future<String> editQuestion({
    required String questionpart,
    required String questionheading,
    required String questiondesc,
    required String number,
    required String qid,
    required List<dynamic> checkList
  }) async {
    bool isCheckList=false;

    if(checkList.length>0){
      isCheckList=true;
    }
    print(qid.toString() + "questionsss part");
    String status='Failed to Edit Questions';
    DocumentReference documentReferencer =
    _mainCollectionQuestions.doc(questionpart).collection('section_questions').doc(qid);

    Map<String, dynamic> data = <String, dynamic>{
      "p_heading": questionheading,
      "p_desc" : questiondesc,
      "p_id" : documentReferencer.id,
      "index" : int.parse(number),
      "isCheckList" : isCheckList,
      "checkList" : checkList
    };


    await documentReferencer
        .set(data)
        .whenComplete(() => status='Question Added!')
        .catchError((e) => status=e.toString());

    return status;
  }







  static Future<String> userAchievementStatusUpdate({
    required String statuse,
    required String part,
    required String questionid
  }) async {
    var userid=FirebaseAuth.instance.currentUser?.uid;
    String status='Failed to Add Questions';
    DocumentReference documentReferencer =
    _mainCollectionQuestions.doc(part).collection('section_questions').doc(questionid).collection('users').doc(userid);

    Map<String, dynamic> data = <String, dynamic>{
      "status": statuse,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print('Status Update!'))
        .catchError((e) => print(e.toString()));
    return status;
  }


  static Future<void> updateProfile({
    required String name,
    required String bio,
    required String profile,
    required String userUid
  }) async {

    DocumentReference documentReferencer =
    _mainCollection.doc(userUid);

    Map<String, dynamic> data = <String, dynamic> {
      "name" : name,
      "bio" : bio,
      "profile_image" : profile
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }





  static Future<void> updateStatus({
    required String status,
    required String userUid,
    required String sectionId,
    required String questionId,
    required int index

  }) async {

    DocumentReference documentReferencer =
    _mainCollection.doc(userUid).collection('p'+(int.parse(sectionId)+1).toString()).doc(questionId);

    Map<String, dynamic> data = <String, dynamic>{
      "status": status,
      "id":questionId,
      "index" : index
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }


  static Future<bool> getUserRole(String currentRole,String id) async {
    bool status=false;
    if(currentRole=='ins'){
      var document = await FirebaseFirestore.instance.collection('ins').doc(id).get();
      if(document['role']==currentRole){
        status=true;
      }
    }else{
      var document = await FirebaseFirestore.instance.collection('users').doc(id).get();
      if(document['role']==currentRole){
        status=true;
      }
    }
    return status;
  }



  static Future<void> updateCheckBox({
    required String partid,
    required String questionId,
    required int index,
    required bool status,
    required List<dynamic> listStatus

  }) async {
    List<dynamic> copied = listStatus.toList();
    copied[index]=status;
    DocumentReference documentReferencer =
    _mainCollection.doc(FirebaseAuth.instance.currentUser!.uid).collection(partid).doc(questionId);

    Map<String, dynamic> data = <String, dynamic>{
      "checkList": copied,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }




  static Future<List<dynamic>> getDocumentData () async {
    CollectionReference _cat = FirebaseFirestore.instance.collection("users");
    QuerySnapshot querySnapshot = await _cat.get();
    final _docData = querySnapshot.docs.map((doc) => jsonEncode(doc.data())).toList();
    return _docData;
    // do any further processing as you want
  }



  static Future<bool> registerStudents(String inst,String name, String email,String password,int enrolledIn,bool isEdit,String id) async {
    var usereCreated=false;
    String part='p1';
    if(enrolledIn==1){
      part='p2';
    }else if(enrolledIn==2){
      part='p3';
    }else if(enrolledIn==3){
      part='p4';
    }
    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "email" : email,
      "enrolled": enrolledIn,
      "role" : 'student',
      "instructor" : inst,
      "time" : DateTime.now().toString()
    };


    FirebaseApp app = await Firebase.initializeApp(
        name: 'Secondary', options: Firebase.app().options);


    if(isEdit){
      DocumentReference documentReferencer =
      _mainCollection.doc(id);
      await documentReferencer
          .update(data)
          .whenComplete(() => usereCreated=true)
          .catchError((e) => usereCreated=false);
      EasyLoading.showToast('Student has been Updated',
        toastPosition: EasyLoadingToastPosition.bottom,);
      assignQuestions(part,id);

    }else{

      try {
        UserCredential userCredential = await FirebaseAuth.instanceFor(app: app)
            .createUserWithEmailAndPassword(email: email, password: password);
        DocumentReference documentReferencer =
        _mainCollection.doc(userCredential.user!.uid);
        await documentReferencer
            .set(data)
            .whenComplete(() => usereCreated=true)
            .catchError((e) => usereCreated=false);
        EasyLoading.showToast('Student has been Added',
          toastPosition: EasyLoadingToastPosition.bottom,);
        assignQuestions(part,userCredential.user!.uid);
      }


      on FirebaseAuthException catch (e) {
        // Do something with exception. This try/catch is here to make sure
        // that even if the user creation fails, app.delete() runs, if is not,
        // next time Firebase.initializeApp() will fail as the previous one was
        // not deleted.
      }


    }



    await app.delete();
    return Future.sync(() => usereCreated);
  }


  static Future<bool> registerInstructors(String name, String email,String password,bool isEdit,String id) async {
    var usereCreated=false;
    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "email" : email,
      "role" : 'ins'
    };
    FirebaseApp app = await Firebase.initializeApp(
        name: 'thirdy', options: Firebase.app().options);


    if(isEdit){
      DocumentReference documentReferencer =
      _mainCollectionIns.doc(id);
      await documentReferencer
          .update(data)
          .whenComplete(() => usereCreated=true)
          .catchError((e) => usereCreated=false);
      EasyLoading.showToast('Instructor has been Updated',
        toastPosition: EasyLoadingToastPosition.bottom,);
    }else{

      try {
        UserCredential userCredential = await FirebaseAuth.instanceFor(app: app)
            .createUserWithEmailAndPassword(email: email, password: password);
        DocumentReference documentReferencer =
        _mainCollectionIns.doc(userCredential.user!.uid);
        await documentReferencer
            .set(data)
            .whenComplete(() => usereCreated=true)
            .catchError((e) => usereCreated=false);
        EasyLoading.showToast('Instructor has been Added',
          toastPosition: EasyLoadingToastPosition.bottom,);
      }
      on FirebaseAuthException catch (e) {
        // Do something with exception. This try/catch is here to make sure
        // that even if the user creation fails, app.delete() runs, if is not,
        // next time Firebase.initializeApp() will fail as the previous one was
        // not deleted.
      }


    }



    await app.delete();
    return Future.sync(() => usereCreated);
  }


  static Future<bool> deleteUser(String id,String type) async {
    var usereCreated=false;
    DocumentReference documentReferencer =
    _firestore.collection(type).doc(id);
    await documentReferencer
        .delete()
        .whenComplete(() => usereCreated=true)
        .catchError((e) => usereCreated=false);
    EasyLoading.showToast('Deleted Successfully',
      toastPosition: EasyLoadingToastPosition.bottom,);
    return Future.sync(() => usereCreated);
  }


  static Future<bool> deleteRequirement(String id,String type) async {
    var usereCreated=false;
    DocumentReference documentReferencer =
    _firestore.collection('requirements').doc(type).collection('section_questions').doc(id);
    await documentReferencer
        .delete()
        .whenComplete(() => usereCreated=true)
        .catchError((e) => usereCreated=false);
    EasyLoading.showToast('Deleted Successfully',
      toastPosition: EasyLoadingToastPosition.bottom,);
    return Future.sync(() => usereCreated);
  }



  static Future<bool> assignQuestions(String partId,String userId) async {
    print("Question part " + partId + "with id" + userId.toString());
    await for (var messages in _firestore.collection('requirements').doc(partId).collection('section_questions').snapshots())
    {

      for (var message in messages.docs.toList()) {
        List<dynamic> myList=[];
        if(message.data()['isCheckList']){
          myList= List<dynamic>.generate( message.data()['checkList'].length,(counter) => false);
        }
        DocumentReference documentReferencer =
        _mainCollection.doc(userId).collection(partId).doc(message.id.toString());
        Map<String, dynamic> data = <String, dynamic>{
          "status" : 'not_started',
          "index" :message.data()['index'],
          "isCheckList" : message.data()['isCheckList'],
          "checkList" :  myList
        };
        await documentReferencer.set(data).whenComplete(() => 'asdf').catchError((e) => 'sdf');
      }
    }
    return Future.sync(() => true);
  }



  static Future<dynamic> getDropdownUserList() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _firestore.collection('ins').get();;

    // Get data from docs and convert map to List
    List<String> allData = querySnapshot.docs.map((doc) => jsonEncode(doc.data())).toList();
    // //for a specific field
    // final allData =
    // querySnapshot.docs.map((doc) => doc.get('fieldName')).toList();
    print(allData.toString());
    return jsonEncode(allData);
  }

  static Future<dynamic> getUsersInfo() async {
    var a = await FirebaseFirestore.instance
        .collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    var hasdoc ={
      'firstName' : a['firstName'] ?? '',
      'lastName' : a['lastName'] ?? '',
      'country' : a['country'] ?? '',
      'phone' : a['phone'] ?? '',
      'email' : a['email'] ?? '',
      'address' : a['address'] ?? '',
      'zip' : a['zip'] ?? '',
    };
    return jsonEncode(hasdoc);
  }



  static Future<dynamic> gethorseData(String name) async {
    var hasdoc;
    try{
      var a = await FirebaseFirestore.instance
          .collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection('horses').doc(name).get();
      hasdoc ={
        'name' : a['name'] ?? '',
        'gender' : a['gender'] ?? '',
        'race' : a['race'] ?? '',
        'ccolor' : a['ccolor'] ?? '',
        'dob' : a['dob'] ?? '',
        'smark' : a['smark'] ?? '',
        'pdate' : a['pdate'] ?? '',
        'pnumber' : a['pnumber'] ?? '',
        'mnumber' : a['mnumber'] ?? '',
        'lnumber' : a['lnumber'] ?? '',
      };
    }catch(e){
      print("ERROR" +e.toString());
    }
    return jsonEncode(hasdoc);
  }

  static Future<dynamic> getDataMap(String type) async {
    var data= await FirebaseFirestore.instance
        .collection(type).doc(FirebaseAuth.instance.currentUser!.uid).get();
    return data;
  }



  static Future<bool> checkIfDocExists(String docId) async {
    try {
      // Get reference to Firestore collection
      var a = await FirebaseFirestore.instance
          .collection("users").doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('horses').doc(docId)
          .get();
      return a.exists;
    } catch (e) {
      throw "Print Errorrrr "+e.toString();
    }
  }
}
