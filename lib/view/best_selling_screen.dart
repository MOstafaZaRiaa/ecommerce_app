import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../constance.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/view/product_detail_screen.dart';
import 'package:ecommerce_app/view/widgets/custom_text.dart';

class BestSellingScreen extends StatelessWidget {
  @override
  final List<ProductModel> products;

  const BestSellingScreen({required this.products});

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.black,),
            onPressed: () {
              Get.back();
            },
          ),
          title: CustomText(
            text: "Best Selling",
            color: Colors.black,
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,

        ),
        body: SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 0.9),
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.to(
                      () => ProductDetailScreen(
                        model: products[index],
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
                              products[index].image!,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: products[index].name,
                          fontSize: 16.0,
                          // maxLine: 1,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        //description of product
                        CustomText(
                          text: products[index].description,
                          fontSize: 12.0,
                          maxLine: 1,
                          color: greyAccent,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomText(
                          text: '\$${products[index].price.toString()}',
                          fontSize: 16.0,
                          color: primaryColor,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    ));
  }
}
