import 'package:ecommerce_daxno/core/models/base_view_model.dart';
import 'package:ecommerce_daxno/core/models/porduct.dart';

class WishListProvider extends BaseViewModal {
  WishListProvider() {
    init();
  }
  init() async {
    //fetch wishlist from firebase
  }
  List wishlist = [];

  addProduct(Product product) {
    wishlist.add(product.asin);
    notifyListeners();
  }

  removeProduct(Product product) {
    wishlist.remove(product.asin);
    notifyListeners();
  }
}
