import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:firebase_image/firebase_image.dart';

import '../constance.dart';
import 'package:ecommerce_app/constance.dart';
import 'package:ecommerce_app/core/view_model/home_view_model.dart';
import 'package:ecommerce_app/view/product_detail_screen.dart';
import 'package:ecommerce_app/view/widgets/custom_text.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder: (controller) => RefreshIndicator(
        onRefresh: () {
          return HomeViewModel().getProducts();
        },
        child: Scaffold(
          body: controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 30.0,
                      left: 10,
                      right: 10,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        _searchTextFormField(),
                        SizedBox(
                          height: 30,
                        ),
                        CustomText(
                          text: 'Categories',
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        _categoriesListView(),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: 'Best Selling',
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            InkWell(
                              onTap: () {
                                //TODO:see all button
                                controller.getCategory();
                              },
                              child: CustomText(
                                text: 'See all',
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        _productsListView(),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _categoriesListView() {
    return GetBuilder<HomeViewModel>(
      builder: (controller) => Container(
        height: 100,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.categories.length,
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            width: 18,
          ),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width / 6.3,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      image: FirebaseImage(
                        controller.categories[index].image!,
                      ),
                    ),
                  ),
                ),
                CustomText(
                  text: controller.categories[index].name,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _productsListView() {
    return GetBuilder<HomeViewModel>(
      builder: (controller) => Container(
        height: 350,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.products.length,
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            width: 15,
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
              child: Container(
                width: MediaQuery.of(context).size.width * .4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 220,
                      width: MediaQuery.of(context).size.width * .4,
                      child: Image(
                        image: FirebaseImage(
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
                      text: '\$${controller.products[index].price.toString()}',
                      fontSize: 12.0,
                      color: primaryColor,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Container _searchTextFormField() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search_sharp,
            color: Colors.black,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
