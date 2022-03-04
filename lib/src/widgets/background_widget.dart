import 'package:flutter/material.dart';
class BackgroundImageWidget extends StatefulWidget {
  final Widget elements;
  const BackgroundImageWidget({Key? key,required this.elements}) : super(key: key);

  @override
  _BackgroundImageWidgetState createState() => _BackgroundImageWidgetState();
}

class _BackgroundImageWidgetState extends State<BackgroundImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/bg.png',fit: BoxFit.fitHeight,),
        widget.elements,
      ],
    );
  }
}
