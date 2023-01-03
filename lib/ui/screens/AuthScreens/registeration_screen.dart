import 'package:ecommerce_daxno/core/constants/theme.dart';
import 'package:ecommerce_daxno/core/extensions/string_ext.dart';

import 'package:ecommerce_daxno/ui/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../core/enums/view_state.dart';
import 'authprovider.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, model, child) {
        return Scaffold(
          body: SafeArea(
            child: InkWell(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ModalProgressHUD(
                inAsyncCall: model.state == ViewState.busy,
                progressIndicator: CircularProgressIndicator(),
                child: Container(
                  padding: EdgeInsets.only(
                      left: 20, right: 20, top: 45.h, bottom: 30),
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white70,
                  child: Form(
                    key: model.signUpFormKey,
                    child: SingleChildScrollView(
                      child: Column(
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
                            height: 55,
                          ),
                          CustomTextField(
                            textInputAction: TextInputAction.next,
                            hinttext: "Name",
                            controller: model.nameC,
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomTextField(
                            textInputAction: TextInputAction.next,
                            hinttext: "Email",
                            controller: model.emailC,
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
                          SizedBox(
                            height: 15,
                          ),
                          CustomTextField(
                            textInputAction: TextInputAction.next,
                            hinttext: "Phone Number",
                            controller: model.phoneC,
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.grey,
                            ),
                            validator: (phone) {
                              if (phone!.isEmpty) {
                                return "Enter a phone number";
                              }
                            },
                            inputFormatter: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyBoardType: TextInputType.number,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomTextField(
                            textInputAction: TextInputAction.next,
                            hinttext: "Password",
                            controller: model.passwordC,
                            obscureText: !model.showPassword,
                            prefixIcon: Icon(
                              color: Colors.grey,
                              model.showPassword
                                  ? Icons.lock_open_rounded
                                  : Icons.lock_outline_rounded,
                            ),
                            sufFixIcon: IconButton(
                              onPressed: () {
                                model.togglePassWordVisibility();
                              },
                              icon: Icon(
                                Icons.remove_red_eye_outlined,
                                color: model.showPassword
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
                          SizedBox(
                            height: 15,
                          ),
                          CustomTextField(
                            textInputAction: TextInputAction.next,
                            hinttext: "Confirm Password",
                            controller: model.confirmPasswordC,
                            prefixIcon: Icon(
                              color: Colors.grey,
                              model.showPassword
                                  ? Icons.lock_open_rounded
                                  : Icons.lock_outline_rounded,
                            ),
                            obscureText: !model.showPassword,
                            sufFixIcon: IconButton(
                              onPressed: () {
                                model.togglePassWordVisibility();
                              },
                              icon: Icon(
                                Icons.remove_red_eye_outlined,
                                color: model.showPassword
                                    ? primaryColor
                                    : Colors.grey,
                              ),
                            ),
                            validator: (password) {
                              if (model.confirmPasswordC.text !=
                                  model.passwordC.text) {
                                return "Password does not match";
                              }
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          FormField<bool>(
                            validator: (value) {
                              if (!model.agreeToTerms)
                                return "You must agree to Terms & Privacy Policy\n\n\n";
                            },
                            builder: (formFieldState) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        activeColor: primaryColor,
                                        value: model.agreeToTerms,
                                        onChanged: (value) {
                                          model.agreeToTerms = value ?? true;
                                          model.notifyListeners();
                                        },
                                      ),
                                      RichText(
                                        softWrap: true,
                                        text: TextSpan(
                                          text: "I accept the",
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 12.sp,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: " Terms of Use",
                                              style: TextStyle(
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                            TextSpan(
                                              text: " &",
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                            TextSpan(
                                              text: " Privacy Policy",
                                              style: TextStyle(
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (formFieldState.hasError)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, top: 10),
                                      child: Text(
                                        formFieldState.errorText!,
                                        style: TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 13,
                                            color: Colors.red[700],
                                            height: 0.5),
                                      ),
                                    )
                                ],
                              );
                            },
                          ),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(17.0),
                                primary: Color(0xFFBC1F26),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(15.0),
                                    side: BorderSide(color: Color(0xFFBC1F26))),
                              ),
                              onPressed: () {
                                model.signUpUser(context);
                              },
                              child: Text(
                                "Sign Up",
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
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "Already have an account? ",
                                    style: TextStyle(
                                      color: Color(0xFF666666),
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.off(LoginScreen());
                                  },
                                  child: Container(
                                    child: Text(
                                      "Sign In",
                                      style: TextStyle(
                                        color: Color(0xFFAC252B),
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      // child:
    );
  }
}
