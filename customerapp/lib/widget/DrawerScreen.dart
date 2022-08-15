import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sampleproject/Themes/ThemeController.dart';
import 'package:sampleproject/main.dart';
import 'package:sampleproject/screens/authScreen.dart';
import 'package:sampleproject/screens/homePageScreen.dart';
import 'package:sampleproject/screens/profileScreen.dart';
import 'package:sampleproject/widget/Skeleton.dart';

class DrawerScreen extends StatelessWidget {
  String? idKey = pref.getString('key');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 15),
                width: double.infinity,
                color: Colors.cyan[800],
                child: FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc('$idKey')
                      .get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        color: Colors.cyan[800],
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Skeleton(
                              height: MediaQuery.of(context).size.height / 3,
                              width: MediaQuery.of(context).size.width / 4,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: C,
                              children: [
                                Skeleton(
                                  height:
                                      MediaQuery.of(context).size.height / 15,
                                  width:
                                      MediaQuery.of(context).size.width / 2.2,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Skeleton(
                                  height:
                                      MediaQuery.of(context).size.height / 7,
                                  width:
                                      MediaQuery.of(context).size.width / 2.2,
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }
                    var s1 = snapshot.data!.data();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => profileScreen());
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 50,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  (s1 as dynamic)['image_url'] == ''
                                      ? Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              6.2,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.3,
                                          padding: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white60,
                                          ),
                                          child: Image.asset(
                                            'images/s1.png',
                                          ),
                                        )
                                      : Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              5.7,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.1,
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white60,
                                          ),
                                          child: CachedNetworkImage(
                                            imageBuilder: (context, snapshot) {
                                              return Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white60,
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          '${(s1 as dynamic)['image_url']}'),
                                                      fit: BoxFit.cover,
                                                    )),
                                              );
                                            },

                                            // fit: BoxFit.cover,
                                            imageUrl:
                                                (s1 as dynamic)['image_url'],
                                            placeholder: (context, url) =>
                                                Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                AnimatedOpacity(
                                                  duration: Duration.zero,
                                                  opacity: .5,
                                                  child: Image.asset(
                                                    'images/s1.png',
                                                  ),
                                                ),
                                                CircularProgressIndicator(
                                                  color: Colors.cyan[700],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${(s1 as dynamic)['userName']}',
                                    style: GoogleFonts.rubik(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${(s1 as dynamic)['email']}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.8,
                                    // color: Colors.red,
                                    child: Text(
                                      (s1 as dynamic)['bio'] == ''
                                          ? 'no bio added yet ..!!'
                                          : '${(s1 as dynamic)['bio']}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              getDrawerItem(
                title: 'Home Page',
                function: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                      child: homePageScreen(),
                      type: PageTransitionType.leftToRight,
                    ),
                    (route) => false,
                  );
                },
                iconData: Icons.home,
              ),
              getDrawerItem(
                title: 'Profile',
                function: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                      child: profileScreen(),
                      type: PageTransitionType.leftToRight,
                    ),
                    (route) => false,
                  );
                },
                iconData: Icons.person,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: InkWell(
              onTap: () async {
                await pref.clear();
                Get.off(() => authScreen(authMode: AuthMode.Login));
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 3.7,
                height: MediaQuery.of(context).size.height / 15,
                // alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.cyan[800],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  getDrawerItem(
      {required String title, required function, required IconData iconData}) {
    return Padding(
      padding: EdgeInsets.all(3),
      child: InkWell(
        onTap: function,
        child: ListTile(
          title: Text(
            '$title',
            style: TextStyle(
              fontSize: 17,
              color: ThemeController().themeApp == ThemeMode.light
                  ? Colors.black
                  : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: Icon(iconData),
        ),
      ),
    );
  }
}
