import 'dart:async';

import 'package:ecommerce_daxno/ui/screens/wrapper/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/locator.dart';
import '../../core/services/auth_services.dart';
import 'AuthScreens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _authService = locator<AuthServices>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreenDelay();
  }

  splashScreenDelay() async {
    ///
    /// splash screen delay
    ///
    await Future.delayed(
      Duration(seconds: 3),
    );

    if (_authService.appUser.appUserId != null && _authService.isLogin!) {
      Get.offAll(
        () => BottomNavigation(),
      );
      // if (_authService.appUser.isFirstLogin ?? false) {
      //   Get.offAll(
      //     () => BottomNavigation(),
      //   );
      // } else {
      //   Get.offAll(() => BottomNavigation());
      //   print('User id=> ${_authService.appUser.appUserId}');
      //   Future.delayed(Duration(seconds: 1));
      //   // Get.snackbar("Congrats", "message",snackStyle: SnackStyle.FLOATING,isDismissible: true);
      // }
    } else if (_authService.appUser == null && !_authService.isLogin!) {
      Get.offAll(() => LoginScreen());
      print("App user name ${_authService.appUser.userName}");
      print("isLogin ${_authService.isLogin}");
    } else {
      Get.offAll(() => LoginScreen());
      print("User email ${_authService.appUser.userEmail}");
      print("isLogin ${_authService.isLogin}");
    }

    // Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text(
            "FORZIERI",
            style: TextStyle(
              fontSize: 25.sp,
              letterSpacing: 3.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
