import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sampleproject/Firebase/Auth.dart';
import 'package:sampleproject/Themes/ThemeController.dart';
import 'package:sampleproject/Themes/Themes.dart';
import 'package:sampleproject/main.dart';
import 'package:sampleproject/screens/homePageScreen.dart';
import 'package:sampleproject/widget/myButton.dart';

class authScreen extends StatefulWidget {
  AuthMode authMode;
  authScreen({required this.authMode});
  @override
  State<authScreen> createState() => _authScreenState();
}

enum AuthMode {
  Login,
  SignUp,
}

class _authScreenState extends State<authScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController _email = new TextEditingController(text: '');
  TextEditingController _password = new TextEditingController(text: '');
  TextEditingController _userName = new TextEditingController(text: '');

  bool showPass = true;
  bool newAccount = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              opacity: .5,
              image: AssetImage('images/s2.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 25),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.authMode != AuthMode.SignUp
                        ? 'Welcome back, '
                        : 'Create account. ',
                    style: Themes().headLine3.copyWith(
                          color: Colors.black,
                          fontSize: 30,
                        ),
                  ),
                  Text(
                    widget.authMode != AuthMode.SignUp
                        ? 'sign in to continue '
                        : 'sign up to continue ',
                    style: Themes().headLine2.copyWith(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      padding: EdgeInsets.all(20),
                      height: widget.authMode == AuthMode.SignUp
                          ? MediaQuery.of(context).size.width / .78
                          : MediaQuery.of(context).size.width / .96,
                      width: MediaQuery.of(context).size.width / .9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            AnimatedContainer(
                                duration: Duration(milliseconds: 400),
                                constraints: BoxConstraints(
                                  minHeight: widget.authMode == AuthMode.SignUp
                                      ? MediaQuery.of(context).size.width / 3.6
                                      : 0,
                                  maxHeight: widget.authMode == AuthMode.SignUp
                                      ? MediaQuery.of(context).size.width / 3.6
                                      : 0,
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      getForm(
                                        label: 'User Name',
                                        icon: FontAwesomeIcons.user,
                                        textEditingController: _userName,
                                      ),
                                    ],
                                  ),
                                )),
                            getForm(
                              label: 'E-mail Address',
                              icon: Icons.email,
                              textEditingController: _email,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            getForm(
                              label: 'Password',
                              icon: Icons.lock,
                              textEditingController: _password,
                              showPass: showPass,
                              sufficIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    showPass = !showPass;
                                  });
                                },
                                icon: Icon(
                                  !showPass
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                            isLoading == false
                                ? Column(
                                    children: [
                                      myButton(
                                        title:
                                            widget.authMode != AuthMode.SignUp
                                                ? 'Login'
                                                : 'SIGN UP',
                                        myfunc: _submit,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                13,
                                        padding:
                                            MediaQuery.of(context).size.width /
                                                20,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.4,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            widget.authMode == AuthMode.SignUp
                                                ? 'already have a account ?!  '
                                                : 'Don\'t have account ?!  ',
                                            style: TextStyle(
                                              color:
                                                  ThemeController().themeApp ==
                                                          ThemeMode.light
                                                      ? Colors.black
                                                      : Colors.white,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (widget.authMode ==
                                                    AuthMode.Login) {
                                                  widget.authMode =
                                                      AuthMode.SignUp;
                                                } else {
                                                  widget.authMode =
                                                      AuthMode.Login;
                                                }
                                              });
                                            },
                                            child: Text(
                                              widget.authMode == AuthMode.SignUp
                                                  ? 'Login'
                                                  : 'create account now',
                                              style: GoogleFonts.roboto(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.teal,
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationThickness: 2,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    // color: Colors.red,
                                    padding: EdgeInsets.only(top: 50),
                                    child: CircularProgressIndicator(),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
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
          style: Themes().headLine3.copyWith(fontSize: 22),
        ),
        TextFormField(
          controller: textEditingController,
          obscureText: showPass == null
              ? false
              : showPass == false
                  ? false
                  : true,
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

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      return;
    } else {
      FocusScope.of(context).unfocus();
      _formKey.currentState!.save();
    }
    print('email : ${_email.text}');
    print('password :${_password.text}');
    print('user : ${_userName.text}');
    setState(() {
      isLoading = true;
    });
    try {
      if (widget.authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false).login(
          _email.text,
          _password.text,
        );
        var x = Provider.of<Auth>(context, listen: false).addNewUser;
        print('================== ${x[0].Id}');
        pref.setString('key', '${x[0].Id}');
        pref.setBool('fetch', true);
        Get.off(() => homePageScreen());
      } else {
        await Provider.of<Auth>(context, listen: false).signUp(
          _email.text,
          _password.text,
        );
        var x = Provider.of<Auth>(context, listen: false).addNewUser;
        newAccountInf(
          id: '${x[0].Id}',
          userName: _userName.text,
          email: _email.text,
          password: _password.text,
        );
        Get.off(() => homePageScreen());
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      var errorMessage = 'Authenticatio Faild';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      getSnackBar(errorMessage);
    }
  }

  bool isLoading = false;
  getSnackBar(String title) {
    Get.snackbar(
      'Wrong entry',
      '$title',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.teal[800],
      colorText: Colors.white,
      icon: Icon(Icons.error),
      margin: EdgeInsets.all(15),
    );
  }
}
