import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sampleproject/Themes/Themes.dart';
import 'package:sampleproject/screens/authScreen.dart';
import 'package:sampleproject/widget/myButton.dart';

class welcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Card(
            elevation: 10,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome To',
                    style: Themes()
                        .headLine1
                        .copyWith(fontSize: 32, color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    'images/s1.png',
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.width / 3.5,
                  ),
                  Text(
                    'Quiz App',
                    style: Themes()
                        .headLine3
                        .copyWith(fontSize: 25, color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width / 1.5,
                    // color: Colors.red,
                    child: Text(
                      'Are you ready to learn cultural things easily and the funniest way ?!!',
                      textAlign: TextAlign.center,
                      style: Themes()
                          .headLine2
                          .copyWith(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  myButton(
                      title: 'Get Started',
                      myfunc: () {
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                            duration: Duration(milliseconds: 400),
                            type: PageTransitionType.bottomToTop,
                            child: authScreen(
                              authMode: AuthMode.SignUp,
                            ),
                          ),
                        );
                      },
                      width: MediaQuery.of(context).size.width / 1.3,
                      height: MediaQuery.of(context).size.height / 15,
                      padding: 20),
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Already have an account ?!',
                          style: Themes()
                              .headLine1
                              .copyWith(fontSize: 15, color: Colors.black),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: (() {
                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                duration: Duration(milliseconds: 400),
                                type: PageTransitionType.bottomToTop,
                                child: authScreen(
                                  authMode: AuthMode.Login,
                                ),
                              ),
                            );
                          }),
                          child: Text(
                            'Log in',
                            style: GoogleFonts.roboto(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.cyan[800],
                              decoration: TextDecoration.underline,
                              decorationThickness: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
