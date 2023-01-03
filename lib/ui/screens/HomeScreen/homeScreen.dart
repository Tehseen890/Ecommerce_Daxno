import 'package:banner_carousel/banner_carousel.dart';
import 'package:ecommerce_daxno/core/constants/screen_details.dart';
import 'package:ecommerce_daxno/core/constants/theme.dart';
import 'package:ecommerce_daxno/core/models/porduct.dart';
import 'package:ecommerce_daxno/ui/screens/CartScreen/cartProvider.dart';
import 'package:ecommerce_daxno/ui/screens/CartScreen/cartScreen.dart';
import 'package:ecommerce_daxno/ui/screens/WishListScreen/wishListProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../wrapper/bottom_navigation_provider.dart';
import 'homeProvider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, model, _) {
        return Scaffold(
          body: ListView(
            controller: model.scrollController,
            children: [
              BannerCarousel(
                pageController: model.pageController,
                animation: true,
                margin: EdgeInsets.zero,
                height: logicalHeight * 0.3,
                banners: model.banners,
                indicatorBottom: false,
                activeColor: primaryColor.withOpacity(0.8),
              ),
              SizedBox(
                height: 10.h,
              ),
              model.isLoadingProducts
                  ? Center(child: CircularProgressIndicator())
                  : ProductsGrid(),
              model.isLoading
                  ? Center(
                      child: Column(
                        // mainAxisAlignment: ,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          Text("\n\nLoading more data...\n\n\n\n")
                        ],
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        );
      },
    );
  }
}

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var home = Provider.of<HomeProvider>(context);
    return GridView.builder(
      // controller: home.scrollController,
      shrinkWrap: true, // You won't see infinite size error
      physics: ScrollPhysics(),
      itemCount: home.productsList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        return GridItem(product: home.productsList[index]);
      },
    );
  }
}

class GridItem extends StatelessWidget {
  const GridItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    WishListProvider wishListProvider = Provider.of<WishListProvider>(context);
    BottomNavigationProvider bottomProvider =
        Provider.of<BottomNavigationProvider>(context);
    return Material(
      elevation: 2,
      child: InkWell(
        onTap: () {
          Get.to(ProductDetails());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15.h,
            ),
            Container(
              alignment: Alignment.center,
              height: 100.h,
              child: Image.network(
                product.imagesList!.first,
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
              padding: EdgeInsets.all(12.r),
              child: Text(
                "${product.title!}",
                softWrap: true,
                maxLines: 2,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.h, left: 10.w),
              child: Text("\u00a3 ${product.price}"),
            ),
            // Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      !wishListProvider.wishlist.contains(product.asin)
                          ? wishListProvider.addProduct(product)
                          : wishListProvider.removeProduct(product);
                    },
                    color: !wishListProvider.wishlist.contains(product.asin)
                        ? Colors.black
                        : primaryColor,
                    icon: Icon(
                      !wishListProvider.wishlist.contains(product.asin)
                          ? FontAwesomeIcons.heart
                          : FontAwesomeIcons.solidHeart,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      !cartProvider.findProduct(product)
                          ? cartProvider.addProduct(product)
                          : bottomProvider.changePage(2);
                    },
                    color: !cartProvider.cartAsin.contains(product.asin)
                        ? Colors.black
                        : primaryColor,
                    icon: Icon(
                      !cartProvider.cartAsin.contains(product.asin)
                          ? Icons.shopping_cart_outlined
                          : Icons.shopping_cart_checkout,
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

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
