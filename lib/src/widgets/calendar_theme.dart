import 'package:flutter/material.dart';
class CalendarTheme extends StatelessWidget {
  final Widget child;
  const CalendarTheme({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light().copyWith(
        primaryColor: Colors.red,
        accentColor: Colors.red,
        colorScheme: ColorScheme.light(primary: Colors.red),
        buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary
        ),
      ),
      child: child,
    );
  }
}
