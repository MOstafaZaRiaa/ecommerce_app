import 'package:ecommerce_app/core/view_model/home_view_model.dart';
import 'package:ecommerce_app/view/product_detail_screen.dart';
import 'package:ecommerce_app/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../constance.dart';

class CategoryScreen extends StatelessWidget {
  final String? title;

  const CategoryScreen({this.title});

  Widget build(BuildContext context) {
    final deviceWidth = Get.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_outlined),
                  onPressed: () {
                    Get.back();
                  },
                ),
                SizedBox(
                  width: deviceWidth * 0.3,
                ),
                CustomText(
                  text: title,
                  fontSize: 20.0,
                ),
              ],
            ),
            Expanded(
              child: GetBuilder<HomeViewModel>(
                builder: (controller) => GridView.builder(
                  itemCount: controller.products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.65,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(
                          () => ProductDetailScreen(
                            model: controller.products[index],
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 220,
                              child: Image(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  controller.products[index].image!,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomText(
                              text: controller.products[index].name,
                              fontSize: 16.0,
                              // maxLine: 1,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            //description of product
                            CustomText(
                              text: controller.products[index].description,
                              fontSize: 12.0,
                              maxLine: 1,
                              color: greyAccent,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CustomText(
                              text:
                                  '\$${controller.products[index].price.toString()}',
                              fontSize: 16.0,
                              color: primaryColor,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
