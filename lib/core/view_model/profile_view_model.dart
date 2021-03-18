import 'package:get/get.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:ecommerce_app/helper/local_storage_data.dart';

class ProfileViewModel extends GetxController{
  final LocalStorageData localStorageData = Get.find();
  signOutOffAll(){
    FirebaseAuth.instance.signOut();
    GoogleSignIn().signOut();
    localStorageData.deleteUser();
  }
}