import 'package:ecommerce_app/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class AddAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          RadioListTile(
            value: null,
            groupValue: null,
            onChanged: (value) {},
            title: CustomText(
              text: 'Standard Delivery',
              fontSize: 18.0,
            ),
            subtitle: CustomText(
              text: 'Order will be delivered between 3 - 5 business days',
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}
