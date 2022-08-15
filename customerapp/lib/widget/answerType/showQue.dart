import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sampleproject/Controller/DatabaseApp.dart';
import 'package:sampleproject/main.dart';
import 'package:sampleproject/screens/homePageScreen.dart';
import 'package:sampleproject/widget/answerType/CheckboxsAnswer.dart';
import 'package:sampleproject/widget/answerType/MultipleAnswer.dart';
import 'package:sampleproject/widget/answerType/shortAnswerText.dart';
import 'package:sampleproject/widget/myButton.dart';

class showQue extends StatefulWidget {
  String formId;
  showQue({required this.formId});

  @override
  State<showQue> createState() => _showQueState();
}

class _showQueState extends State<showQue> {
  DatabaseApp s2 = Get.find();
  String? idKey = pref.getString('key');
  @override
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questions'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('/formDesc/Questions/${widget.formId}')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<DocumentSnapshot> s1 = snapshot.data!.docs;

          return Stack(
            alignment: Alignment.center,
            children: [
              AnimatedOpacity(
                duration: Duration(milliseconds: 400),
                opacity: isLoading == true ? .4 : 1,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: s1.length,
                      itemBuilder: ((context, index) {
                        return (s1 as dynamic)[index]['type'] == 'Short answer'
                            ? shortAnswerText(
                                queIndex: index,
                                title: '${(s1 as dynamic)[index]['title']}',
                              )
                            : (s1 as dynamic)[index]['type'] ==
                                    'Multiple choice'
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
                    ),
                    myButton(
                      title: 'Send',
                      myfunc: () async {
                        for (int i = 0; i < s1.length; i++) {
                          sendAnswerToFirebase(
                            (s1 as dynamic)[i]['type'],
                            (s1 as dynamic)[i]['title'],
                            i,
                          );
                        }
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc('$idKey')
                            .collection('fetchData')
                            .doc('${widget.formId}')
                            .update({
                          'isCompleted': true,
                        });
                        Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                            child: homePageScreen(),
                            type: PageTransitionType.bottomToTop,
                          ),
                          (route) => false,
                        );
                      },
                      height: MediaQuery.of(context).size.height / 15,
                      width: MediaQuery.of(context).size.width / 3.2,
                      padding: 20,
                    )
                  ],
                ),
              ),
              if (isLoading == true)
                Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedOpacity(
                      duration: Duration.zero,
                      opacity: .8,
                      child: Image.asset(
                        'images/s1.png',
                        width: MediaQuery.of(context).size.width / 2.6,
                        height: MediaQuery.of(context).size.height / 5,
                      ),
                    ),
                    CircularProgressIndicator(
                      color: Colors.cyan[700],
                    ),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }

  bool isLoading = false;

  sendAnswerToFirebase(
    String queType,
    String queTitle,
    int queIndex,
  ) async {
    setState(() {
      isLoading = true;
    });

    switch (queType) {
      case 'Short answer':
        await FirebaseFirestore.instance
            .collection('users')
            .doc('$idKey')
            .collection('${widget.formId}')
            .add({
          'queType': '$queType',
          'title': '$queTitle',
          'answer': (s2.answerInf['$queIndex']![0]['textAnswer']
                  as TextEditingController)
              .text
        });

        break;
      case 'Multiple choice':
        await FirebaseFirestore.instance
            .collection('users')
            .doc('$idKey')
            .collection('${widget.formId}')
            .add({
          'queType': '$queType',
          'title': '$queTitle',
          'answer': s2.answerInf['${queIndex}']![0]['Multiple'],
        });
        break;
      case 'Checkboxes':
        await FirebaseFirestore.instance
            .collection('users')
            .doc('$idKey')
            .collection('${widget.formId}')
            .add({
          'queType': '$queType',
          'title': '$queTitle',
          'answer': [
            (s2.answerInf['${queIndex}']![0] as dynamic)['Checkboxes']['0'],
            (s2.answerInf['${queIndex}']![0] as dynamic)['Checkboxes']['1'],
            (s2.answerInf['${queIndex}']![0] as dynamic)['Checkboxes']['2'],
            (s2.answerInf['${queIndex}']![0] as dynamic)['Checkboxes']['3'],
          ],
        });
        break;
    }
  }

  getSnackBar(String title) {
    Get.snackbar(
      'wrong entry',
      '$title',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.cyan[800],
      colorText: Colors.white,
      icon: Icon(Icons.error),
      margin: EdgeInsets.all(15),
    );
  }
}
