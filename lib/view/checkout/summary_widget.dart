import 'package:flutter/cupertino.dart';

import 'package:firebase_image/firebase_image.dart';
import 'package:get/get.dart';

import '../../constance.dart';
import 'package:ecommerce_app/core/view_model/cart_view_model.dart';
import 'package:ecommerce_app/view/widgets/custom_text.dart';

class Summary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(height: 40,),
          GetBuilder<CartViewModel>(
            builder: (controller) => Container(
              height: 250,
              child: Padding(
                padding: EdgeInsets.all(20,),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width * .4,
                              child: Image(
                                image: FirebaseImage(
                                  controller.cartProductModel[index].image,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomText(
                              text: controller.cartProductModel[index].name,
                              fontSize: 16.0,
                              // maxLine: 1,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CustomText(
                              text:
                                  '\$${controller.cartProductModel[index].price.toString()}',
                              fontSize: 16.0,
                              color: primaryColor,
                            ),
                          ],
                        ),
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 15,
                      );
                    },
                    itemCount: controller.cartProductModel.length),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
