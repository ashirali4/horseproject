import 'package:flutter/material.dart';
class ButtonRound extends StatelessWidget {
  final String buttonText;
  final double radius;
  final double height;
  const ButtonRound({Key? key,required this.buttonText,this.radius=8,this.height=45}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.red, // background
          onPrimary: Colors.white, //
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(this.radius),
          ),// foreground
        ),
        onPressed: () { },
        child: Text(this.buttonText),
      ),
    );
  }
}
