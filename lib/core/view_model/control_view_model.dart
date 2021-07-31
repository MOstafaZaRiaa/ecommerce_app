import 'package:ecommerce_app/view/profile_screen/profile_screen.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import 'package:ecommerce_app/view/cart_screen.dart';
import 'package:ecommerce_app/view/home_page.dart';

class ControlViewModel extends GetxController {
  int _navigatorValue = 0;
  Widget currentScreen = HomePage();

  get navigatorValue => _navigatorValue;

  List<Widget> screens = [
    HomePage(),
    CartScreen(),
    ProfileScreen(),
  ];

  void changeSelectedValue(int selectedValue) {
    currentScreen = screens[selectedValue];
    // _navigatorValue = selectedValue;
    // switch (selectedValue){
    //   case 0 :
    //     {
    //       currentScreen = HomePage();
    //       break;
    //     }
    //   case 1 :
    //     {
    //       currentScreen = CartScreen();
    //       break;
    //     }
    //   case 2 :
    //     {
    //       currentScreen = ProfileScreen();
    //       break;
    //     }
    // }
    update();
  }
}
