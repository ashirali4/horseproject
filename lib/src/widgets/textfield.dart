import 'package:flutter/material.dart';

import '../utlis/constants.dart';
class TextFieldApp extends StatefulWidget {
  final String hintText;
  final String hintTitle;
  final bool obsecure;
  TextEditingController? controller=TextEditingController(text: '');
  TextFieldApp({Key? key,required this.hintText,required this.hintTitle,this.controller,this.obsecure=false}) : super(key: key);

  @override
  _TextFieldAppState createState() => _TextFieldAppState();
}

class _TextFieldAppState extends State<TextFieldApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(' '+widget.hintText,style: TextStyle(fontWeight: FontWeight.bold,color: LIGHT_BUTTON_COLOR),),
          SizedBox(height: 10,),
          SimpleTextField(hintText: widget.hintText,hintTitle: widget.hintTitle,controller: widget.controller!,isObsecure: widget.obsecure,),
        ],
      ),
    );
  }
}

class SimpleTextField extends StatefulWidget {
  final String hintText;
  final String hintTitle;
  final TextEditingController controller;
  final bool isObsecure;
  const SimpleTextField({Key? key,required this.hintText,required this.hintTitle,required this.controller,this.isObsecure=false}) : super(key: key);

  @override
  _SimpleTextFieldState createState() => _SimpleTextFieldState();
}

class _SimpleTextFieldState extends State<SimpleTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: TextField(
        obscureText: widget.isObsecure,
        controller: widget.controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 20,right: 20,top: 10),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: LIGHT_BUTTON_COLOR.withOpacity(.5)),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: BUTTON_PRIMARY),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: LIGHT_BUTTON_COLOR),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: LIGHT_BUTTON_COLOR),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: LIGHT_BUTTON_COLOR),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            filled: true,
            hintStyle: new TextStyle(color: Colors.grey[600]),
            hintText: widget.hintTitle,
            fillColor: Colors.white),
      ),
    );
  }
}

