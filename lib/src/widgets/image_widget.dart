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
class UploadImageWidget extends StatefulWidget {
   String text;
   IconData icons;
   WidgetType widgetType;
   Function onUpdate;
   String urlpre;
  UploadImageWidget({Key? key,required this.widgetType,required this.text,required this.icons,required this.onUpdate,required this.urlpre}) : super(key: key);
  @override
  State<UploadImageWidget> createState() =>  _ImageWidgetState();
}

class _ImageWidgetState extends State<UploadImageWidget> {

  FirebaseStorage storage = FirebaseStorage.instance;
  String uploadFileUrl='';

  Future<void> _showPicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: widget.widgetType==WidgetType.ImageType?['jpg', 'png', 'mp4']:['pdf','docx','txt'],
    );
    if (result != null) {
      EasyLoading.show(status: 'loading...');
      File file = File(result.files.single.path.toString());
      String url = await uploadFile(file);
      EasyLoading.dismiss();
      setState(() {
        uploadFileUrl=url;
      });
      widget.onUpdate(uploadFileUrl);
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
    uploadFileUrl=widget.urlpre;
    print("Data --- > "+ uploadFileUrl);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    uploadFileUrl=widget.urlpre;
    return Container(
      child: InkWell(
        onTap: _showPicker,
        child: uploadFileUrl==''?Container(
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
        ):HaveFileWidget(),
      ),
    );
  }

  Widget HaveFileWidget(){
    return Container(
      child: widget.widgetType!=WidgetType.PDFType?
      Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  uploadFileUrl,
                ),
                fit: BoxFit.cover
              ),
              borderRadius: BorderRadius.all(Radius.circular(8))
          ),
          margin: EdgeInsets.only(top: 20,bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.widgetType==WidgetType.ImageType? Container(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20.0,
                  child: Icon(
                    Icons.edit,
                    size: 22.0,
                    color: BACKGROUND_COLOR_DASHBOARD,
                  ),
                ),
              ):SizedBox.shrink(),
              SizedBox(height: 10,),
            ],
          )
      ):
      Container(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async{
                    if (!await launch(uploadFileUrl)) throw 'Could not launch';
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20.0,
                    child: Icon(
                      Icons.remove_red_eye,
                      size: 22.0,
                      color: BACKGROUND_COLOR_DASHBOARD,
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                InkWell(
                  onTap: _showPicker,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20.0,
                    child: Icon(
                      Icons.edit,
                      size: 22.0,
                      color: BACKGROUND_COLOR_DASHBOARD,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Text('Dokument anzeigen',style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),)
          ],
        )
    ),
    );
  }
}
