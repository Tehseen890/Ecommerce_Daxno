import 'package:ecommerce_daxno/core/models/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/enums/view_state.dart';
import '../../../core/locator.dart';
import '../../../core/models/app_user.dart';
import '../../../core/services/auth_services.dart';
import '../../../core/services/custom_auth_result.dart';
import '../../widgets/custom_snackbar.dart';
import '../wrapper/bottom_navigation.dart';

class AuthProvider extends BaseViewModal {
  AuthProvider() {
    print("AuthenticationPRovider built");
  }

  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController confirmPasswordC = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final signUpFormKey = GlobalKey<FormState>();

  bool showPassword = false;
  bool agreeToTerms = false;

  final _authServices = locator<AuthServices>();
  CustomAuthResult customAuthResult = CustomAuthResult();
  AppUser appUser = AppUser();

  togglePassWordVisibility() {
    showPassword = !showPassword;
    notifyListeners();
  }

  ///
  signUpUser(context) async {
    if (signUpFormKey.currentState!.validate()) {
      appUser.userEmail = emailC.text;
      appUser.userName = nameC.text;

      //

      setState(ViewState.busy);
      appUser.createdAt = DateTime.now();

      customAuthResult = await _authServices.signUpUser(
        appUser,
        passwordC.text,
      );
      setState(ViewState.idle);
      if (customAuthResult.user != null) {
        print("SignUpUserId=> ${_authServices.appUser.appUserId}");
        clearAuthProvider();
        Get.off(BottomNavigation());
      } else {
        setState(ViewState.idle);
        print(customAuthResult.errorMessage.toString());
        customSnackBar(
          context,
          "${customAuthResult.errorMessage}",
        );
      }
    } else {
      setState(ViewState.idle);
      print("not showing true");
    }
    //
  }

  ///

  loginUser(BuildContext context) async {
    try {
      if (formKey.currentState!.validate()) {
        print("App user email: ${appUser.userEmail}");

        appUser.userEmail = emailC.text;
        setState(ViewState.busy);
        customAuthResult =
            await _authServices.loginUser(appUser, passwordC.text);

        setState(ViewState.idle);

        if (customAuthResult.status!) {
          print("App user Id: ${_authServices.appUser.appUserId}");
          clearAuthProvider();
          Get.off(BottomNavigation());
        } else {
          //      }
          customSnackBar(
            context,
            "${customAuthResult.errorMessage}",
            // behavior: SnackBarBehavior.fixed,
          );
        }
      }
    } catch (e) {
      setState(ViewState.idle);
      customSnackBar(
        context,
        "${e}",
        // behavior: SnackBarBehavior.fixed,
      );
      print(e);
    }
  }

  clearAuthProvider() {
    nameC = TextEditingController();
    emailC = TextEditingController();
    phoneC = TextEditingController();
    passwordC = TextEditingController();
    confirmPasswordC = TextEditingController();

    showPassword = false;
    agreeToTerms = false;

    customAuthResult = CustomAuthResult();
    appUser = AppUser();
    notifyListeners();
  }
}
