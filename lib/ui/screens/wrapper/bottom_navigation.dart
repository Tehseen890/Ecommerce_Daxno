import 'package:badges/badges.dart';
import 'package:ecommerce_daxno/core/constants/theme.dart';
import 'package:ecommerce_daxno/ui/screens/CartScreen/cartProvider.dart';
import 'package:ecommerce_daxno/ui/screens/DashBoard/dashboardScreen.dart';
import 'package:ecommerce_daxno/ui/screens/WishListScreen/wishListProvider.dart';
import 'package:ecommerce_daxno/ui/screens/WishListScreen/wishListScreen.dart';
import 'package:ecommerce_daxno/ui/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/locator.dart';
import '../../../core/services/auth_services.dart';
import '../CartScreen/cartScreen.dart';
import '../HomeScreen/homeScreen.dart';
import 'bottom_navigation_provider.dart';

class BottomNavigation extends StatelessWidget {
  // const BottomNavigation({Key? key}) : super(key: key);

  var pages = <Widget>[
    HomeScreen(),
    WishListScreen(),
    CartScreen(),
    DashBoardScreen(),
  ];
  var title = ["Home", "Wishlist", "Cart", "Dasahboard"];
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationProvider>(
      builder: (context, model, _) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications,
                ),
              )
            ],
            title: Text(
              "${title[model.index]}",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          drawer: CustomAppDrawer(),
          bottomNavigationBar: BottomNavBarWidget(),
          body: pages[model.index],
        );
      },
    );
  }
}

class CustomAppDrawer extends StatelessWidget {
  CustomAppDrawer({Key? key}) : super(key: key);
  final currentUser = locator<AuthServices>();

  logoutUser() async {
    // setState(ViewState.busy);
    await currentUser.logoutUser();
    // setState(ViewState.idle);
    Get.offAll(SplashScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Text("Side Drawer"),
          ),
          ListTile(
            onTap: logoutUser,
            title: Text("Logout"),
          ),
        ],
      ),
    );
  }
}

class BottomNavBarWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    WishListProvider wishListProvider = Provider.of<WishListProvider>(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Consumer<BottomNavigationProvider>(
      builder: (context, model, _) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                size: 35.sp,
              ),
              activeIcon: Icon(
                Icons.home,
                size: 35.sp,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Badge(
                badgeContent: Text("${wishListProvider.wishlist.length}"),
                child: Icon(FontAwesomeIcons.heart),
                showBadge: wishListProvider.wishlist.length != 0,
                toAnimate: false,
              ),
              activeIcon: Badge(
                badgeContent: Text("${wishListProvider.wishlist.length}"),
                child: Icon(FontAwesomeIcons.solidHeart),
                showBadge: wishListProvider.wishlist.length != 0,
                toAnimate: false,
              ),
              label: 'Wish List',
            ),
            BottomNavigationBarItem(
              icon: Badge(
                badgeContent: Text("${cartProvider.cartAsin.length}"),
                child: Icon(
                  Icons.shopping_basket_outlined,
                ),
                toAnimate: false,
                showBadge: cartProvider.cartAsin.length != 0,
              ),
              activeIcon: Badge(
                badgeContent: Text("${cartProvider.cartAsin.length}"),
                child: Icon(
                  Icons.shopping_basket,
                ),
                toAnimate: false,
                showBadge: cartProvider.cartAsin.length != 0,
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.dashcube),
              label: 'Dashboard',
            ),
          ],
          currentIndex: model.index,
          selectedItemColor: Color(0xFFAA292E),
          onTap: model.changePage,
        );
      },
    );
  }
}
