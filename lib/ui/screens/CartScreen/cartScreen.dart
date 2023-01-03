import 'package:ecommerce_daxno/core/constants/theme.dart';
import 'package:ecommerce_daxno/ui/screens/CartScreen/cartProvider.dart';
import 'package:ecommerce_daxno/ui/screens/HomeScreen/homeProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../paymentScreen/paymentscreen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      body: cartProvider.cartProducts.length == 0
          ? Center(
              child: Text("No items in cart"),
            )
          : Container(
              child: Stack(
                children: [
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    //- image
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.network(
                                        cartProvider.cartProducts[index]
                                            .imagesList!.first,
                                        width: 80.w,
                                      ),
                                    ),

                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text("Name: "),
                                            Container(
                                              width: 180,
                                              child: Text(
                                                cartProvider
                                                    .cartProducts[index].title!,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: true,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("Unit Price: "),
                                            Text(
                                              cartProvider.cartProducts[index]
                                                      .price ??
                                                  124.toString(),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("Quantity: "),
                                            Text(
                                              cartProvider.cartProductQty.values
                                                  .elementAt(index)
                                                  .toString(),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        cartProvider.cartProducts
                                            .removeAt(index);
                                        cartProvider.cartAsin.removeAt(index);
                                        cartProvider.notifyListeners();
                                      },
                                      icon: Icon(Icons.delete_rounded),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        cartProvider.cartProductQty.update(
                                            cartProvider.cartAsin[index],
                                            (value) => ++value);
                                        cartProvider.notifyListeners();
                                        cartProvider.calculateTotal();
                                        print("upated");
                                        print(cartProvider.cartProductQty.values
                                            .elementAt(index));
                                      },
                                      icon: Icon(
                                        Icons.add,
                                      ),
                                    ),
                                    Text(
                                      cartProvider.cartProductQty.values
                                          .elementAt(index)
                                          .toString(),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        if (cartProvider.cartProductQty.values
                                                .elementAt(index) !=
                                            0) {
                                          cartProvider.cartProductQty.update(
                                              cartProvider.cartAsin[index],
                                              (value) {
                                            return --value;
                                          });
                                          cartProvider.notifyListeners();
                                          print("upated");
                                          cartProvider.calculateTotal();
                                          print(cartProvider
                                              .cartProductQty.values
                                              .elementAt(index));
                                        } else {}
                                      },
                                      icon: Icon(
                                        Icons.remove,
                                      ),
                                    ),
                                    Spacer(),
                                    Text("Total Price: "),
                                    Text(
                                      "${cartProvider.cartProductQty.values.elementAt(index) * double.parse(cartProvider.cartProducts[index].price!)}",
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                      // ListTile(
                      //   leading: Image.network(
                      //     cartProvider.cartProducts[index].imagesList!.first,
                      //   ),
                      //   // title: Text(cartProvider.cartProducts[index].title!),
                      //   trailing: Column(
                      //     children: [
                      //       Icon(Icons.add),
                      //       Text(
                      //         cartProvider.cartFinal.values.elementAt(index).toString(),
                      //       ),
                      //       // Icon(
                      //       //   Icons.remove,
                      //       //   size: 18,
                      //       // ),
                      //     ],
                      //   ),
                      // );
                    },
                    itemCount: cartProvider.cartAsin.length,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50.h,
                            padding: EdgeInsets.only(
                              left: 30,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Grand Total:"),
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
                        ),
                        Container(
                          height: 50.h,
                          // padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: primaryColor,
                            ),
                            onPressed: () {
                              Get.to(PaymentScreen());
                            },
                            child: Text(
                              "Checkout",
                              style: TextStyle(
                                color: Colors.white,
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
    );
  }
}
