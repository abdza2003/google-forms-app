import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sampleproject/Controller/FirebaseServise.dart';
import 'package:sampleproject/Themes/ThemeController.dart';
import 'package:sampleproject/Themes/Themes.dart';
import 'package:sampleproject/extra/getCompletedFormWithDoc.dart';
import 'package:sampleproject/main.dart';
import 'package:sampleproject/widget/DrawerScreen.dart';
import 'package:sampleproject/widget/FormsScreen.dart';
import 'package:sampleproject/widget/Skeleton.dart';
import 'package:sampleproject/widget/myButton.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class profileScreen extends StatefulWidget {
  const profileScreen({Key? key}) : super(key: key);

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  String? idKey = pref.getString('key');
  TextEditingController _UpdateBio = new TextEditingController();
  TextEditingController _UpdateUserName = new TextEditingController();
  FirebaseServise s2 = Get.find();

  @override
  void initState() {
    s2.isCompletedForm('$idKey');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      drawer: Drawer(
        child: DrawerScreen(),
      ),
      body: SafeArea(
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc('$idKey')
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                // color: Colors.cyan[800],
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Skeleton(
                      height: MediaQuery.of(context).size.height / 1.8,
                      width: MediaQuery.of(context).size.width / 2,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: C,
                      children: [
                        Skeleton(
                          height: MediaQuery.of(context).size.height / 7,
                          width: MediaQuery.of(context).size.width / 2.2,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Skeleton(
                          height: MediaQuery.of(context).size.height / 7,
                          width: MediaQuery.of(context).size.width / 2.2,
                        ),
                      ],
                    )
                  ],
                ),
              );
            }
            var s1 = snapshot.data!.data();

            return Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'My',
                        style: GoogleFonts.oleoScriptSwashCaps(fontSize: 45),
                      ),
                      Text(
                        'Profile',
                        style: GoogleFonts.oleoScriptSwashCaps(fontSize: 45),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topCenter,
                        children: [
                          Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              // width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.centerRight,

                                    width: double.infinity,
                                    padding: EdgeInsets.all(10),
                                    // color: Colors.red,
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: PopupMenuButton(
                                          color: ThemeController().themeApp ==
                                                  ThemeMode.light
                                              ? Colors.white
                                              : Colors.black,
                                          icon: Icon(
                                            Icons.settings,
                                            color: Colors.black,
                                          ),
                                          onSelected: (item) =>
                                              onSelected(context, item as int),
                                          itemBuilder: (context) => [
                                                PopupMenuItem(
                                                  value: 0,
                                                  child: Text('edit user name'),
                                                ),
                                                PopupMenuItem(
                                                  value: 1,
                                                  child: Text(
                                                      'edit profile photo'),
                                                ),
                                                PopupMenuItem(
                                                  value: 2,
                                                  child: Text('edit your bio'),
                                                ),
                                              ]),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${(s1 as dynamic)['userName']}',
                                          style: GoogleFonts.secularOne(
                                            fontSize: 25,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Container(
                                          // color: Colors.red,
                                          width: 300,
                                          margin: EdgeInsets.only(right: 20),
                                          child: Text(
                                            (s1 as dynamic)['bio'] == ''
                                                ? 'no bio added yet ..!!'
                                                : '${(s1 as dynamic)['bio']}',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(0, -70),
                            child: isLoading == false
                                ? CircleAvatar(
                                    radius: 70,
                                    backgroundColor:
                                        Color.fromARGB(255, 223, 226, 228),
                                    child: (s1 as dynamic)['image_url'] != ''
                                        ? ClipOval(
                                            child: CachedNetworkImage(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  5.8,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              fit: BoxFit.cover,
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
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              7,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              4,
                                                    ),
                                                  ),
                                                  CircularProgressIndicator(
                                                    color: Colors.cyan[700],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Stack(
                                            alignment: Alignment.bottomLeft,
                                            children: [
                                              CircleAvatar(
                                                radius: 55,
                                                backgroundColor: Colors.white,
                                                child: AnimatedOpacity(
                                                  duration: Duration.zero,
                                                  opacity: .5,
                                                  child: Image.asset(
                                                    'images/s1.png',
                                                    width: 80,
                                                    height: 80,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  )
                                : Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 70,
                                        backgroundColor:
                                            Color.fromARGB(255, 223, 226, 228),
                                        child: AnimatedOpacity(
                                          duration: Duration.zero,
                                          opacity: .5,
                                          child: Image.asset(
                                            'images/s1.png',
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                7,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                          ),
                                        ),
                                      ),
                                      CircularProgressIndicator(
                                        color: Colors.cyan,
                                      ),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Completed Form\'s',
                                style: Themes().headLine3.copyWith(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.42,
                                child: Divider(
                                  color: Colors.black54,
                                  thickness: 1.2,
                                ),
                              ),
                              FutureBuilder(
                                future: s2.isCompletedForm('${idKey}'),
                                builder: (context, snapshot) => Container(
                                  alignment: Alignment.topCenter,
                                  width: 400,
                                  height:
                                      MediaQuery.of(context).size.height / 1.85,
                                  child: s2.isCompletedFormDoc.isEmpty
                                      ? formIsEmpty(context)
                                      : getCompletedFormWithDoc(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.cyan[800],
        onPressed: () async {
          setState(() {
            s2.isCompletedForm('${idKey}');
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
        ),
      ),
    );
  }

  bool isLoading = false;
  Random x = new Random();
  formIsEmpty(BuildContext context) {
    return AnimationConfiguration.staggeredGrid(
      columnCount: 0,
      position: 0,
      child: ScaleAnimation(
        duration: Duration(milliseconds: 1500),
        child: FadeInAnimation(
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
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
                        width: MediaQuery.of(context).size.width / (1.6),
                        child: Text(
                          'no form has been completed yet ..!!',
                          style: Themes().headLine3.copyWith(
                              fontSize:
                                  MediaQuery.of(context).size.width / (22.6),
                              color: Colors.black.withOpacity(.6)),
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

  void onSelected(BuildContext context, int item) async {
    switch (item) {
      case 0:
        updateUserInf(
            title: 'Edit Username',
            hintTitle: 'Edit your username',
            label: 'Username',
            controller: _UpdateUserName,
            func: () async {
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc('$idKey')
                  .update({
                'userName': _UpdateUserName.text,
              });
              Get.back();
            });

        break;
      case 1:
        final ImagePicker _picker = ImagePicker();
        File? pickedImage;

        final image = await _picker.pickImage(
            source: ImageSource.gallery, imageQuality: 60);
        if (image == null) {
          return;
        }
        setState(() {
          isLoading = true;
          pickedImage = File(image.path);
        });

        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child('${idKey}${x.nextInt(1000)}.jpg');
        var urlImage;
        if (pickedImage != null) {
          await ref.putFile(pickedImage!);
          urlImage = await ref.getDownloadURL();
          await ref.putFile(pickedImage!);
        } else {
          urlImage =
              'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png';
        }
        await FirebaseFirestore.instance
            .collection('users')
            .doc('${idKey}')
            .update({
          'image_url': urlImage,
        });
        setState(() {
          isLoading = false;
        });

        break;
      case 2:
        updateUserInf(
          title: 'Edit Bio',
          hintTitle: 'Edit your bio',
          label: 'Bio',
          controller: _UpdateBio,
          func: () async {
            await FirebaseFirestore.instance
                .collection('users')
                .doc('$idKey')
                .update({
              'bio': _UpdateBio.text,
            });
            Get.back();
          },
          maxChar: 120,
        );
        break;
    }
  }

  Future updateUserInf(
      {required String title,
      required String hintTitle,
      required String label,
      required TextEditingController controller,
      var func,
      var maxChar}) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: ThemeController().themeApp == ThemeMode.light
                ? Colors.black
                : Colors.white,
          ),
        ),
        content: TextField(
          controller: controller,
          style: TextStyle(
            color: ThemeController().themeApp == ThemeMode.light
                ? Colors.black
                : Colors.white,
          ),
          autofocus: true,
          decoration: InputDecoration(
            hintText: hintTitle,
            label: Text('$label'),
            border: OutlineInputBorder(),
          ),
          maxLength: maxChar ?? 30,
        ),
        actions: [
          ElevatedButton(
            onPressed: func,
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
  }
}
