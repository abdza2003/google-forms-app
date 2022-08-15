import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sampleproject/Class/CheckboxesQueForm.dart';
import 'package:sampleproject/Class/FormInf.dart';
import 'package:sampleproject/Class/MultipleQueForm.dart';
import 'package:sampleproject/Class/TextQueForm.dart';
import 'package:sampleproject/Controller/DatabaseApp.dart';
import 'package:sampleproject/Controller/FirebaseServise.dart';
import 'package:sampleproject/Controller/PushItemsToFirebase.dart';
import 'package:sampleproject/Themes/Themes.dart';
import 'package:sampleproject/pages/onePageForm.dart';
import 'package:sampleproject/pages/towPageForm.dart';
import 'package:sampleproject/screens/homePageScreen.dart';

import 'package:sampleproject/widget/inputFaild.dart';
import 'package:sampleproject/widget/myButton.dart';

class addFormScreen extends StatefulWidget {
  @override
  State<addFormScreen> createState() => _addFormScreenState();
}

class _addFormScreenState extends State<addFormScreen> {
  TextEditingController formType = new TextEditingController(text: '');
  TextEditingController formTitle = new TextEditingController(text: '');
  TextEditingController formDesc = new TextEditingController(text: '');

  late PageController _controller = PageController(initialPage: 0);
  int TopageIndex = 1;
  int peforePgeIndex = 1;
  int queIndex = 1;
  DatabaseApp databaseApp = Get.find();
  FirebaseServise firebaseServise = Get.find();
  PushItemsToFirebase pushItemsToFirebase = Get.find();
  Random docId = new Random();
  late DateTime savedDateTime;
  late String getSavedDateTime;
  @override
  void initState() {
    savedDateTime = DateTime.now();
    getSavedDateTime =
        formatDate(savedDateTime, [mm, '/', dd, ' ', hh, ':', nn, ' ', am]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Forms'),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedOpacity(
              duration: Duration(milliseconds: 400),
              opacity: isLoading ? .4 : 1,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      PageView(
                        controller: _controller,
                        onPageChanged: (val) {
                          setState(() {
                            print('========$val');
                            TopageIndex = val + 1;
                            peforePgeIndex = TopageIndex - 2;
                          });
                        },
                        physics: BouncingScrollPhysics(),
                        children: [
                          onePageForm(
                            formDesc: formDesc,
                            formTitle: formTitle,
                            formType: formType,
                          ),
                          ...List.generate(
                            queIndex,
                            (index) => towPageForm(
                              queIndex: TopageIndex - 1,
                              index: index,
                            ),
                          )
                        ],
                      ),
                      theBottomPage(),
                    ],
                  ),
                  if (TopageIndex > queIndex)
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          queIndex > 1
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      print('=============${queIndex}');
                                      databaseApp.ListInf['${queIndex - 1}'] = [
                                        {
                                          'icon': '',
                                          'title': new TextEditingController(
                                              text: ''),
                                          'type': 'Short answer',
                                          'optionsIndexCheckboxs': 1,
                                          'optionsIndexMultiple': 1,
                                          'answers': {
                                            'Multiple': {
                                              '0': TextEditingController(
                                                  text: ''),
                                              '1': TextEditingController(
                                                  text: ''),
                                              '2': TextEditingController(
                                                  text: ''),
                                              '3': TextEditingController(
                                                  text: ''),
                                            },
                                            'Checkboxes': {
                                              '0': TextEditingController(
                                                  text: ''),
                                              '1': TextEditingController(
                                                  text: ''),
                                              '2': TextEditingController(
                                                  text: ''),
                                              '3': TextEditingController(
                                                  text: ''),
                                            },
                                          }
                                        }
                                      ];
                                      queIndex = queIndex - 1;
                                      print('=============${queIndex}');

                                      _controller.animateToPage(queIndex,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.decelerate);
                                    });
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    size: 30,
                                  ),
                                )
                              : Container(
                                  child: Text(''),
                                ),
                          myButton(
                            title: 'Send',
                            myfunc: pushToFirebase,
                            height: MediaQuery.of(context).size.height / 15,
                            width: MediaQuery.of(context).size.width / 4,
                            padding: 0,
                          ),
                        ],
                      ),
                    ),
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
        ),
      ),
    );
  }

  bool isPushFire = false;
  pushToFirebase() async {
    setState(() {
      for (int i = 0; i < queIndex; i++) {
        if ((databaseApp.ListInf['${i}']![0] as dynamic)['title'].text == '') {
          getSnackBar('Please fill in the required information');
          isPushFire = false;
        } else if (formDesc.text == '' ||
            formTitle.text == '' ||
            formType.text == '') {
          print('----------- ${queIndex}');
          getSnackBar('Please fill in the required information');
          isPushFire = false;
        } else {
          isPushFire = true;
        }
      }
    });
    print('is bool ==== $isPushFire');
    if (isPushFire == true) {
      setState(() {
        isLoading = true;
      });
      int getDocId = docId.nextInt(1000);
      await pushItemsToFirebase.formInfPush(
        formInf: FormInf(
          formDecs: formDesc.text,
          formTitle: formTitle.text,
          formType: formType.text,
          formIcon: (databaseApp.ListInf['0']![0] as dynamic)['icon'],
          formDate: getSavedDateTime,
          formQueOfNumber: '$queIndex',
        ),
        DocId: '${getDocId}',
      );

      for (int i = 0; i < queIndex; i++) {
        await pushInfToFirebaseByFormType(
          formType: '${(databaseApp.ListInf['${i}']![0] as dynamic)['type']}',
          queIndex: i,
          DocId: getDocId,
        );
      }
      await firebaseServise.pushFormToUsersByDoc('$getDocId');
      setState(() {
        isLoading = false;
      });
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => homePageScreen()),
        (route) => false,
      );
    }
  }

  bool isLoading = false;
  pushInfToFirebaseByFormType(
      {required String formType, required int queIndex, required int DocId}) {
    ///'Short answer', 'Multiple choice', 'Checkboxes'
    switch (formType) {
      case 'Short answer':
        pushItemsToFirebase.textQuePush(
          textQueForm: TextQueForm(
              title:
                  '${(databaseApp.ListInf['${queIndex}']![0] as dynamic)['title'].text}',
              type:
                  '${(databaseApp.ListInf['${queIndex}']![0] as dynamic)['type']}'),
          DocId: '${DocId}',
        );
        break;
      case 'Multiple choice':
        pushItemsToFirebase.MultipleQuePush(
          multipleQueForm: MultipleQueForm(
            title:
                '${(databaseApp.ListInf['${queIndex}']![0] as dynamic)['title'].text}',
            type:
                '${(databaseApp.ListInf['${queIndex}']![0] as dynamic)['type']}',
            option1:
                '${(databaseApp.ListInf['${queIndex}']![0] as dynamic)['answers']['Multiple']['0'].text}',
            option2:
                '${(databaseApp.ListInf['${queIndex}']![0] as dynamic)['answers']['Multiple']['1'].text}',
            option3:
                '${(databaseApp.ListInf['${queIndex}']![0] as dynamic)['answers']['Multiple']['2'].text}',
            option4:
                '${(databaseApp.ListInf['${queIndex}']![0] as dynamic)['answers']['Multiple']['3'].text}',
          ),
          DocId: '${DocId}',
        );

        break;
      case 'Checkboxes':
        pushItemsToFirebase.CheckboxesQuePush(
          checkboxesQueForm: CheckboxesQueForm(
            title:
                '${(databaseApp.ListInf['${queIndex}']![0] as dynamic)['title'].text}',
            type:
                '${(databaseApp.ListInf['${queIndex}']![0] as dynamic)['type']}',
            option1:
                '${(databaseApp.ListInf['${queIndex}']![0] as dynamic)['answers']['Checkboxes']['0'].text}',
            option2:
                '${(databaseApp.ListInf['${queIndex}']![0] as dynamic)['answers']['Checkboxes']['1'].text}',
            option3:
                '${(databaseApp.ListInf['${queIndex}']![0] as dynamic)['answers']['Checkboxes']['2'].text}',
            option4:
                '${(databaseApp.ListInf['${queIndex}']![0] as dynamic)['answers']['Checkboxes']['3'].text}',
          ),
          DocId: '${DocId}',
        );

        break;
    }
  }

  theBottomPage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TopageIndex > 1
            ? Container(
                height: MediaQuery.of(context).size.height / 15,
                margin: EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _controller.animateToPage(peforePgeIndex,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.decelerate);
                    });
                  },
                  child: Icon(
                    Icons.navigate_before,
                    color: Colors.white,
                  ),
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height / 15,
                margin: EdgeInsets.all(20),
              ),
        TopageIndex <= queIndex
            ? Container(
                height: MediaQuery.of(context).size.height / 15,
                margin: EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _controller.animateToPage(TopageIndex,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.decelerate);
                    });
                  },
                  child: Icon(
                    Icons.navigate_next_sharp,
                    color: Colors.white,
                  ),
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height / 15,
                alignment: Alignment.center,
                margin: EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      queIndex = queIndex + 1;
                      _controller.animateToPage(queIndex,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.decelerate);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.add),
                        Text(
                          'Add Que',
                          style: Themes().headLine2.copyWith(
                                color: Colors.white,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ],
    );
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
