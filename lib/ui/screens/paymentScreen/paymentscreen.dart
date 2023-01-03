import 'package:ecommerce_daxno/core/constants/theme.dart';
import 'package:ecommerce_daxno/ui/screens/CartScreen/cartProvider.dart';
import 'package:ecommerce_daxno/ui/widgets/custom_snackbar.dart';
import 'package:ecommerce_daxno/ui/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../core/locator.dart';
import '../../../core/services/auth_services.dart';
import '../confirmationScreen.dart';
import '../wrapper/bottom_navigation.dart';
import '../wrapper/bottom_navigation_provider.dart';

class PaymentScreen extends StatefulWidget {
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _authServices = locator<AuthServices>();
  CardType cardType = CardType.none;
  final _addressController = TextEditingController();
  final expiryController = TextEditingController();
  final cardController = TextEditingController();
  final nameController = TextEditingController();
  final cvvController = TextEditingController();

  @override
  void initState() {
    if (_authServices.appUser.address != null &&
        _authServices.appUser.address != "") {
      _addressController.text = _authServices.appUser.address!;
    }
    super.initState();
  }

  PaymentMethod selectedMethod = PaymentMethod.card;
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    BottomNavigationProvider bottomNav =
        Provider.of<BottomNavigationProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Payment"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              //First Card for delivery Address
              SizedBox(
                height: 15.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  // vertical: 20.h,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                  horizontal: 10.w,
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10.0,
                    ),
                  ],
                  color: Colors.white,
                ),
                width: double.infinity,
                // height: MediaQuery.of(context).size.height * 0.15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Delivery Details",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Material(
                          shape: CircleBorder(),
                          child: IconButton(
                            onPressed: () {},
                            color: primaryColor,
                            icon: Icon(
                              Icons.edit,
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _authServices.appUser.userName!,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Card(
                          elevation: 3,
                          child: TextField(
                            controller: _addressController,
                            cursorColor: primaryColor,
                            maxLines: 2,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: _authServices.appUser.address == null ||
                                      _authServices.appUser.address == ""
                                  ? "Tap to add address"
                                  : _authServices.appUser.address,
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                                borderSide: BorderSide(color: primaryColor),
                              ),
                            ),
                            onChanged: (value) {
                              _authServices.appUser.address = value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  // vertical: 20.h,
                ),
                // padding: EdgeInsets.symmetric(
                //     vertical: 10.h,
                //     horizontal: 10.w,
                //     ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10.0,
                    ),
                  ],
                  color: Colors.white,
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      children: [
                        PaymentMethodButton(
                          isActive: selectedMethod == PaymentMethod.bank
                              ? true
                              : false,
                          icon: Icons.account_balance,
                          title: "Net Banking",
                          onPressed: () {
                            setState(
                              () {
                                selectedMethod = PaymentMethod.bank;
                              },
                            );
                          },
                        ),
                        PaymentMethodButton(
                          isActive: selectedMethod == PaymentMethod.card
                              ? true
                              : false,
                          icon: Icons.credit_card,
                          title: "Credit Card",
                          onPressed: () {
                            setState(
                              () {
                                selectedMethod = PaymentMethod.card;
                              },
                            );
                          },
                        ),
                        PaymentMethodButton(
                          isActive: selectedMethod == PaymentMethod.wallet
                              ? true
                              : false,
                          icon: Icons.wallet_sharp,
                          title: "Cash on delivery",
                          onPressed: () {
                            setState(() {
                              selectedMethod = PaymentMethod.wallet;
                            });
                          },
                        ),
                      ],
                    ),
                    Container(
                      // height: 200.h,
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: cardController,
                            hinttext: "0000 0000 0000 0000",
                            keyBoardType: TextInputType.number,
                            onChanged: (value) {
                              value.startsWith("5")
                                  ? cardType = CardType.master
                                  : value.startsWith("3")
                                      ? cardType = CardType.american
                                      : value.startsWith("4")
                                          ? cardType = CardType.visa
                                          : cardType = CardType.none;

                              setState(() {});
                            },
                            prefixIcon: Icon(
                              Icons.credit_card,
                              color: Colors.grey,
                            ),
                            sufFixIcon: Icon(
                              cardType == CardType.master
                                  ? FontAwesomeIcons.ccMastercard
                                  : cardType == CardType.visa
                                      ? FontAwesomeIcons.ccVisa
                                      : cardType == CardType.american
                                          ? FontAwesomeIcons.ccAmex
                                          : FontAwesomeIcons.creditCard,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: nameController,
                            hinttext: "Name on the Card",
                            prefixIcon: Icon(
                              FontAwesomeIcons.person,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: CustomTextField(
                                  controller: expiryController,
                                  hinttext: "Expiry Date",
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: CustomTextField(
                                  controller: cvvController,
                                  hinttext: "CVV",
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Expanded(child: Container()),
              // Spacer(),
              SizedBox(
                height: 15.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  // vertical: 20.h,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                  horizontal: 10.w,
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10.0,
                    ),
                  ],
                  color: Colors.white,
                ),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cart Value",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text("${cartProvider.totalCheckOutItems} items"),
                      ],
                    ),
                    Text(
                      "\u00a3 ${cartProvider.totalCheckOutAmount}",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(20.r),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      padding: EdgeInsets.all(8.r),
                      minimumSize: Size(
                        double.infinity,
                        80,
                      )),
                  onPressed: () async {
                    final validate = verifyFields();
                    if (validate) {
                      await Get.bottomSheet(
                        Container(
                          padding: EdgeInsets.all(18),
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Card(
                                elevation: 4,
                                shape: CircleBorder(),
                                child: Transform.scale(
                                  scale: 0.8,
                                  child:
                                      Lottie.asset("assets/delivery-guy.json"),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Your Order is on the way",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SafeArea(
                                bottom: true,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: primaryColor,
                                    padding: EdgeInsets.all(8.r),
                                    minimumSize: Size(
                                      double.infinity,
                                      80.h,
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text("Okay"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                      cartProvider.clearCart();
                      bottomNav.defaultPage();
                      // bottomNav.notifyListeners();
                      Get.offAll(BottomNavigation());
                      // Get.offUntil(
                      //     , (route) => false);
                    }
                  },
                  child: Text(
                    "Proceed to Pay ",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  verifyFields() {
    if (_addressController.text.isEmpty ||
        _addressController.text == null ||
        _addressController.text == "") {
      customSnackBar(context, "Enter an address");
      return false;
    } else if (selectedMethod == PaymentMethod.bank ||
        selectedMethod == PaymentMethod.card) {
      if (expiryController.text.isEmpty ||
          expiryController.text == "" ||
          cardController.text.isEmpty ||
          cardController.text == "" ||
          nameController.text.isEmpty ||
          nameController.text == "" ||
          cvvController.text.isEmpty ||
          cvvController.text == "") {
        customSnackBar(context, "Enter Payment Details");
        return false;
      }
    }

    return true;
  }
}

enum PaymentMethod { bank, card, wallet }

class PaymentMethodButton extends StatelessWidget {
  IconData icon;
  void Function()? onPressed;
  String title;
  bool isActive;
  PaymentMethodButton({
    required this.icon,
    required this.isActive,
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: isActive ? primaryColor : Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 10.h,
                horizontal: 10.w,
              ),
              child: Column(
                children: [
                  Icon(
                    icon,
                    color: isActive ? Colors.white : Colors.black,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.black,
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}

enum CardType { visa, master, american, none }
