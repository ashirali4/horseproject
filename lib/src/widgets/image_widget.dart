import 'package:flutter/material.dart';

import '../utlis/constants.dart';
class UploadImageWidget extends StatefulWidget {
  final String text;
  final IconData icons;
  const UploadImageWidget({Key? key,required this.text,required this.icons}) : super(key: key);
  @override
  State<UploadImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<UploadImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );

  }
}
