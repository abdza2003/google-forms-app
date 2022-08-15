import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path/path.dart';
import 'package:sampleproject/Themes/ThemeController.dart';
import 'package:sampleproject/Themes/Themes.dart';
import 'package:sampleproject/main.dart';
import 'package:sampleproject/widget/FormsScreen.dart';
import 'package:sampleproject/widget/Skeleton.dart';
import 'package:sampleproject/widget/answerType/showQue.dart';
import 'package:sampleproject/widget/myButton.dart';

class getIsCompletedItem extends StatelessWidget {
  int index;
  String idKey;
  getIsCompletedItem({
    required this.index,
    required this.idKey,
  });
  String? userId = pref.getString('key');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('mainFormData')
          .doc('$idKey')
          .get(),
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
        var s1 = snapshot.data!.data();

        return GestureDetector(
          onTap: () {
            print('object');
            showDialog(
              context: context,
              builder: (BuildContext context) => Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ThemeController().themeApp == ThemeMode.dark
                          ? Color.fromARGB(255, 53, 52, 52)
                          : Colors.white,
                    ),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: getUserAnswer(),
                          ),
                        ),
                        myButton(
                          title: 'close',
                          myfunc: () {
                            Get.back();
                          },
                          height: MediaQuery.of(context).size.height / 18,
                          width: MediaQuery.of(context).size.width / 4,
                          padding: 10,
                        ),
                      ],
                    ),
                  )),
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
                  color: Color.fromARGB(255, 179, 214, 206),
                  title: (s1 as dynamic)['formTitle'],
                  description: (s1 as dynamic)['formDecs'],
                  Date: (s1 as dynamic)['formDate'],
                  queOfNumber: (s1 as dynamic)['formQueOfNumber'],
                  icon: (s1 as dynamic)['formIcon'],
                  isCompleted: 'comple',
                ),
              ),
            ),
          ),
        );
        ;
      },
    );

    /* AnimationConfiguration.staggeredList(
      duration: Duration(milliseconds: 1200),
      position: index,
      child: SlideAnimation(
        horizontalOffset: 200,
        child: FadeInAnimation(
          duration: Duration(milliseconds: 400),
          child: FormsScreen(),
        ),
      ),
    ); */
  }

  getUserAnswer() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users/${userId}/$idKey')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<DocumentSnapshot> s1 = snapshot.data!.docs;

        print('=========${s1.length}');
        return Column(
          children: List.generate(
            s1.length,
            (index) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '#${index + 1} Questions',
                  style: Themes().headLine3.copyWith(
                        fontSize: 20,
                        color: ThemeController().themeApp == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${s1[index]['title']}',
                  style: Themes().headLine2.copyWith(
                        color: ThemeController().themeApp == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Row(
                    children: [
                      s1[index]['queType'] == 'Short answer'
                          ? Icon(Icons.text_format_outlined)
                          : s1[index]['queType'] == 'Multiple choice'
                              ? CircleAvatar(
                                  backgroundColor: Colors.grey[500],
                                  radius: 10,
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Color.fromARGB(255, 223, 226, 228),
                                    radius: 6,
                                  ),
                                )
                              : Icon(Icons.check_box),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${s1[index]['queType']}',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${s1[index]['answer']}',
                  style: Themes().headLine4.copyWith(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Divider(
                    color: Colors.black54,
                    thickness: 1.2,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
