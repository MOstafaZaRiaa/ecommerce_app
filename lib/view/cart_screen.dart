import 'package:ecommerce_app/view/checkout/checkout_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/state_manager.dart';
import 'package:firebase_image/firebase_image.dart';

import '../constance.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_text.dart';
import 'package:ecommerce_app/core/view_model/cart_view_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartViewModel>(
      init: CartViewModel(),
      builder: (controller) => controller.cartProductModel.length == 0
          ? Center(
              child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                    'assets/images/empty_cart.svg',
                  ),
                  CustomText(
                    text: 'Cart empty!',
                    fontSize: 32.0,
                    alignment: Alignment.center,
                  ),
                ],
              ),
            ))
          : Scaffold(
              body: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 15,
                      ),
                      child: ListView.separated(
                        itemCount: controller.cartProductModel.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(
                          height: 15,
                        ),
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width * 0.35,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FirebaseImage(
                                      controller.cartProductModel[index].image,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomLeft: Radius.circular(20),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text:
                                        controller.cartProductModel[index].name,
                                    fontSize: 16.0,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomText(
                                    text:
                                        '\$${controller.cartProductModel[index].price.toString()}',
                                    fontSize: 16.0,
                                    color: primaryColor,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          child: Container(
                                            child: Icon(Icons.add),
                                          ),
                                          onTap: () {
                                            controller.increaseQuantity(index);
                                          },
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        CustomText(
                                          text: controller
                                              .cartProductModel[index].quantity
                                              .toString(),
                                          alignment: Alignment.center,
                                          fontSize: 16.0,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        InkWell(
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 15.0),
                                            child: Icon(Icons.minimize_rounded),
                                          ),
                                          onTap: () {
                                            controller.decreaseQuantity(index);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'CHECKOUT',
                              fontSize: 12.0,
                              color: Colors.grey,
                            ),
                            CustomText(
                              text: '\$${controller.totalPrice}',
                              color: primaryColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: CustomButton(
                            text: 'ADD',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CheckoutView(),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
