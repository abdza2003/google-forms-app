import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sampleproject/Controller/FirebaseServise.dart';
import 'package:sampleproject/extra/getIsCompletedItem.dart';
import 'package:sampleproject/main.dart';
import 'package:sampleproject/screens/getAllItemByDoc.dart';

class getCompletedFormWithDoc extends StatefulWidget {
  @override
  State<getCompletedFormWithDoc> createState() =>
      _getCompletedFormWithDocState();
}

class _getCompletedFormWithDocState extends State<getCompletedFormWithDoc> {
  FirebaseServise s1 = Get.find();
  String? idKey = pref.getString('key');
  @override
  void initState() {
    s1.isCompletedForm('$idKey');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: s1.isCompletedForm('$idKey'),
      builder: (context, snapshot) => Container(
          width: double.infinity,
          height: double.infinity,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: s1.isCompletedFormDoc.length,
            itemBuilder: ((context, index) {
              return getIsCompletedItem(
                index: index,
                idKey: s1.isCompletedFormDoc[index],
              );
            }),
          )),
    );
  }
}
