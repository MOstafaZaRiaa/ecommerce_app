import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import 'package:ecommerce_app/core/services/home_services.dart';
import 'package:ecommerce_app/model/category_model.dart';
import 'package:ecommerce_app/model/product_model.dart';

class HomeViewModel extends GetxController {
  ValueNotifier<bool> _isLoading = ValueNotifier(false);
  ValueNotifier<bool> get isLoading => _isLoading;

  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  HomeViewModel() {
    getCategory();
    getProducts();
  }

  getCategory() async {
    _isLoading.value = true;
    HomeServices().getCategories().then((categoriesDocs) {
      categoriesDocs.forEach((document) {
        _categories.add(
          CategoryModel.fromJson(
            document.data(),
          ),
        );
      });
      update();
      _isLoading.value = false;
    });
  }
  getProducts() async {
    _isLoading.value = true;
    HomeServices().getProducts().then((productsDocs) {
      productsDocs.forEach((document) {
        _products.add(
          ProductModel.fromJson(
            document.data(),
          ),
        );
        print(_products.length);
      });

      update();
      _isLoading.value = false;
    });
  }
}
