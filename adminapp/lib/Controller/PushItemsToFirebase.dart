import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:sampleproject/Class/CheckboxesQueForm.dart';
import 'package:sampleproject/Class/FormInf.dart';
import 'package:sampleproject/Class/MultipleQueForm.dart';
import 'package:sampleproject/Class/TextQueForm.dart';

class PushItemsToFirebase extends GetxController {
  formInfPush({required FormInf formInf, required String DocId}) async {
    await FirebaseFirestore.instance
        .collection('mainFormData')
        .doc('$DocId')
        .set(
          formInf.toJson(),
        );
  }

  textQuePush({required TextQueForm textQueForm, required String DocId}) async {
    await FirebaseFirestore.instance
        .collection('formDesc')
        .doc('Questions')
        .collection('$DocId')
        .add(
          textQueForm.toJson(),
        );
  }

  MultipleQuePush(
      {required MultipleQueForm multipleQueForm, required String DocId}) async {
    await FirebaseFirestore.instance
        .collection('formDesc')
        .doc('Questions')
        .collection('$DocId')
        .add(
          multipleQueForm.toJson(),
        );
  }

  CheckboxesQuePush(
      {required CheckboxesQueForm checkboxesQueForm,
      required String DocId}) async {
    await FirebaseFirestore.instance
        .collection('formDesc')
        .doc('Questions')
        .collection('$DocId')
        .add(
          checkboxesQueForm.toJson(),
        );
  }
}
