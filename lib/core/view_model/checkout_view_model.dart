import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../constance.dart';
import 'package:ecommerce_app/helper/enum.dart';
import 'package:ecommerce_app/view/control_view.dart';

class CheckOutViewModel extends GetxController {
  int _index = 0;

  int get index => _index;

  Pages _pages = Pages.DeliveryTime;

  Pages get pages => _pages;

  GlobalKey<FormState> formState = GlobalKey();

  late String street1, street2, city, state, country;

  changeIndex(int i) {
    if(i==0||i<0){
      _pages = Pages.DeliveryTime;
      _index=i;
    }
    if (i == 1) {
      _index = i;
      _pages = Pages.AddAddress;
    } else if (i == 2) {
      formState.currentState!.save();
      if(formState.currentState!.validate()){
        _index = i;
        _pages = Pages.Summary;
      }
    } else if (i == 3) {
      _pages = Pages.DeliveryTime;
      Get.offAll(() => ControlView());
    }
    update();
  }

  Color getColor(int i) {
    if (i == _index) {
      return inProgressColor;
    } else if (i < _index) {
      return Colors.green;
    } else {
      return todoColor;
    }
  }
}
