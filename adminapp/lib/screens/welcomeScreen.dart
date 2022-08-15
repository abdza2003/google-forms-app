import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sampleproject/Controller/FirebaseServise.dart';
import 'package:sampleproject/Themes/ThemeController.dart';
import 'package:sampleproject/Themes/Themes.dart';
import 'package:sampleproject/main.dart';
import 'package:sampleproject/screens/homePageScreen.dart';
import 'package:sampleproject/widget/myButton.dart';

class welcomeScreen extends StatefulWidget {
  @override
  State<welcomeScreen> createState() => _welcomeScreenState();
}

class _welcomeScreenState extends State<welcomeScreen> {
  TextEditingController _referansCode = new TextEditingController();

  TextEditingController _userName = new TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();
  FirebaseServise a1 = Get.find();
  bool showError = false;
  Random _rnd = Random();

  String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  @override
  void initState() {
    a1.referenceCode();
    a1.refreshReferencCode(getRandomString(6));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: Card(
              elevation: 10,
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 20,
                vertical: MediaQuery.of(context).size.width / 15,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(20),
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    image: DecorationImage(
                      opacity: .2,
                      image: AssetImage('images/80532.jpg'),
                      fit: BoxFit.cover,
                    )),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome To',
                        style: Themes()
                            .headLine3
                            .copyWith(fontSize: 40, color: Colors.black),
                      ),
                      Text(
                        'Managers App',
                        style: Themes()
                            .headLine3
                            .copyWith(fontSize: 25, color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        'images/s1.png',
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width / 2,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      getForm(
                        label: 'Referans Code',
                        icon: Icons.lock,
                        textEditingController: _referansCode,
                        validator: (val) {
                          if (val.toString().isEmpty ||
                              a1.referanceCode != _referansCode.text) {
                            return 'invalid input, please try again ...  ';
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            'You don\'t have a code ? ',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await FirebaseFirestore.instance
                                  .collection('fetchAdmin')
                                  .doc('referenceCode')
                                  .set({
                                'referenceCode': '${getRandomString(6)}',
                              });
                              Fluttertoast.showToast(
                                msg:
                                    "You can contact the admin to get the reference code",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black45,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              await a1.referenceCode();
                            },
                            child: Text(
                              'Click here .. ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.cyan[800],
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          )
                        ],
                      ),
                      myButton(
                        title: 'Continue',
                        myfunc: () async {
                          await a1.referenceCode();
                          if (!_formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            return;
                          } else {
                            FocusScope.of(context).unfocus();
                            _formKey.currentState!.save();
                          }
                          if (a1.referanceCode == _referansCode.text) {
                            pref.setBool('fetch', true);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => homePageScreen()),
                              (route) => false,
                            );
                          }
                        },
                        width: MediaQuery.of(context).size.width / 2.8,
                        height: MediaQuery.of(context).size.height / 15,
                        padding: 25,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  getForm({
    required String label,
    required IconData icon,
    required TextEditingController textEditingController,
    var validator,
    var sufficIcon,
    var showPass,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label',
          style: Themes().headLine3.copyWith(fontSize: 20),
        ),
        TextFormField(
          controller: textEditingController,
          style: TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: Colors.black54,
              ),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              hintText: '${label}',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              hintStyle: TextStyle(
                color: Colors.black45,
              ),
              suffixIcon: sufficIcon),
          validator: validator,
          onSaved: (val) {
            textEditingController.text = val as String;
          },
        ),
      ],
    );
  }
}
