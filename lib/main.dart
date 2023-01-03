import 'package:ecommerce_daxno/core/constants/screen_details.dart';
import 'package:ecommerce_daxno/core/locator.dart';
import 'package:ecommerce_daxno/ui/screens/AuthScreens/authprovider.dart';
import 'package:ecommerce_daxno/ui/screens/CartScreen/cartProvider.dart';
import 'package:ecommerce_daxno/ui/screens/HomeScreen/homeProvider.dart';
import 'package:ecommerce_daxno/ui/screens/WishListScreen/wishListProvider.dart';
import 'package:ecommerce_daxno/ui/screens/wrapper/bottom_navigation_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'core/constants/theme.dart';
import 'firebase_options.dart';
import 'ui/screens/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//Replaced with script based initialization using firebase_cli
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => BottomNavigationProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => WishListProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FORZIERI',
        theme: ThemeData(
          progressIndicatorTheme:
              ProgressIndicatorThemeData(color: primaryColor),
          primaryColor: primaryColor,
          appBarTheme: AppBarTheme(
            actionsIconTheme: IconThemeData(
              color: Colors.black,
            ),
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
            backgroundColor: Colors.white,
          ),
        ),
        home: ScreenUtilInit(
          designSize: Size(logicalWidth, logicalHeight),
          builder: (_, child) => SplashScreen(),
        ),
      ),
    );
  }
}
