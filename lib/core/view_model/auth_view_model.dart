import 'dart:async';

import 'package:ecommerce_app/constance.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:ecommerce_app/core/services/firestore_user.dart';
import 'package:ecommerce_app/core/view_model/control_view_model.dart';
import 'package:ecommerce_app/helper/local_storage_data.dart';
import 'package:ecommerce_app/model/user_model.dart';

class AuthViewModel extends GetxController {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FacebookAuth _facebookLogin = FacebookAuth.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String? email, password, name;

  LocalStorageData localStorageData = Get.find();

  // Rx<User> _user = Rx<User>();
  // String get user=>_user.value?.email;
  @override
  void onInit() {
    // _user.bindStream(_auth.userChanges());
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void googleSignInMethod(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Logging now....'),
        backgroundColor: primaryColor,
      ),
    );
    GoogleSignInAccount googleUser = (await _googleSignIn.signIn())!;
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );
    await _auth
        .signInWithCredential(authCredential)
        .then((userCredential) async {
      saveUser(userCredential);
      Get.offAll(ControlViewModel());
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('There is an error ,Try again later.'),
        backgroundColor: Colors.red,
      ),
    );
    update();
  }

  void facebookSignInMethod(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Logging now....'),
        backgroundColor: primaryColor,
      ),
    );
    final result = await FacebookAuth.instance.login();
    final OAuthCredential facebookCredential =
        FacebookAuthProvider.credential(result.accessToken!.token);
    if (result.status == LoginStatus.success) {
      await _auth
          .signInWithCredential(facebookCredential)
          .then((userCredential) async {
        await saveUser(userCredential);
      });
      Get.offAll(() => ControlViewModel());
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result.status.toString(),),
        backgroundColor: Colors.red,
      ),
    );
    update();
  }

  void signInWithEmailAndPassword(BuildContext context) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logging now....'),
          backgroundColor: primaryColor,
        ),
      );
      await _auth
          .signInWithEmailAndPassword(
              email: email!.trim(), password: password!.trim())
          .then((value) async {
        await FireStoreUser()
            .getCurrentUser(_auth.currentUser!.uid)
            .then((value) {
          setUser(
            UserModel.fromJson(
              value.data(),
            ),
          );
        });
      });
      Get.offAll(
        () => ControlViewModel(),
      );
    } on FirebaseException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString(),),
          backgroundColor: Colors.red,
        ),
      );
    }
    update();
  }

  void createUserWithEmailAndPassword(BuildContext context) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signing Up now....'),
          backgroundColor: primaryColor,
        ),
      );
      await _auth
          .createUserWithEmailAndPassword(
        email: email!.trim(),
        password: password!.trim(),
      )
          .then((userCredential) async {
        await FireStoreUser().addUserToFireStore(
          UserModel(
            userId: userCredential.user!.uid,
            name: name == null ? userCredential.user!.displayName : name,
            email: userCredential.user!.email,
            userPic: '',
          ),
        );
        // saveUser(userCredential);
      });
      Get.offAll(
        () => ControlViewModel(),
      );
    } on FirebaseException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString(),),
          backgroundColor: Colors.red,
        ),
      );
    }
    update();
  }

  Future<void> saveUser(UserCredential userCredential) async {
    UserModel userModel = UserModel(
      userId: userCredential.user!.uid,
      name: name == null ? userCredential.user!.displayName : name,
      email: userCredential.user!.email,
      userPic: '',
    );
    await FireStoreUser()
        .addUserToFireStore(
          userModel,
        )
        .then((value) => {setUser(userModel)});
    update();
  }

  setUser(UserModel userModel) async {
    await localStorageData.setUser(userModel);
    update();
  }
}
