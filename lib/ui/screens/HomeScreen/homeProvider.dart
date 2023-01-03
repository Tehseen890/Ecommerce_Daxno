import 'dart:async';
import 'dart:convert';

import 'package:banner_carousel/banner_carousel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_daxno/core/enums/view_state.dart';
import 'package:ecommerce_daxno/core/models/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import '../../../core/models/porduct.dart';

class HomeProvider extends BaseViewModal {
  ScrollController scrollController = ScrollController();
  int totalProducts = 0;
  int loadedProducts = 0;
  late Timer headerTimer;
  int time = 0;
  int activeImage = 1;
  late final List<dynamic> jsonDataList;
  bool isLoadingProducts = false;
  PageController pageController = PageController();
  List<Product> productsList = [];
  var banners = [
    BannerModel(imagePath: "assets/slider/1.png", id: "1"),
    BannerModel(imagePath: "assets/slider/2.png", id: "2"),
    BannerModel(imagePath: "assets/slider/3.png", id: "2"),
  ];

  HomeProvider() {
    print("Home Provider Created");
    init();
  }
  init() async {
    isLoadingProducts = true;
    // productsList =
    await ReadJsonData();
    isLoadingProducts = false;
    notifyListeners();
    scrollController.addListener(_scrollListener);
    LoadProducts(20);
  }

  int pageCount = 0;
  bool isLoading = true; //
  void _scrollListener() {
    print(
        "current ${scrollController.offset}  max: ${scrollController.position.maxScrollExtent}");
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      // setState(() {
      print("comes to bottom $isLoading");
      isLoading = true;

      if (isLoading) {
        print("RUNNING LOAD MORE");

        // pageCount = pageCount + 1;
        // addItemsToList(pageCount);
        LoadProducts(20);
      }
      // });
    }
  }

  // Future<List<Product>>
  ReadJsonData() async {
    //read json file
    final jsondata = await rootBundle.rootBundle.loadString('assets/data.json');
    //decode json data as list
    jsonDataList = json.decode(jsondata) as List<dynamic>;
    // jsonDataList = list;
    print(jsonDataList.length);
    // return list.map((e) => Product.fromJson(e)).toList();
  }

  LoadProducts(int numberOfProducts) {
    int start = 0 + (pageCount * 20);
    for (int i = start; i < start + 20; i++) {
      productsList.add(Product.fromJson(jsonDataList[i]));
    }
    pageCount++;
    notifyListeners();
  }
  // addDemoProducts() {
  //   final ref = FirebaseFirestore.instance;

  //   // List<Product> p = [
  //   //   Product(
  //   //     description: dummy,
  //   //     images: [
  //   //       "https://m.media-amazon.com/images/I/41OuvqjhaqL.jpg",
  //   //       "https://m.media-amazon.com/images/I/51zt+Bb48FL.jpg",
  //   //       "https://m.media-amazon.com/images/I/51EXdVtkpAL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41u3T2DxWkL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41ZOt3pgbSL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41FEYlXQNFL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41Nqt4ULBUL.jpg"
  //   //     ],
  //   //     name: "",
  //   //     price: 20.0,
  //   //     quantityAvailable: 10,
  //   //     seller: "Imad Rashid",
  //   //   ),
  //   //   Product(
  //   //     description: dummy,
  //   //     images: [
  //   //       "https://m.media-amazon.com/images/I/41OuvqjhaqL.jpg",
  //   //       "https://m.media-amazon.com/images/I/51zt+Bb48FL.jpg",
  //   //       "https://m.media-amazon.com/images/I/51EXdVtkpAL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41u3T2DxWkL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41ZOt3pgbSL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41FEYlXQNFL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41Nqt4ULBUL.jpg"
  //   //     ],
  //   //     name: "",
  //   //     price: 20.0,
  //   //     quantityAvailable: 10,
  //   //     seller: "Imad Rashid",
  //   //   ),
  //   //   Product(
  //   //     description: dummy,
  //   //     images: [
  //   //       "https://m.media-amazon.com/images/I/41OuvqjhaqL.jpg",
  //   //       "https://m.media-amazon.com/images/I/51zt+Bb48FL.jpg",
  //   //       "https://m.media-amazon.com/images/I/51EXdVtkpAL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41u3T2DxWkL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41ZOt3pgbSL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41FEYlXQNFL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41Nqt4ULBUL.jpg"
  //   //     ],
  //   //     name: "",
  //   //     price: 20.0,
  //   //     quantityAvailable: 10,
  //   //     seller: "Imad Rashid",
  //   //   ),
  //   //   Product(
  //   //     description: dummy,
  //   //     images: [
  //   //       "https://m.media-amazon.com/images/I/41OuvqjhaqL.jpg",
  //   //       "https://m.media-amazon.com/images/I/51zt+Bb48FL.jpg",
  //   //       "https://m.media-amazon.com/images/I/51EXdVtkpAL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41u3T2DxWkL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41ZOt3pgbSL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41FEYlXQNFL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41Nqt4ULBUL.jpg"
  //   //     ],
  //   //     name: "",
  //   //     price: 20.0,
  //   //     quantityAvailable: 10,
  //   //     seller: "Imad Rashid",
  //   //   ),
  //   //   Product(
  //   //     description: dummy,
  //   //     images: [
  //   //       "https://m.media-amazon.com/images/I/41OuvqjhaqL.jpg",
  //   //       "https://m.media-amazon.com/images/I/51zt+Bb48FL.jpg",
  //   //       "https://m.media-amazon.com/images/I/51EXdVtkpAL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41u3T2DxWkL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41ZOt3pgbSL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41FEYlXQNFL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41Nqt4ULBUL.jpg"
  //   //     ],
  //   //     name: "",
  //   //     price: 20.0,
  //   //     quantityAvailable: 10,
  //   //     seller: "Imad Rashid",
  //   //   ),
  //   //   Product(
  //   //     description: dummy,
  //   //     images: [
  //   //       "https://m.media-amazon.com/images/I/41OuvqjhaqL.jpg",
  //   //       "https://m.media-amazon.com/images/I/51zt+Bb48FL.jpg",
  //   //       "https://m.media-amazon.com/images/I/51EXdVtkpAL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41u3T2DxWkL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41ZOt3pgbSL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41FEYlXQNFL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41Nqt4ULBUL.jpg"
  //   //     ],
  //   //     name: "",
  //   //     price: 20.0,
  //   //     quantityAvailable: 10,
  //   //     seller: "Imad Rashid",
  //   //   ),
  //   //   Product(
  //   //     description: dummy,
  //   //     images: [
  //   //       "https://m.media-amazon.com/images/I/41OuvqjhaqL.jpg",
  //   //       "https://m.media-amazon.com/images/I/51zt+Bb48FL.jpg",
  //   //       "https://m.media-amazon.com/images/I/51EXdVtkpAL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41u3T2DxWkL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41ZOt3pgbSL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41FEYlXQNFL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41Nqt4ULBUL.jpg"
  //   //     ],
  //   //     name: "",
  //   //     price: 20.0,
  //   //     quantityAvailable: 10,
  //   //     seller: "Imad Rashid",
  //   //   ),
  //   //   Product(
  //   //     description: dummy,
  //   //     images: [
  //   //       "https://m.media-amazon.com/images/I/41OuvqjhaqL.jpg",
  //   //       "https://m.media-amazon.com/images/I/51zt+Bb48FL.jpg",
  //   //       "https://m.media-amazon.com/images/I/51EXdVtkpAL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41u3T2DxWkL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41ZOt3pgbSL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41FEYlXQNFL.jpg",
  //   //       "https://m.media-amazon.com/images/I/41Nqt4ULBUL.jpg"
  //   //     ],
  //   //     name: "",
  //   //     price: 20.0,
  //   //     quantityAvailable: 10,
  //   //     seller: "Imad Rashid",
  //   //   ),
  //   // ];

  //   // for (int i = 0; i < p.length; i++) {
  //   //   ref.collection("products").add(p[i].toJson);
  //   // }
  // }

  String dummy =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
}
