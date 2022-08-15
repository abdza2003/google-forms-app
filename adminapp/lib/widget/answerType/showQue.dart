import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampleproject/Class/CheckboxesQueForm.dart';
import 'package:sampleproject/Controller/DatabaseApp.dart';
import 'package:sampleproject/widget/answerType/CheckboxsAnswer.dart';
import 'package:sampleproject/widget/answerType/MultipleAnswer.dart';
import 'package:sampleproject/widget/answerType/shortAnswerText.dart';
import 'package:sampleproject/widget/myButton.dart';

class showQue extends StatelessWidget {
  String formId;
  showQue({required this.formId});
  DatabaseApp s2 = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questions'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('/formDesc/Questions/$formId')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<DocumentSnapshot> s1 = snapshot.data!.docs;

          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: s1.length,
            itemBuilder: ((context, index) {
              return (s1 as dynamic)[index]['type'] == 'Short answer'
                  ? shortAnswerText(
                      queIndex: index,
                      title: '${(s1 as dynamic)[index]['title']}',
                    )
                  : (s1 as dynamic)[index]['type'] == 'Multiple choice'
                      ? MultipleAnswer(
                          queIndex: index,
                          title: '${(s1 as dynamic)[index]['title']}',
                          options: [
                            '${(s1 as dynamic)[index]['option1']}',
                            '${(s1 as dynamic)[index]['option2']}',
                            '${(s1 as dynamic)[index]['option3']}',
                            '${(s1 as dynamic)[index]['option4']}',
                          ],
                        )
                      : CheckboxsAnswer(
                          queIndex: index,
                          title: '${(s1 as dynamic)[index]['title']}',
                          options: [
                            '${(s1 as dynamic)[index]['option1']}',
                            '${(s1 as dynamic)[index]['option2']}',
                            '${(s1 as dynamic)[index]['option3']}',
                            '${(s1 as dynamic)[index]['option4']}',
                          ],
                        );
            }),
          );
        },
      ),
    );
  }
}
