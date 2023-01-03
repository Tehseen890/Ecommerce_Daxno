import 'package:ecommerce_daxno/ui/screens/WishListScreen/wishListProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WishListProvider model = Provider.of<WishListProvider>(context);
    return Scaffold(
      body: model.wishlist.length == 0 || model.wishlist == null
          ? Center(
              child: Text("No items in wishlist"),
            )
          : Column(
              children: [],
            ),
    );
  }
}
