import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerScreen extends StatelessWidget {
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
                height: 300,
                width: double.infinity,
                color: Colors.cyan[800],
                child: Column(
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
                    Row(
                      children: [
                        SizedBox(
                          width: 50,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              width: 120,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white60,
                              ),
                              child: Image.asset(
                                'images/s1.png',
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Ryan',
                              style: GoogleFonts.rubik(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'ID:0023-Ryan',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: 220,
                              // color: Colors.red,
                              child: Text(
                                'my name is abdulrahim 18 years old selcuk universiy reading',
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
                  ],
                ),
              ),
              getDrawerItem(
                title: 'Home Page',
                function: () {},
                iconData: Icons.home,
              ),
              getDrawerItem(
                title: 'Profile',
                function: () {},
                iconData: Icons.person,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: InkWell(
              onTap: () {
                print('object');
              },
              child: Container(
                width: 100,
                height: 50,
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
        onTap: () {
          print('object');
        },
        child: ListTile(
          title: Text(
            '$title',
            style: TextStyle(
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: Icon(iconData),
        ),
      ),
    );
  }
}
