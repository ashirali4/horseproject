import 'package:flutter/material.dart';
class SingleCircle extends StatelessWidget {
  final String txt;
  final String txt2;
  final Color color;
  final Function function;
  const SingleCircle({
    Key? key,
    required this.txt,
    required this.color,
    required this.txt2,
    required this.function,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        this.function();
      },
      child: Container(
        child: Column(
          children: [
            Container(
              height: 78,
              padding: EdgeInsets.all(25),
              //color: Colors.red,
              child: Center(child: Image.asset(txt)),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
            ),
            SizedBox(
              height: 05,
            ),
            Text(
              txt2,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            SizedBox(
              height: 05,
            ),
          ],
        ),
      ),
    );
  }
}
