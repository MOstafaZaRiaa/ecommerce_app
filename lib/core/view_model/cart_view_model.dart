import 'package:flutter/foundation.dart';

import 'package:get/get.dart';

import 'package:ecommerce_app/core/database/cart_database_helper.dart';
import 'package:ecommerce_app/model/cart_product_model.dart';

class CartViewModel extends GetxController {
  ValueNotifier<bool> _isLoading = ValueNotifier(false);

  ValueNotifier<bool> get isLoading => _isLoading;

  List<CartProductModel> _cartProductModel = [];

  List<CartProductModel> get cartProductModel => _cartProductModel;

  double _totalPrice = 0.0;

  double get totalPrice => _totalPrice;

  var dbHelper = CartDatabaseHelper.db;

  CartViewModel() {
    getAllProduct();
  }

  getAllProduct() async {
    _isLoading.value = true;
    _cartProductModel = await dbHelper.getAllProduct();
    _isLoading.value = false;
    getTotalPrice();
    update();
  }

  addProduct(CartProductModel cartProductModel) async {
    for (int i = 0; i < _cartProductModel.length; i++) {
      if (_cartProductModel[i].productId == cartProductModel.productId) {
        return;
      }
    }
    var dbHelper = CartDatabaseHelper.db;
    await dbHelper.insert(cartProductModel);
    _cartProductModel.add(cartProductModel);
    _totalPrice +=
        (double.parse(cartProductModel.price!) * cartProductModel.quantity!);
    update();
  }

  getTotalPrice() {
    for (int i = 0; i < _cartProductModel.length; i++) {
      _totalPrice += (double.parse(cartProductModel[i].price!) *
          cartProductModel[i].quantity!);
    }
    update();
  }

  increaseQuantity(int index) async {
    cartProductModel[index].quantity = cartProductModel[index].quantity! + 1;
    _totalPrice += (double.parse(cartProductModel[index].price!));
    await dbHelper.updateProduct(cartProductModel[index]);
    update();
  }

  decreaseQuantity(int index) async {
    if (cartProductModel[index].quantity! > 1) {
      cartProductModel[index].quantity = cartProductModel[index].quantity! - 1;
      _totalPrice -= (double.parse(cartProductModel[index].price!));
      await dbHelper.updateProduct(cartProductModel[index]);
    }
    update();
  }
}
