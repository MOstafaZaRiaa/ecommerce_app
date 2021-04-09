import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:ecommerce_app/core/view_model/checkout_view_model.dart';
import 'package:ecommerce_app/view/widgets/custom_text.dart';
import 'package:ecommerce_app/view/widgets/custom_text_form_field.dart';

class AddAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<CheckOutViewModel>(
        init: Get.find(),
        builder:(controller)=> Form(
          key: controller.formState,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 50,),
                  CustomText(
                    text: 'Billing address is the same as delivery address',
                    fontSize: 14.0,
                  ),
                  SizedBox(height: 20,),
                  CustomTextFormField(
                    text: 'Street 1',
                    hintText: '21, Alex Davidson Avenue',
                    onSave: (value){
                      controller.street1=value;
                    },
                    onValidate: (String value){
                      if(value.isEmpty){
                        return 'This field can\'t be empty.';
                      }
                    },
                  ),
                  SizedBox(height: 40,),
                  CustomTextFormField(
                    text: 'Street 2',
                    hintText: 'Opposite Omegatron, Vicent Quarters',
                    onSave: (value){
                      controller.street2=value;
                    },
                    onValidate: (String value){
                      if(value.isEmpty){
                        return 'This field can\'t be empty.';
                      }
                    },
                  ),
                  SizedBox(height: 40,),
                  CustomTextFormField(
                    text: 'City',
                    hintText: 'Victoria Island',
                    onSave: (value){
                      controller.city=value;
                    },
                    onValidate: (String value){
                      if(value.isEmpty){
                        return 'This field can\'t be empty.';
                      }
                    },
                  ),
                  SizedBox(height: 40,),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right:20.0),
                          child: CustomTextFormField(
                            text: 'State',
                            hintText: 'Lagos State',
                            onSave: (value){
                              controller.state=value;
                            },
                            onValidate: (String value){
                              if(value.isEmpty){
                                return 'This field can\'t be empty.';
                              }
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: CustomTextFormField(
                          text: 'Country',
                          hintText: 'Nigeria',
                          onSave: (value){
                            controller.country=value;
                          },
                          onValidate: (String value){
                            if(value.isEmpty){
                              return 'This field can\'t be empty.';
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
