import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:valdir_finance/src/ui/widgets/form_field_main.dart';
import 'package:valdir_finance/src/utils/values/colors.dart';

const double minHeight = 60.0;
const double maxHeight = 600.0;
const double minWidth = 250.0;
const double maxWidth = 400.0;
const double maxBottomButtonsMargin = 15.0;
const double minBottomButtonsMargin = -170.0;
const double maxFormsContainerMargin = 160.0;
const double minFormsContainerMargin = 20.0;

class LoginPage extends StatefulWidget {
  static const String routeName = 'login_page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  bool _loginContainerOpened = false;
  bool _signUpContainerOpened = false;

  double _loginContainerHeight = minHeight;
  double _loginContainerWidth = minWidth;

  double _signUpContainerHeight = minHeight;
  double _signUpContainerWidth = minWidth;

  double _formsContainerMargin = maxFormsContainerMargin;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _scaleDownSignUpButton() {
    if (_signUpContainerOpened) {
      _signUpContainerHeight = minHeight;
      _signUpContainerWidth = minWidth;
      _signUpContainerOpened = false;
    }
  }

  void _scaleDownLoginButton() {
    if (_loginContainerOpened) {
      _loginContainerHeight = minHeight;
      _loginContainerWidth = minWidth;
      _loginContainerOpened = false;
    }
  }

  void _toggleAuthButtonsScale(bool isLogin) {
    setState(() {
      if (isLogin) {
        _loginContainerHeight =
            _loginContainerHeight == maxHeight ? minHeight : maxHeight;
        _loginContainerWidth =
            _loginContainerWidth == maxWidth ? minWidth : maxWidth;
        _scaleDownSignUpButton();
        _loginContainerOpened = !_loginContainerOpened;
      } else {
        _signUpContainerHeight =
            _signUpContainerHeight == maxHeight ? minHeight : maxHeight;
        _signUpContainerWidth =
            _signUpContainerWidth == maxWidth ? minWidth : maxWidth;
        _scaleDownLoginButton();
        _signUpContainerOpened = !_signUpContainerOpened;
      }

      _formsContainerMargin = _formsContainerMargin == minFormsContainerMargin
          ? maxFormsContainerMargin
          : minFormsContainerMargin;
    });
  }

  void _toggleNuLogoAndGoogleButton() {
    final bool isAnyContainerAnimationCompleted =
        _controller.status == AnimationStatus.completed;

    _controller.fling(velocity: isAnyContainerAnimationCompleted ? -2 : 2);
  }

  double lerp(double min, double max) =>
      lerpDouble(min, max, _controller.value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.colorMainPurple,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned.fill(
                top: lerp(maxBottomButtonsMargin, minBottomButtonsMargin),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 60.0,
                        margin: EdgeInsets.only(top: 50.0),
                        child: Image.asset(
                          'assets/images/nulogo.png',
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        height: 60.0,
                        margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          ListView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                margin: EdgeInsets.only(top: _formsContainerMargin),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    /** Sign Up Button ---------*/
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 200),
                      child: _loginContainerOpened
                          ? Container()
                          : GestureDetector(
                              onTap: () {
                                if (!_loginContainerOpened &&
                                    !_signUpContainerOpened) {
                                  _toggleAuthButtonsScale(false);
                                  _toggleNuLogoAndGoogleButton();
                                }
                              },
                              child: AnimatedContainer(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(top: 5.0),
                                width: _signUpContainerWidth,
                                height: _signUpContainerHeight,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.fastOutSlowIn,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular((8.0)))),
                                child: AnimatedSwitcher(
                                    duration: Duration(milliseconds: 200),
                                    child: _signUpContainerOpened
                                        ? Container(
                                            alignment: Alignment.center,
                                            child: Stack(
                                              children: <Widget>[
                                                Positioned(
                                                  top: 5.0,
                                                  left: 5.0,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      if (_signUpContainerOpened) {
                                                        _toggleAuthButtonsScale(
                                                            false);
                                                        _toggleNuLogoAndGoogleButton();
                                                      }
                                                    },
                                                    child: Icon(Icons.close,
                                                        size: 40.0),
                                                  ),
                                                ),
                                                Positioned.fill(
                                                  top: 70.0,
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Column(
                                                      children: <Widget>[
                                                        // form fields
                                                        FormFieldMain(
                                                          hintText: "Email...",
                                                          onChanged: (value) {},
                                                          marginRight: 20.0,
                                                          marginLeft: 20.0,
                                                          marginTop: 0.0,
                                                          textInputType:
                                                              TextInputType
                                                                  .text,
                                                          obscured: false,
                                                        ),

                                                        FormFieldMain(
                                                          hintText:
                                                              "Password...",
                                                          onChanged: (value) {},
                                                          marginRight: 20.0,
                                                          marginLeft: 20.0,
                                                          marginTop: 15.0,
                                                          textInputType:
                                                              TextInputType
                                                                  .text,
                                                          obscured: true,
                                                        ),

                                                        FormFieldMain(
                                                          hintText:
                                                              "Display Name...",
                                                          onChanged: (value) {},
                                                          marginRight: 20.0,
                                                          marginLeft: 20.0,
                                                          marginTop: 15.0,
                                                          textInputType:
                                                              TextInputType
                                                                  .text,
                                                          obscured: false,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Positioned.fill(
                                                  bottom: 25.0,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: GestureDetector(
                                                        onTap: () {},
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 30.0,
                                                                  right: 30.0),
                                                          alignment:
                                                              Alignment.center,
                                                          height: 60.0,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                      .transparent,
                                                                  border: Border
                                                                      .all(
                                                                    width: 1,
                                                                    color: ColorConstant
                                                                        .colorMainPurple,
                                                                  )),
                                                          child: Text(
                                                            'Sign Up',
                                                            style: TextStyle(
                                                              color: ColorConstant
                                                                  .colorMainPurple,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 20.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Text(
                                            'Sign Up',
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 25.0,
                                            ),
                                          )),
                              ),
                            ),
                    ),
                    /** End Sign Up Button ---------*/
                    /** Login Button ---------*/
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 200),
                      child: _signUpContainerOpened
                          ? Container()
                          : GestureDetector(
                              onTap: () {
                                if (!_loginContainerOpened &&
                                    !_signUpContainerOpened) {
                                  _toggleAuthButtonsScale(true);
                                  _toggleNuLogoAndGoogleButton();
                                }
                              },
                              child: AnimatedContainer(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(top: 5.0),
                                width: _loginContainerWidth,
                                height: _loginContainerHeight,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.fastOutSlowIn,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular((8.0)))),
                                child: AnimatedSwitcher(
                                    duration: Duration(milliseconds: 200),
                                    child: _loginContainerOpened
                                        ? Container(
                                            alignment: Alignment.center,
                                            child: Stack(
                                              children: <Widget>[
                                                Positioned(
                                                  top: 5.0,
                                                  left: 5.0,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      if (_loginContainerOpened) {
                                                        _toggleAuthButtonsScale(true);
                                                        _toggleNuLogoAndGoogleButton();
                                                      }
                                                    },
                                                    child: Icon(Icons.close,
                                                        size: 40.0),
                                                  ),
                                                ),
                                                Positioned.fill(
                                                  top: 70.0,
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Column(
                                                      children: <Widget>[
                                                        // form fields
                                                        FormFieldMain(
                                                          hintText: "Email...",
                                                          onChanged: (value) {},
                                                          marginRight: 20.0,
                                                          marginLeft: 20.0,
                                                          marginTop: 0.0,
                                                          textInputType:
                                                              TextInputType
                                                                  .text,
                                                          obscured: false,
                                                        ),

                                                        FormFieldMain(
                                                          hintText:
                                                              "Password...",
                                                          onChanged: (value) {},
                                                          marginRight: 20.0,
                                                          marginLeft: 20.0,
                                                          marginTop: 15.0,
                                                          textInputType:
                                                              TextInputType
                                                                  .text,
                                                          obscured: true,
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Positioned.fill(
                                                  bottom: 25.0,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: GestureDetector(
                                                        onTap: () {},
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 30.0,
                                                                  right: 30.0),
                                                          alignment:
                                                              Alignment.center,
                                                          height: 60.0,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                      .transparent,
                                                                  border: Border
                                                                      .all(
                                                                    width: 1,
                                                                    color: ColorConstant
                                                                        .colorMainPurple,
                                                                  )),
                                                          child: Text(
                                                            'Login',
                                                            style: TextStyle(
                                                              color: ColorConstant
                                                                  .colorMainPurple,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 20.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Text(
                                            'Login',
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 25.0,
                                            ),
                                          )),
                              ),
                            ),
                    ),
                    /** End Login Button ---------*/
                  ],
                ),
              ),
            ],
          ),

          /** Sign in with Google Button ------------*/
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned.fill(
                bottom: lerp(maxBottomButtonsMargin, minBottomButtonsMargin),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(bottom: 15.0),
                      height: 55.0,
                      child: ClipOval(
                          child: Container(
                        padding: EdgeInsets.all(10.0),
                        color: Colors.white,
                        child: Image.asset('assets/images/googleicon.png'),
                      )),
                    ),
                  ),
                ),
              );
            },
          ),
          /** End Sign in with Google Button ------------*/
        ],
      ),
    );
  }
}
