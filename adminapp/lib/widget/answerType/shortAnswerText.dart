import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sampleproject/Controller/DatabaseApp.dart';
import 'package:sampleproject/Themes/Themes.dart';
import 'package:sampleproject/widget/inputFaild.dart';

class shortAnswerText extends StatelessWidget {
  int queIndex;
  String title;
  shortAnswerText({required this.queIndex, required this.title});
  DatabaseApp s1 = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '#${queIndex + 1}Question',
            style: Themes().headLine3.copyWith(fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 330,
            // color: Colors.red,
            child: Text(
              '${title}',
              style: Themes().headLine4,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          inputFaild(
            title: 'answer -: ',
            hintText: 'write your answer here .',
            maxLines: 4,
            textEditingController: s1.answerInf['$queIndex']![0]['textAnswer']
                as TextEditingController,
          ),
        ],
      ),
    );
  }
}
