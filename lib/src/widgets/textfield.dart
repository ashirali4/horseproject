import 'package:flutter/material.dart';

import '../utlis/constants.dart';
class TextFieldApp extends StatefulWidget {
  final String hintText;
  final String hintTitle;
  final bool obsecure;
  final Widget endingWidget;
  final bool isEnabled;
  final TextInputType type;
  TextEditingController? controller=TextEditingController(text: '');
  TextFieldApp({Key? key,required this.type,required this.hintText,required this.hintTitle,this.controller,this.obsecure=false,this.endingWidget=const SizedBox(),this.isEnabled=true}) : super(key: key);

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
          SimpleTextField(type:widget.type,hintText: widget.hintText,hintTitle: widget.hintTitle,controller: widget.controller!,isObsecure: widget.obsecure,endingWidget: widget.endingWidget,
          isEnabled: widget.isEnabled,),
        ],
      ),
    );
  }
}

class SimpleTextField extends StatefulWidget {
  final String hintText;
  final String hintTitle;
  final Widget endingWidget;
  final bool isEnabled;
  final TextInputType type;
  final TextEditingController controller;
  final bool isObsecure;
  const SimpleTextField({Key? key,required this.type,required this.hintText,required this.hintTitle,required this.controller,this.isObsecure=false,required this.endingWidget, this.isEnabled=true}) : super(key: key);

  @override
  _SimpleTextFieldState createState() => _SimpleTextFieldState();
}

class _SimpleTextFieldState extends State<SimpleTextField> {

  bool obsecureText=false;

  @override
  void initState() {
    obsecureText = widget.isObsecure;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: TextField(
        keyboardType: widget.type,
        //enabled: widget.isEnabled,
        readOnly: !widget.isEnabled,
        obscureText:obsecureText,
        controller: widget.controller,
        decoration: InputDecoration(
          suffixIcon: Container(
              margin: EdgeInsets.only(right: 10),
              child: widget.type==TextInputType.visiblePassword ? IconButton(onPressed: (){
                 setState(() {
                   obsecureText=!obsecureText;
                 });
              }, icon: Icon(Icons.remove_red_eye)) :widget.endingWidget),
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
           // hintText: widget.hintTitle,
            fillColor: Colors.white),
      ),
    );
  }
}











class TextFieldAppD extends StatefulWidget {
  final String hintText;
  final String hintTitle;
  final bool obsecure;
  final Widget endingWidget;
  final bool isEnabled;
  final TextInputType type;
  final isDescription;
  TextEditingController? controller=TextEditingController(text: '');
  TextFieldAppD({Key? key,required this.type,required this.hintText,required this.hintTitle,this.controller,this.obsecure=false,this.endingWidget=const SizedBox(),this.isEnabled=true,this.isDescription=false}) : super(key: key);

  @override
  _TextFieldAppDState createState() => _TextFieldAppDState();
}

class _TextFieldAppDState extends State<TextFieldAppD> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(' '+widget.hintText,style: TextStyle(fontWeight: FontWeight.bold,color: LIGHT_BUTTON_COLOR),),
          SizedBox(height: 10,),
          SimpleTextFieldD(type:widget.type,hintText: widget.hintText,hintTitle: widget.hintTitle,controller: widget.controller!,isObsecure: widget.obsecure,endingWidget: widget.endingWidget, isDescription: widget.isDescription,
            isEnabled: widget.isEnabled,),
        ],
      ),
    );
  }
}

class SimpleTextFieldD extends StatefulWidget {
  final String hintText;
  final String hintTitle;
  final Widget endingWidget;
  final bool isEnabled;
  final TextInputType type;
  final TextEditingController controller;
  final bool isObsecure;
  final bool isDescription;
  const SimpleTextFieldD({Key? key,required this.type,required this.hintText,required this.hintTitle,required this.controller,this.isObsecure=false,required this.endingWidget, this.isEnabled=true,required this.isDescription}) : super(key: key);

  @override
  _SimpleTextFieldDState createState() => _SimpleTextFieldDState();
}

class _SimpleTextFieldDState extends State<SimpleTextFieldD> {

  bool obsecureText=false;

  @override
  void initState() {
    obsecureText = widget.isObsecure;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.isDescription ? 150 : 50,
      child: TextField(
        keyboardType: widget.type,
        minLines: widget.isDescription ? 7 : 1,
        maxLines: widget.isDescription ? 8 : 2,
        //enabled: widget.isEnabled,
        readOnly: !widget.isEnabled,
        obscureText:obsecureText,
        controller: widget.controller,
        decoration: InputDecoration(
            suffixIcon: Container(
                margin: EdgeInsets.only(right: 10),
                child: widget.type==TextInputType.visiblePassword ? IconButton(onPressed: (){
                  setState(() {
                    obsecureText=!obsecureText;
                  });
                }, icon: Icon(Icons.remove_red_eye)) :widget.endingWidget),
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
            // hintText: widget.hintTitle,
            fillColor: Colors.white),
      ),
    );
  }
}

