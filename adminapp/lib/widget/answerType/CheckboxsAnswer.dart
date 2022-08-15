import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sampleproject/Controller/DatabaseApp.dart';
import 'package:sampleproject/Themes/Themes.dart';
import 'package:sqflite/sqflite.dart';

class CheckboxsAnswer extends StatefulWidget {
  int queIndex;
  String title;
  List<String> options = [];

  CheckboxsAnswer({
    required this.queIndex,
    required this.title,
    required this.options,
  });
  @override
  State<CheckboxsAnswer> createState() => _CheckboxsAnswerState();
}

class _CheckboxsAnswerState extends State<CheckboxsAnswer> {
  List<bool> isClick = [false, false, false, false];
  DatabaseApp s1 = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '#${widget.queIndex + 1}Question',
            style: Themes().headLine3.copyWith(fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 330,
            // color: Colors.red,
            child: Text(
              '${widget.title}',
              style: Themes().headLine4,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          for (int i = 0; i < isClick.length; i++)
            Padding(
              padding: EdgeInsets.only(right: 0),
              child: ListTile(
                onTap: () {
                  setState(() {
                    isClick[i] = !isClick[i];
                    (s1.answerInf['${widget.queIndex}']![0]
                        as dynamic)['Checkboxes']['$i'] = widget.options[i];
                  });
                },
                leading: Checkbox(
                    value: isClick[i],
                    onChanged: (val) {
                      setState(() {
                        isClick[i] = val as bool;
                        (s1.answerInf['${widget.queIndex}']![0]
                            as dynamic)['Checkboxes']['$i'] = widget.options[i];
                      });
                    }),
                title: Text(
                  '${widget.options[i]}',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
