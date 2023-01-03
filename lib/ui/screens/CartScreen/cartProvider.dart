import 'package:ecommerce_daxno/core/models/base_view_model.dart';
import 'package:ecommerce_daxno/core/models/porduct.dart';

class CartProvider extends BaseViewModal {
  CartProvider() {
    init();
  }
  init() {}
  clearCart() {
    totalCheckOutAmount = 0;
    totalCheckOutItems = 0;
    cartAsin = [];
    cartProducts = [];
    cartProductQty = {};
    totalPrice = 0.0;
    notifyListeners();
  }

  double totalCheckOutAmount = 0.0;
  int totalCheckOutItems = 0;
  List cartAsin = [];
  List<Product> cartProducts = [];
  Map<String, int> cartProductQty = {};
  double totalPrice = 0.0;

  getCartFromFirebase() {}

  addProduct(Product product) {
    cartAsin.add(product.asin);
    cartProducts.add(product);
    cartProductQty.putIfAbsent(product.asin!, () => 1);
    calculateTotal();
    notifyListeners();

    //add product on firebase as well
  }

  removeProduct(Product product) {
    cartAsin.remove(product.asin);
    cartProducts.remove(product);
    calculateTotal();
    notifyListeners();

    //add product on firebase as well
  }

  calculateTotal() {
    print("recalculating");
    totalCheckOutAmount = 0;
    totalCheckOutItems = 0;
    cartProductQty.forEach((asin, qty) {
      Product x = cartProducts.firstWhere((element) {
        return element.asin == asin;
      });
      totalCheckOutAmount = totalCheckOutAmount + (int.parse(x.price!) * qty);
      totalCheckOutItems += qty;
    });
    notifyListeners();
  }

  findProduct(product) {
    if (cartProducts.contains(product)) {
      return true;
    }
    return false;
  }
}
