import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sampleproject/Controller/FirebaseServise.dart';
import 'package:sampleproject/Themes/ThemeController.dart';
import 'package:sampleproject/main.dart';
import 'package:sampleproject/screens/homePageScreen.dart';
import 'package:sampleproject/widget/FormsScreen.dart';
import 'package:sampleproject/widget/Skeleton.dart';
import 'package:sampleproject/widget/answerType/showQue.dart';

class getAllItemByDoc extends StatefulWidget {
  int index;
  String idKey;
  getAllItemByDoc({
    required this.index,
    required this.idKey,
  });

  @override
  State<getAllItemByDoc> createState() => _getAllItemByDocState();
}

class _getAllItemByDocState extends State<getAllItemByDoc> {
  FirebaseServise a1 = Get.find();

  String? userId = pref.getString('key');
  @override
  void initState() {
    a1.isCompletedForm('${userId}');
    super.initState();
  }

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

        return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc('${userId}')
              .collection('fetchData')
              .doc('${widget.idKey}')
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Container(
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
            var s2 = snapshot.data!.data();

            return s1.length == a1.getDoc.length
                ? GestureDetector(
                    onTap: () async {
                      if ((s2 as dynamic)['isCompleted'] == false) {
                        await showDialog(
                          // barrierColor: Colors.red,
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Are you sure',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: ThemeController().themeApp ==
                                              ThemeMode.light
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'note : you can only enter once to the test',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          showQue(formId: widget.idKey),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Submit',
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text('Close'),
                              ),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: "This is completed form",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black45,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    },
                    child: AnimationConfiguration.staggeredList(
                      duration: Duration(milliseconds: 1200),
                      position: widget.index,
                      child: SlideAnimation(
                        horizontalOffset: 200,
                        child: FadeInAnimation(
                          duration: Duration(milliseconds: 400),
                          child: FormsScreen(
                            color: (s2 as dynamic)['isCompleted'] == false
                                ? null
                                : Color.fromARGB(255, 179, 214, 206),
                            title: (s1 as dynamic)[widget.index]['formTitle'],
                            description: (s1 as dynamic)[widget.index]
                                ['formDecs'],
                            Date: (s1 as dynamic)[widget.index]['formDate'],
                            queOfNumber: (s1 as dynamic)[widget.index]
                                ['formQueOfNumber'],
                            icon: (s1 as dynamic)[widget.index]['formIcon'],
                            isCompleted: (s2 as dynamic)['isCompleted'] == false
                                ? null
                                : 'isCompleted',
                          ),
                        ),
                      ),
                    ),
                  )
                : FutureBuilder(
                    future: Future.delayed(Duration(seconds: 1), () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => homePageScreen()),
                        (route) => false,
                      );
                    }),
                    builder: ((context, snapshot) => Container()),
                  );
          },
        );
      },
    );
  }
}
