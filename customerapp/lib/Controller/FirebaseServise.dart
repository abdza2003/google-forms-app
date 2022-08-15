import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class FirebaseServise extends GetxController {
  List<String> getDoc = [];
  List<String> getDocUser = [];
  List<String> isCompletedFormDoc = [];
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

  emptyItems() {
    getDoc = [];
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
  }

  pushFormToUsersByDoc(String formId) async {
    getUsersByDoc();
    if (!getDocUser.isEmpty) {
      for (int i = 0; i < getDocUser.length; i++) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc('${getDocUser[i]}')
            .collection('$formId')
            .add({
          'fetchData': false,
        });
      }
    } else {
      return;
    }
  }

  newUser(String UserId) async {
    await getInfByDoc();

    for (int i = 0; i < getDoc.length; i++) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc('${UserId}')
          .collection('fetchData')
          .doc('${getDoc[i]}')
          .set({
        'isCompleted': false,
      });
    }
  }

  isCompletedForm(String UserId) async {
    isCompletedFormDoc = [];

    if (getDoc.length == 0) {
      return '';
    } else {
      for (int i = 0; i < getDoc.length; i++) {
        var a = await FirebaseFirestore.instance
            .collection('users')
            .doc('$UserId')
            .collection('fetchData')
            .doc('${getDoc[i]}')
            .get();
        if (a.data()!['isCompleted'] == true) {
          var b = isCompletedFormDoc.any((element) => element == getDoc[i]);
          if (b == false) {
            isCompletedFormDoc.add('${getDoc[i]}');
          }
        }
      }
    }
  }
}
