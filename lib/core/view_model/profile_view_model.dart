import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:ecommerce_app/helper/local_storage_data.dart';
import 'package:ecommerce_app/model/user_model.dart';
import 'package:ecommerce_app/view/auth/login_screen.dart';
import 'package:ecommerce_app/core/services/firestore_user.dart';
import '../../constance.dart';

class ProfileViewModel extends GetxController {
  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  ValueNotifier _loading = ValueNotifier(false);

  ValueNotifier get loading => _loading;

  final LocalStorageData localStorageData = Get.find();
  FireStoreUser fireStoreUser = FireStoreUser();

  late String newPassword, newEmail = '', newUsername = '';

  final keyForm = GlobalKey<FormState>();

  final textController = TextEditingController();

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

  updateUserData(UserModel userModel, BuildContext context) async {
    keyForm.currentState!.save();
    // print(userModel.email);
    try {
      FocusScope.of(context).unfocus();
      final isValid = keyForm.currentState!.validate();
      if (isValid) {
        await fireStoreUser.updateUserInfo(
            userModel: userModel, newEmail: userModel.email!);
        await localStorageData.setUser(userModel);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Your information updated'),
            backgroundColor: primaryColor,
          ),
        );
      }
    } on FirebaseException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.message.toString(),
          ),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
    update();
  }

  Future<void> updatePassword(BuildContext context, newPassword) async {
    FocusScope.of(context).unfocus();
    final isValid = keyForm.currentState!.validate();
    keyForm.currentState!.save();
    if (isValid && (newPassword == textController.text)) {
      try {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Waiting.....'),
            backgroundColor: Theme.of(context).accentColor,
          ),
        );
        await FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password updated'),
            backgroundColor: primaryColor,
          ),
        );
      } on FirebaseException catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message!),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
      }
    }
    update();
  }

  signOutOffAll() {
    FirebaseAuth.instance.signOut();
    GoogleSignIn().signOut();
    localStorageData.deleteUser();
    Get.offAll(
      () => LoginScreen(),
    );
  }
}
