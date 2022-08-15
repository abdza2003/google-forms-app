import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sampleproject/Controller/FirebaseServise.dart';
import 'package:sampleproject/Themes/ThemeController.dart';
import 'package:sampleproject/main.dart';
import 'package:sampleproject/pages/statisticsPage.dart';
import 'package:sampleproject/screens/homePageScreen.dart';
import 'package:sampleproject/widget/FormsScreen.dart';
import 'package:sampleproject/widget/Skelton.dart';
import 'package:sampleproject/widget/answerType/showQue.dart';
import 'package:sampleproject/widget/bottomSheatItem.dart';

class getAllItemByDoc extends StatelessWidget {
  int index;
  String idKey;
  getAllItemByDoc({
    required this.index,
    required this.idKey,
  });
  FirebaseServise a1 = Get.find();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('mainFormData').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Container(
              // width: 500,
              // color: Colors.red,
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skeleton(
                    height: MediaQuery.of(context).size.height / 3.8,
                    width: MediaQuery.of(context).size.width / 4,
                  ),
                  SizedBox(
                    width: 5,
                  ),

                  ///
                  ////
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Skeleton(
                        height: MediaQuery.of(context).size.height / 15,
                        width: MediaQuery.of(context).size.width / 1.65,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Skeleton(
                        height: MediaQuery.of(context).size.height / 7.4,
                        width: MediaQuery.of(context).size.width / 2,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
        List<DocumentSnapshot> s1 = snapshot.data!.docs;

        return s1.length == a1.getDoc.length
            ? GestureDetector(
                onTap: () async {
                  await Get.bottomSheet(
                    Container(
                      height: MediaQuery.of(context).size.height / (2.5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ThemeController().themeApp == ThemeMode.light
                            ? Colors.white
                            : Color.fromARGB(255, 53, 52, 52),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            bottomSheetItem(
                              func: () {
                                Get.off(() => showQue(formId: idKey));
                              },
                              title: 'Questions',
                            ),
                            bottomSheetItem(
                              func: () {
                                Get.off(() => statisticsPage(
                                      formId: idKey,
                                    ));
                              },
                              title: 'Responses',
                            ),
                            bottomSheetItem(
                              func: () async {
                                await a1.DeleteForms(
                                    context: context, formId: idKey);
                                await Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => homePageScreen()),
                                    (route) => false);
                              },
                              title: 'Delete',
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              // height: 50,
                              width: MediaQuery.of(context).size.width / 2,
                              child: Divider(
                                color: Colors.black,
                                thickness: 2,
                              ),
                            ),
                            bottomSheetItem(
                              func: () {
                                Get.back();
                              },
                              title: 'Cencel'.tr,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: AnimationConfiguration.staggeredList(
                  duration: Duration(milliseconds: 1200),
                  position: index,
                  child: SlideAnimation(
                    horizontalOffset: 200,
                    child: FadeInAnimation(
                      duration: Duration(milliseconds: 400),
                      child: FormsScreen(
                        title: (s1 as dynamic)[index]['formTitle'],
                        description: (s1 as dynamic)[index]['formDecs'],
                        Date: (s1 as dynamic)[index]['formDate'],
                        queOfNumber: (s1 as dynamic)[index]['formQueOfNumber'],
                        icon: (s1 as dynamic)[index]['formIcon'],
                      ),
                    ),
                  ),
                ),
              )
            : FutureBuilder(
                future: a1.getInfByDoc(),
                builder: ((context, snapshot) => Container()));
      },
    );
  }
}
