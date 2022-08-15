import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sampleproject/Controller/AuthMiddleware.dart';
import 'package:sampleproject/Controller/DatabaseApp.dart';
import 'package:sampleproject/Controller/FirebaseServise.dart';
import 'package:sampleproject/Firebase/Auth.dart';
import 'package:sampleproject/Themes/ThemeController.dart';
import 'package:sampleproject/Themes/Themes.dart';
import 'package:sampleproject/screens/authScreen.dart';
import 'package:sampleproject/screens/homePageScreen.dart';
import 'package:sampleproject/screens/profileScreen.dart';
import 'package:sampleproject/screens/welcomeScreen.dart';
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
  ThemeController s3 = Get.put(ThemeController());
  @override
  void initState() {
    s2.RefreshItems();
    s2.getUsersByDoc();

    super.initState();
  }

  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes().lightTheme,
        darkTheme: Themes().darkTheme,
        themeMode: s3.themeApp,
        // home: homePageScreen(),
        getPages: [
          GetPage(name: '/', page: () => welcomeScreen(), middlewares: [
            AuthMiddleware(),
          ]),
          GetPage(
            name: '/homePageScreen',
            page: () => homePageScreen(),
          ),
        ],
      ),
    );
  }
}
