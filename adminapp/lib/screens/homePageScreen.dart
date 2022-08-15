import 'dart:ffi';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sampleproject/Controller/FirebaseServise.dart';
import 'package:sampleproject/Themes/ThemeController.dart';
import 'package:sampleproject/Themes/Themes.dart';
import 'package:sampleproject/main.dart';
import 'package:sampleproject/pages/getformswithDoc.dart';
import 'package:sampleproject/screens/addFormScreen.dart';
import 'package:sampleproject/screens/welcomeScreen.dart';
import 'package:sampleproject/widget/FormsScreen.dart';
import 'package:sampleproject/widget/myButton.dart';

class homePageScreen extends StatefulWidget {
  @override
  State<homePageScreen> createState() => _homePageScreenState();
}

class _homePageScreenState extends State<homePageScreen> {
  FirebaseServise s1 = Get.find();
  ThemeController s2 = Get.put(ThemeController());

  @override
  void initState() {
    s1.getDoc = [];
    s1.RefreshItems();
    s1.getInfByDoc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('${MediaQuery.of(context).size.height}');
    print('${MediaQuery.of(context).size.width}');
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.cyan[800],
          onPressed: () {
            setState(() {
              s1.RefreshItems();
            });
          },
          label: Text(
            'Refresh',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          icon: Icon(
            Icons.refresh,
            color: Colors.white,
          )),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              s2.themeApp == ThemeMode.dark ? Icons.sunny : Icons.dark_mode,
            ),
            onPressed: () {
              setState(() {
                s2.ChangeTheme();
              });
            },
          ),
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () async {
                await pref.clear();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => welcomeScreen()),
                  (route) => false,
                );
              },
              icon: Icon(Icons.logout),
            ),
          )
        ],
        title: Text('Home Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            headPage(context),
            getData(context),
          ],
        ),
      ),
    );
  }

  formIsEmpty(BuildContext context) {
    return AnimationConfiguration.staggeredGrid(
      columnCount: 0,
      position: 0,
      child: ScaleAnimation(
        duration: Duration(milliseconds: 1500),
        child: FadeInAnimation(
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: RefreshIndicator(
              onRefresh: () async {
                /*   await FirebaseFirestore.instance
                            .collection('/newAccount/${idKey}/note')
                            .snapshots(); */
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'images/266c29a5d874af62d87413456e07d700.svg',
                      height: MediaQuery.of(context).size.height / (6.2),
                      width: MediaQuery.of(context).size.width / (6.2),
                      color: Colors.cyan[700],
                    ),
                    Transform.translate(
                      offset: Offset(0, 20),
                      child: Container(
                        // color: Colors.red,
                        width: MediaQuery.of(context).size.width / (1.4),
                        child: Text(
                          'No forms have been added yet ..!!',
                          style: Themes().headLine3.copyWith(
                                fontSize:
                                    MediaQuery.of(context).size.width / (22.6),
                                color: ThemeController().themeApp ==
                                        ThemeMode.light
                                    ? Colors.black.withOpacity(.6)
                                    : Colors.white.withOpacity(.6),
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  headPage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'today',
              style: Themes().headLine3.copyWith(
                    fontSize: MediaQuery.of(context).size.width / (18.6),
                  ),
            ),
            Text(
              '${DateFormat.yMEd().format(DateTime.now())}',
              style: Themes().headLine3.copyWith(
                    fontSize: MediaQuery.of(context).size.width / (20.6),
                  ),
            ),
          ],
        ),
        Container(
          // alignment: Alignment.center,
          width: MediaQuery.of(context).size.width / 2.8,
          height: MediaQuery.of(context).size.height / 16,
          child: ElevatedButton(
            onPressed: () {
              Get.to(() => addFormScreen());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add),
                Text(
                  'Add Form',
                  style: Themes().headLine2.copyWith(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  getData(BuildContext context) {
    if (s1.getDoc.isEmpty) {
      return formIsEmpty(context);
    } else {
      return Expanded(child: getformswithDoc());
    }
  }
}
