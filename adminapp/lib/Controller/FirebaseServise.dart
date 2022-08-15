import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sampleproject/screens/homePageScreen.dart';

class FirebaseServise extends GetxController {
  List<String> getDoc = [];
  List<String> getDocUser = [];
  List<String> getAnswrQue = [];
  List<String> getMultipleQue = [];
  List<String> getCheckboxesQue = [];
  String referanceCode = '';
  List<int> getNum = [];
  List<StatisticsMultipleData> statisticsMultipleData = [];
  List<StatisticsCheckboxesData> statisticsCheckboxesData = [];
  getInfByDoc() async {
    await FirebaseFirestore.instance
        .collection('mainFormData')
        .get()
        .then((value) => value.docs.forEach((element) {
              bool fetch = getDoc.any((val) => val == element.reference.id);
              if (fetch == false) {
                print('---------- ${element.reference.id}');
                getDoc.add(element.reference.id);
              }
            }));
  }

  RefreshItems() async {
    await getInfByDoc();
  }

  getUsersByDoc() async {
    await FirebaseFirestore.instance.collection('users').get().then(
          (value) => value.docs.forEach((element) {
            bool fetch = getDocUser.any((val) => val == element.reference.id);
            if (fetch == false) {
              getDocUser.add(element.reference.id);
              print('${element.reference.id}');
            }
          }),
        );
    getDoc = [];
  }

  pushFormToUsersByDoc(String formId) async {
    await getUsersByDoc();
    if (!getDocUser.isEmpty) {
      for (int i = 0; i < getDocUser.length; i++) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc('${getDocUser[i]}')
            .collection('fetchData')
            .doc('$formId')
            .set({
          'isCompleted': false,
        });
      }
    } else {
      return;
    }
  }

  getTextAnswerQue({
    required String title,
    required String formId,
  }) async {
    await getUsersByDoc();
    getAnswrQue = [];
    for (int i = 0; i < getDocUser.length; i++) {
      var a = await FirebaseFirestore.instance
          .collection('users')
          .doc('${getDocUser[i]}')
          .collection('$formId')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          if (element.data()['title'] == title &&
              element.data()['queType'] == 'Short answer') {
            var b = getAnswrQue.any((val) => val == element.data()['answer']);
            if (b == false) {
              getAnswrQue.add(element.data()['answer']);
              print('${getAnswrQue[0]}');
            }
          }
        });
      });
    }
  }

  getMultiAnswer({
    required String title,
    required String formId,
  }) async {
    getMultipleQue = [];
    await FirebaseFirestore.instance
        .collection('formDesc')
        .doc('Questions')
        .collection('$formId')
        .get()
        .then((value) => value.docs.forEach((element) {
              if (element.data()['title'] == title ||
                  element.data()['queType'] == 'Multiple choice') {
                var a = getMultipleQue
                    .any((val) => val == element.data()['option1']);
                var b = getMultipleQue
                    .any((val) => val == element.data()['option2']);
                var c = getMultipleQue
                    .any((val) => val == element.data()['option3']);
                var d = getMultipleQue
                    .any((val) => val == element.data()['option4']);
                if (a == false) {
                  getMultipleQue.add(element.data()['option1']);
                }
                if (b == false) {
                  getMultipleQue.add(element.data()['option2']);
                }
                if (c == false) {
                  getMultipleQue.add(element.data()['option3']);
                }
                if (d == false) {
                  getMultipleQue.add(element.data()['option4']);
                }
              }
            }));
  }

  getMultiAnswerQue({
    required String title,
    required String formId,
  }) async {
    await getMultiAnswer(title: title, formId: formId);
    await getUsersByDoc();
    List<int> queOfNumber = [0, 0, 0, 0];
    print('af s sdf sdfsd');
    for (int i = 0; i < getDocUser.length; i++) {
      var a = await FirebaseFirestore.instance
          .collection('users')
          .doc('${getDocUser[i]}')
          .collection('$formId')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          if (element.data()['title'] == title &&
              element.data()['queType'] == 'Multiple choice') {
            for (int i = 0; i < 4; i++) {
              if (element.data()['answer'] == getMultipleQue[i]) {
                queOfNumber[i]++;
                print('added');
              }
            }
          }
        });
      });
    }
    statisticsMultipleData = [];
    print('$getMultipleQue');
    for (int i = 0; i < 4; i++) {
      statisticsMultipleData.add(StatisticsMultipleData(
          que: getMultipleQue[i], numberOfAnswer: queOfNumber[i]));
    }
  }

  getCheckboxesAnswer({
    required String title,
    required String formId,
  }) async {
    getCheckboxesQue = [];
    await FirebaseFirestore.instance
        .collection('formDesc')
        .doc('Questions')
        .collection('$formId')
        .get()
        .then((value) => value.docs.forEach((element) {
              if (element.data()['title'] == title ||
                  element.data()['queType'] == 'Checkboxes') {
                var a = getCheckboxesQue
                    .any((val) => val == element.data()['option1']);
                var b = getCheckboxesQue
                    .any((val) => val == element.data()['option2']);
                var c = getCheckboxesQue
                    .any((val) => val == element.data()['option3']);
                var d = getCheckboxesQue
                    .any((val) => val == element.data()['option4']);
                if (a == false) {
                  getCheckboxesQue.add(element.data()['option1']);
                }
                if (b == false) {
                  getCheckboxesQue.add(element.data()['option2']);
                }
                if (c == false) {
                  getCheckboxesQue.add(element.data()['option3']);
                }
                if (d == false) {
                  getCheckboxesQue.add(element.data()['option4']);
                }
              }
            }));
    print('===========${getCheckboxesQue}');
  }

  getCheckboxesAnswerQue({
    required String title,
    required String formId,
  }) async {
    await getCheckboxesAnswer(title: title, formId: formId);
    await getUsersByDoc();

    statisticsCheckboxesData = [];
    List<int> queOfNumber = [0, 0, 0, 0];
    print('af s sdf fsdsdfsdsddsfdssdfsd');
    for (int i = 0; i < getDocUser.length; i++) {
      var a = await FirebaseFirestore.instance
          .collection('users')
          .doc('${getDocUser[i]}')
          .collection('$formId')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          statisticsCheckboxesData = [];
          if (element.data()['title'] == title &&
              element.data()['queType'] == 'Checkboxes') {
            for (int i = 0; i < 4; i++) {
              for (int j = 0; j < 4; j++) {
                if (element.data()['answer'][i] == getCheckboxesQue[j]) {
                  queOfNumber[j]++;
                  print('added');
                }
              }
            }
          }
        });
      });
    }
    statisticsCheckboxesData = [];
    for (int i = 0; i < 4; i++) {
      statisticsCheckboxesData.add(StatisticsCheckboxesData(
          que: getCheckboxesQue[i], numberOfAnswer: queOfNumber[i]));
    }
  }

  DeleteForms({required BuildContext context, required String formId}) async {
    await FirebaseFirestore.instance
        .collection('mainFormData')
        .doc('$formId')
        .delete()
        .then((value) async {
      getDoc = [];
      print('deleted');
      getInfByDoc();
    });
    ////formDesc/Questions/formId
    await FirebaseFirestore.instance
        .collection('formDesc')
        .doc('Questions')
        .collection('$formId')
        .get()
        .then(
          (value) => value.docs.forEach(
            (element) {
              FirebaseFirestore.instance
                  .collection('formDesc')
                  .doc('Questions')
                  .collection('$formId')
                  .doc('${element.reference.id}')
                  .delete();
            },
          ),
        );
    ////mainFormData/formId

    ////users/ihPAm1FutZVWRU4zqs3I8od0Qw23/836
    ///
    getUsersByDoc();
    if (getDocUser.isEmpty) {
      return;
    } else {
      for (int i = 0; i < getDocUser.length; i++) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc('${getDocUser[i]}')
            .collection('$formId')
            .get()
            .then(
              (value) => value.docs.forEach(
                (element) {
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc('${getDocUser[i]}')
                      .collection('$formId')
                      .doc('${element.reference.id}')
                      .delete();
                },
              ),
            );
        ////users/ihPAm1FutZVWRU4zqs3I8od0Qw23/fetchData/100
        await FirebaseFirestore.instance
            .collection('users')
            .doc('${getDocUser[i]}')
            .collection('fetchData')
            .doc('$formId')
            .delete();
      }
    }

    print('============= Deleted');
  }

  referenceCode() async {
    ////fetchAdmin/referenceCode
    await FirebaseFirestore.instance
        .collection('fetchAdmin')
        .doc('referenceCode')
        .get()
        .then((value) {
      referanceCode = value.data()!['referenceCode'];
      print('====================${value.data()!['referenceCode']}');
    });
  }

  refreshReferencCode(String getRandomString) async {
    await FirebaseFirestore.instance
        .collection('fetchAdmin')
        .doc('referenceCode')
        .set({
      'referenceCode': '${getRandomString}',
    });
  }
}

class StatisticsMultipleData {
  String que;
  int numberOfAnswer;
  StatisticsMultipleData({required this.que, required this.numberOfAnswer});
}

class StatisticsCheckboxesData {
  String que;
  int numberOfAnswer;
  StatisticsCheckboxesData({required this.que, required this.numberOfAnswer});
}
