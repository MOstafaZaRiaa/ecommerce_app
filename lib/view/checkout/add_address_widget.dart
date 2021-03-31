import 'package:ecommerce_app/view/widgets/custom_text.dart';
import 'package:ecommerce_app/view/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class AddAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
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
            ),
            SizedBox(height: 40,),
            CustomTextFormField(
              text: 'Street 2',
              hintText: 'Opposite Omegatron, Vicent Quarters',
            ),
            SizedBox(height: 40,),
            CustomTextFormField(
              text: 'City',
              hintText: 'Victoria Island',
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
                    ),
                  ),
                ),
                Expanded(
                  child: CustomTextFormField(
                    text: 'Country',
                    hintText: 'Nigeria',
                  ),
                ),
              ], 
            ),
          ],
        ),
      ),
    );
  }
}
