import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ecommerce_app/core/view_model/profile_view_model.dart';
import 'package:ecommerce_app/view/auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProfileViewModel>(
        init: ProfileViewModel(),
        builder: (controller) => Container(
          child: Center(
            child: TextButton(
              child: Text('logout'),
              onPressed: () {
                controller.signOutOffAll();
                Get.offAll(()=>
                  LoginScreen(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
