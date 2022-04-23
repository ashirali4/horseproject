import 'package:flutter/material.dart';
import 'package:horseproject/src/utlis/constants.dart';
class ButtonRound extends StatelessWidget {
  final String buttonText;
  final double radius;
  final double height;
  final Color buttonColor;
  final Color textColor;
  final Function function;
  ButtonRound({Key? key,required this.buttonText,this.radius=8,this.height=45,this.buttonColor=BUTTON_PRIMARY,this.textColor=Colors.white,required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: buttonColor, // background
          onPrimary: textColor, //
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(this.radius),
          ),// foreground
        ),
        onPressed: () {
          this.function();
        },
        child: Text(this.buttonText),
      ),
    );
  }
}


class ButtonRoundGoogle extends StatelessWidget {
  final String buttonText;
  final double radius;
  final double height;
  final Color buttonColor;
  final Color textColor;
  final Function ontap;
  const ButtonRoundGoogle({Key? key,required this.buttonText,this.radius=8,this.height=45,this.buttonColor=BUTTON_PRIMARY,this.textColor=Colors.white,required this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: buttonColor, // background
          onPrimary: textColor, //
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(this.radius),
            side: BorderSide(
              color: LIGHT_BUTTON_COLOR.withOpacity(.2),
              width: 1,
            ),
          ),// foreground
        ),
        onPressed: () {
          this.ontap();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/googlelogo.png',height: 30,),
            SizedBox(width: 10,),
            Text(this.buttonText)
          ],
        ),
      ),
    );
  }
}

