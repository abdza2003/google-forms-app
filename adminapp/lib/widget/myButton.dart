import 'package:flutter/material.dart';
import 'package:sampleproject/Themes/Themes.dart';

class myButton extends StatelessWidget {
  String title;
  var myfunc;
  double padding;
  double height;
  double width;
  var color;
  myButton(
      {required this.title,
      required this.myfunc,
      required this.height,
      required this.width,
      required this.padding,
      this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(padding),
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: myfunc,
        child: Text(
          '${title}',
          style: Themes().headLine3.copyWith(fontSize: 22, color: Colors.white),
        ),
      ),
    );
  }
}
