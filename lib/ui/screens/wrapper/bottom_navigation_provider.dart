import 'package:ecommerce_daxno/core/models/base_view_model.dart';

class BottomNavigationProvider extends BaseViewModal {
  int index = 0;

  changePage(int index) {
    this.index = index;
    notifyListeners();
  }

  defaultPage() {
    this.index = 0;
    notifyListeners();
  }
}
