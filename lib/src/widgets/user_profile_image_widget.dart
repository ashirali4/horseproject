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
class UserProfileImageWidget extends StatefulWidget {
  String text;
  IconData icons;
  WidgetType widgetType;
  Function onUpdate;
  String urlpre;
  UserProfileImageWidget({Key? key,required this.widgetType,required this.text,required this.icons,required this.onUpdate,required this.urlpre}) : super(key: key);
  @override
  State<UserProfileImageWidget> createState() =>  _ImageWidgetState();
}

class _ImageWidgetState extends State<UserProfileImageWidget> {

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
          margin: EdgeInsets.only(top: 20,bottom: 20,left: 20,right: 20),
          child: SizedBox(
            child: CircleAvatar(
              child: Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 15.0,
                  child: Icon(
                    Icons.camera_alt,
                    size: 15.0,
                    color: Color(0xFF404040),
                  ),
                ),
              ),
              radius: 50.0,
              backgroundImage: NetworkImage(
                  'https://images.vexels.com/media/users/3/129733/isolated/preview/a558682b158debb6d6f49d07d854f99f-casual-male-avatar-silhouette.png'),
            ),),
        ):HaveFileWidget(),
      ),
    );
  }

  Widget HaveFileWidget(){
    return Container(
      child: widget.widgetType!=WidgetType.PDFType?
      Container(
        margin: EdgeInsets.only(top: 20,bottom: 20,left: 20,right: 20),
        child: SizedBox(
          child: CircleAvatar(
            child: Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 15.0,
                child: Icon(
                  Icons.camera_alt,
                  size: 15.0,
                  color: Color(0xFF404040),
                ),
              ),
            ),
            radius: 50.0,
            backgroundImage: NetworkImage(
                uploadFileUrl),
          ),),
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
