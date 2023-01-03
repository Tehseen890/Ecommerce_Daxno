import 'package:ecommerce_daxno/core/constants/theme.dart';
import 'package:ecommerce_daxno/core/enums/view_state.dart';
import 'package:ecommerce_daxno/ui/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'authprovider.dart';
import "../../../core/extensions/string_ext.dart";
import 'registeration_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: ((context, model, child) {
        return Scaffold(
          body: ModalProgressHUD(
            inAsyncCall: model.state == ViewState.busy,
            progressIndicator: CircularProgressIndicator(),
            child: Container(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 35, bottom: 30),
              width: double.infinity,
              height: double.infinity,
              color: Colors.white70,
              child: Column(
                children: <Widget>[
                  Flexible(
                    flex: 5,
                    child: Form(
                      key: model.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "FORZIERI",
                              style: TextStyle(
                                fontSize: 25.sp,
                                letterSpacing: 3.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 45.h,
                          ),
                          CustomTextField(
                            textInputAction: TextInputAction.next,
                            controller: model.emailC,
                            hinttext: "Email",
                            prefixIcon: Icon(
                              Icons.alternate_email_outlined,
                              color: Colors.grey,
                            ),
                            validator: (email) {
                              if (!email!.isValidEmail) {
                                return "Please enter a valid email";
                              }
                            },
                          ),
                          // TextFormField(
                          //   showCursor: true,
                          //   decoration: InputDecoration(
                          //     border: OutlineInputBorder(
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(10.0)),
                          //       borderSide: BorderSide(
                          //         width: 0,
                          //         style: BorderStyle.none,
                          //       ),
                          //     ),
                          //     filled: true,
                          //     prefixIcon: Icon(
                          //       Icons.alternate_email_outlined,
                          //       color: Color(0xFF666666),
                          //     ),
                          //     fillColor: Color(0xFFF2F3F5),
                          //     hintStyle: TextStyle(
                          //       color: Color(0xFF666666),
                          //     ),
                          //     hintText: "Email",
                          //   ),
                          // ),

                          SizedBox(
                            height: 15,
                          ),
                          CustomTextField(
                            controller: model.passwordC,
                            hinttext: "Password",
                            prefixIcon: Icon(
                              color: Colors.grey,
                              Icons.lock_open_rounded,
                            ),
                            obscureText: model.showPassword,
                            sufFixIcon: IconButton(
                              onPressed: () {
                                model.togglePassWordVisibility();
                              },
                              icon: Icon(
                                Icons.remove_red_eye_outlined,
                                color: !model.showPassword
                                    ? primaryColor
                                    : Colors.grey,
                              ),
                            ),
                            validator: (password) {
                              if (password!.isEmpty) {
                                return "Please enter a password";
                              }
                            },
                          ),

                          // TextFormField(
                          //   showCursor: true,
                          //   decoration: InputDecoration(
                          //     border: OutlineInputBorder(
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(10.0)),
                          //       borderSide: BorderSide(
                          //         width: 0,
                          //         style: BorderStyle.none,
                          //       ),
                          //     ),
                          //     filled: true,
                          //     prefixIcon: Icon(
                          //       Icons.lock_outline,
                          //       color: Color(0xFF666666),
                          //     ),
                          //     suffixIcon: IconButton(
                          //       // splashColor: Colors.red,
                          //       onPressed: () {},
                          //       icon: Icon(
                          //         Icons.remove_red_eye,
                          //         color: Color(0xFF666666),
                          //       ),
                          //     ),
                          //     fillColor: Color(0xFFF2F3F5),
                          //     hintStyle: TextStyle(
                          //       color: Color(0xFF666666),
                          //     ),
                          //     hintText: "Password",
                          //   ),
                          // ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: double.infinity,
                            child: Text(
                              "Forgot your password?",
                              style: TextStyle(
                                color: Color(0xFF666666),
                                fontStyle: FontStyle.normal,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(17.0),
                                primary: Color(0xFFBC1F26),
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(15.0),
                                  side: BorderSide(
                                    color: Color(0xFFBC1F26),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                model.loginUser(context);
                              },
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Poppins-Medium.ttf',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFF2F3F7)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                color: Color(0xFF666666),
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.off(RegistrationScreen());
                            },
                            child: Container(
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Color(0xFFAC252B),
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
