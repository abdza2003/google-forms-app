import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:sampleproject/Controller/FirebaseServise.dart';
import 'package:sampleproject/screens/getAllItemByDoc.dart';
import 'package:sampleproject/widget/FormsScreen.dart';

class getformswithDoc extends StatefulWidget {
  @override
  State<getformswithDoc> createState() => _getformswithDocState();
}

class _getformswithDocState extends State<getformswithDoc> {
  FirebaseServise s1 = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: s1.getDoc.length,
          itemBuilder: ((context, index) {
            return getAllItemByDoc(
              index: index,
              idKey: s1.getDoc[index],
            );
          }),
        ));
  }
}
