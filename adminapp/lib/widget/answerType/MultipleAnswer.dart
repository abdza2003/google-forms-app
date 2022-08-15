// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sampleproject/Controller/DatabaseApp.dart';

import 'package:sampleproject/Themes/Themes.dart';

class MultipleAnswer extends StatefulWidget {
  int queIndex;
  String title;
  List<String> options = [];

  MultipleAnswer({
    required this.queIndex,
    required this.title,
    required this.options,
  });
  @override
  State<MultipleAnswer> createState() => _MultipleAnswerState();
}

class _MultipleAnswerState extends State<MultipleAnswer> {
  int radioButton = 0;
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
          for (int i = 0; i < 4; i++)
            Padding(
              padding: EdgeInsets.only(right: 0),
              child: ListTile(
                onTap: () {
                  setState(() {
                    radioButton = i;
                    s1.answerInf['${widget.queIndex}']![0]['Multiple'] =
                        widget.options[i];
                  });
                },
                leading: Radio(
                    value: i,
                    groupValue: radioButton,
                    onChanged: (val) {
                      setState(() {
                        radioButton = val as int;
                        s1.answerInf['${widget.queIndex}']![0]['Multiple'] =
                            widget.options[i];
                      });
                    }),
                title: Text(
                  '${widget.options[i]}',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )
        ],
      ),
    );
  }
}
