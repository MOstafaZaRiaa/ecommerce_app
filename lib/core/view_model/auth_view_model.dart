import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:ecommerce_app/core/services/firestore_user.dart';
import 'package:ecommerce_app/core/view_model/control_view_model.dart';
import 'package:ecommerce_app/helper/local_storage_data.dart';
import 'package:ecommerce_app/model/user_model.dart';


class AuthViewModel extends GetxController {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FacebookLogin _facebookLogin = FacebookLogin();
  FirebaseAuth _auth = FirebaseAuth.instance;
  String email, password, name;

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

  void googleSignInMethod() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
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
    });
    Get.offAll(ControlViewModel());
  }

  void facebookSignInMethod() async {
    FacebookLoginResult facebookLoginResult =
        await _facebookLogin.logIn(['email']);
    final accessToken = facebookLoginResult.accessToken.token;
    if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
      final facebookCredential = FacebookAuthProvider.credential(accessToken);
      await _auth
          .signInWithCredential(facebookCredential)
          .then((userCredential) async {
       await saveUser(userCredential);
      });
    }
    Get.offAll(()=>ControlViewModel());
  }

  void signInWithEmailAndPassword() async {
    try {
      await _auth
          .signInWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((value) async {
        await FireStoreUser()
            .getCurrentUser(_auth.currentUser.uid)
            .then((value) {
              setUser(UserModel.fromJson(value.data(),),);
        });
      });
      Get.offAll(()=>ControlViewModel(),);
    } on FirebaseException catch (error) {
      Get.snackbar(
        'Login error',
        error.message,
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void createUserWithEmailAndPassword() async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      )
          .then((userCredential) async {
        await FireStoreUser().addUserToFireStore(
          UserModel(
            userId: userCredential.user.uid,
            name: name == null ? userCredential.user.displayName : name,
            email: userCredential.user.email,
            userPic: '',
          ),
        );
        // saveUser(userCredential);
      });
      Get.offAll(()=>ControlViewModel(),);
    } on FirebaseException catch (error) {
      Get.snackbar(
        'SignUp Error',
        error.message,
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> saveUser(UserCredential userCredential) async {
    UserModel userModel = UserModel(
      userId: userCredential.user.uid,
      name: name == null ? userCredential.user.displayName : name,
      email: userCredential.user.email,
      userPic: '',
    );
    await FireStoreUser().addUserToFireStore(
      userModel,
    ).then((value) => {
       setUser(userModel)
    });
    // setUser(userModel);
  }

  setUser(UserModel userModel) async {
   await localStorageData.setUser(userModel);
  }
}
