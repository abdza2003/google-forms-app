import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampleproject/Controller/AuthMiddleware.dart';
import 'package:sampleproject/Controller/DatabaseApp.dart';
import 'package:sampleproject/Controller/FirebaseServise.dart';
import 'package:sampleproject/Controller/PushItemsToFirebase.dart';
import 'package:sampleproject/Themes/ThemeController.dart';
import 'package:sampleproject/Themes/Themes.dart';
import 'package:sampleproject/pages/statisticsPage.dart';
import 'package:sampleproject/screens/addFormScreen.dart';
import 'package:sampleproject/screens/homePageScreen.dart';
import 'package:sampleproject/screens/welcomeScreen.dart';
import 'package:sampleproject/widget/answerType/showQue.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences pref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  pref = await SharedPreferences.getInstance();
  runApp(myApp());
}

class myApp extends StatefulWidget {
  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  DatabaseApp s1 = Get.put(DatabaseApp());
  FirebaseServise s2 = Get.put(FirebaseServise());
  ThemeController s4 = Get.put(ThemeController());

  @override
  void initState() {
    s2.referenceCode();
    s2.RefreshItems();
    s2.getUsersByDoc();
    s2.getInfByDoc();

    // s2.DeleteForms();
    // s2.getAnswerQue();

    super.initState();
  }

  PushItemsToFirebase s3 = Get.put(PushItemsToFirebase());
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Themes().lightTheme,
      darkTheme: Themes().darkTheme,
      themeMode: s4.themeApp,
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => welcomeScreen(), middlewares: [
          AuthMiddleware(),
        ]),
        GetPage(
          name: '/homePageScreen',
          page: () => homePageScreen(),
        ),
      ],
    );
  }
}
