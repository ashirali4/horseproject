import 'package:flutter/material.dart';
class OrLoginWith extends StatelessWidget {
  const OrLoginWith({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child:  Divider(
          color: Colors.black,
        ),),
        Center(
          child: Text('   or login with    ',
          ),
        ),
        Expanded(child:  Divider(
          color: Colors.black,
        ),),
      ],
    );;
  }
}
