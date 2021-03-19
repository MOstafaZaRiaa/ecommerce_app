import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:firebase_image/firebase_image.dart';

import 'package:ecommerce_app/core/view_model/profile_view_model.dart';
import 'package:ecommerce_app/view/widgets/custom_text.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileViewModel>(
      init: ProfileViewModel(),
      builder: (controller) => Scaffold(
        body: controller.loading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.only(
                  top: 100,
                  right: 20,
                  left: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                            radius: 50.0,
                            backgroundImage: controller.userModel == null
                                ? AssetImage('assets/images/dummy_image.png')
                                : AssetImage('assets/images/dummy_image.png')
                            // : FirebaseImage(controller.userModel.userPic),
                            ),
                        SizedBox(
                          width: 50,
                        ),
                        Column(
                          children: [
                            CustomText(
                              text: controller.userModel.name,
                              fontSize: 20.0,
                            ),
                            CustomText(
                              text: controller.userModel.email,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MenuListTile(
                            iconPath: 'assets/menu_icons/Icon_Edit-Profile.png',
                            tileText: 'Edit Profile',
                            onPressed: () {},
                          ),
                          MenuListTile(
                            iconPath: 'assets/menu_icons/Icon_Location.png',
                            tileText: 'Shipping Address',
                            onPressed: () {},
                          ),
                          MenuListTile(
                            iconPath: 'assets/menu_icons/Icon_History.png',
                            tileText: 'Order History',
                            onPressed: () {},
                          ),
                          MenuListTile(
                            iconPath: 'assets/menu_icons/Icon_Payment.png',
                            tileText: 'Cards',
                            onPressed: () {},
                          ),
                          MenuListTile(
                            iconPath: 'assets/menu_icons/Icon_Alert.png',
                            tileText: 'Notifications',
                            onPressed: () {},
                          ),
                          MenuListTile(
                            iconPath: 'assets/menu_icons/Icon_Exit.png',
                            tileText: 'Log Out',
                            onPressed: () {
                              controller.signOutOffAll();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class MenuListTile extends StatelessWidget {
  final String iconPath;
  final String tileText;
  final Function onPressed;

  const MenuListTile({this.iconPath, this.tileText, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: Image.asset(iconPath),
      title: CustomText(
        text: tileText,
      ),
      trailing: Icon(Icons.navigate_next_rounded),
    );
  }
}
