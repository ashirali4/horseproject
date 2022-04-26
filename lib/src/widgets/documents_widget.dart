import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utlis/constants.dart';
import '../utlis/enums.dart';
class DocumentsWidget extends StatefulWidget {
  String text;
  IconData icons;
  Function onUpdate;
  List<dynamic> documents;
  DocumentsWidget({Key? key,required this.text,required this.icons,required this.onUpdate,required this.documents}) : super(key: key);
  @override
  State<DocumentsWidget> createState() =>  _DocumentsWidgetState();
}

class _DocumentsWidgetState extends State<DocumentsWidget> {

  FirebaseStorage storage = FirebaseStorage.instance;
  List<dynamic> currentDocuments=[];

  Future<void> _showPicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions:['pdf','docx','txt'],
    );
    if (result != null) {
      EasyLoading.show(status: 'loading...');
      File file = File(result.files.single.path.toString());
      String url = await uploadFile(file);
      EasyLoading.dismiss();
      setState(() {
        currentDocuments.add(url);
      });
      widget.onUpdate(currentDocuments);
    } else {
      // User canceled the picker
    }
  }

  Future<String> uploadFile(File _image) async {
    Reference ref = storage.ref().child(
        FirebaseAuth.instance.currentUser!.uid + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(_image);
    await uploadTask.whenComplete(() => null);
    return await ref.getDownloadURL();
  }

  @override
  void initState() {
    currentDocuments=widget.documents;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    currentDocuments=widget.documents;
    return Container(
      child: InkWell(
        onTap: _showPicker,
        child: currentDocuments.length==0?Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: BACKGROUND_COLOR_ADD_HORSE.withOpacity(.3),
                borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            margin: EdgeInsets.only(top: 20,bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20.0,
                    child: Icon(
                      widget.icons,
                      size: 22.0,
                      color: BACKGROUND_COLOR_DASHBOARD,
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text(widget.text,style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),)
              ],
            )
        ):ChooseDocuments(),
      ),
    );
  }


  Widget AddDocuments(int index) {
    return InkWell(
      key: ValueKey(index),
      onTap: () {
        _showPicker();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              size: 20,
            ),
            SizedBox(height: 10,),
            Text(
              "Add Documents",
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.4),
                blurRadius: 4,
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(7.0))),
      ),
    );
  }

  Widget ChooseDocuments() {
    return Container(
        child: GridView.count(
          padding: EdgeInsets.only(bottom: 20),
          crossAxisCount: 4,
          shrinkWrap: true,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: (150.0 / 200.0),
          children: List.generate(currentDocuments.length + 1, (index) {
            if (index == 0) {
              return AddDocuments(0);
            } else {
              return MyImageWidget(
                context: context,
                index: index - 1,
                url: currentDocuments[index-1],
                onUpdate: (){},
                onDelete: (){
                  setState(() {
                    currentDocuments.removeAt(index-1);
                  });
                  widget.onUpdate(currentDocuments);
                },
              );
            }
          }),
        ));
  }
}


class MyImageWidget extends StatelessWidget {
  final int index;
  final Function onUpdate;
  final BuildContext context;
  final Function onDelete;
  final String url;
  MyImageWidget(
      {Key? key,
        required this.index,
        required this.url,
        required this.onUpdate,
        required this.onDelete,
        required this.context})
      : super(key: key);

  TextEditingController _commentValue = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.6),
                  blurRadius: 5,
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(7.0))),
          child: InkWell(
            onTap: () async{
              if (!await launch(url)) throw 'Could not launch';
            },
            child: Center(
              child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.white),
                  child: Center(child: Column(
                    children: [
                      Icon(Icons.remove_red_eye),
                      SizedBox(height: 05,),
                      Text((index+1).toString()),
                    ],
                  ))),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 50,
          child: InkWell(
            onTap: (){
              onDelete();
            },
            child: Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Colors.red),
                child: Center(child: Icon(Icons.delete,color: Colors.white,))),
          ),
        ),
      ],
    );
  }
}


