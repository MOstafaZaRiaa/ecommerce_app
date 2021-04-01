import 'package:ecommerce_app/model/user_model.dart';
import 'package:ecommerce_app/view/auth/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:ecommerce_app/helper/local_storage_data.dart';

class ProfileViewModel extends GetxController {
  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  ValueNotifier _loading = ValueNotifier(false);
  ValueNotifier get loading =>_loading;

  final LocalStorageData localStorageData = Get.find();


  @override
  onInit() {
    getUserData();
    super.onInit();
  }

  getUserData() async {
    _loading.value = true;
    await localStorageData.getUser.then((value) => {
          _userModel = value,
        });
    _loading.value = false;
    update();
  }

  signOutOffAll() {
    FirebaseAuth.instance.signOut();
    GoogleSignIn().signOut();
    localStorageData.deleteUser();
    Get.offAll(()=>LoginScreen(),);
  }
}
