import 'package:ecommerce_app/model/user_model.dart';
import 'package:get/get.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:ecommerce_app/helper/local_storage_data.dart';

class ProfileViewModel extends GetxController {
  UserModel _userModel;

  UserModel get userModel => _userModel;
  final LocalStorageData localStorageData = Get.find();

  onInit() {
    super.onInit();
    getUserData();
  }

  getUserData() {
    localStorageData.getUser.then((value) => {
          _userModel = value,
        });
  }

  signOutOffAll() {
    FirebaseAuth.instance.signOut();
    GoogleSignIn().signOut();
    localStorageData.deleteUser();
  }
}
