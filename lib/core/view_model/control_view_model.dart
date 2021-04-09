import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import 'package:ecommerce_app/view/cart_screen.dart';
import 'package:ecommerce_app/view/home_page.dart';
import 'file:///C:/Users/zaria/OneDrive/Documents/GitHub/ecommerce_app/lib/view/profile_screen/profile_screen.dart';

class ControlViewModel extends GetxController {
  int _navigatorValue = 0;
  Widget currentScreen = HomePage();

  get navigatorValue => _navigatorValue;

  void changeSelectedValue(int selectedValue) {
    _navigatorValue = selectedValue;
    switch (selectedValue){
      case 0 :
        {
          currentScreen = HomePage();
          break;
        }
      case 1 :
        {
          currentScreen = CartScreen();
          break;
        }
      case 2 :
        {
          currentScreen = ProfileScreen();
          break;
        }
    }
    update();
  }
}
