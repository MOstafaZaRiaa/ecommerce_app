import 'package:ecommerce_app/constance.dart';
import 'package:ecommerce_app/helper/enum.dart';
import 'package:ecommerce_app/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class DeliveryTime extends StatefulWidget {
  @override
  _DeliveryTimeState createState() => _DeliveryTimeState();
}

class _DeliveryTimeState extends State<DeliveryTime> {
  Delivery? delivery = Delivery.StandardDelivery;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(height: 100,),
          RadioListTile<Delivery>(
            value: Delivery.StandardDelivery,
            groupValue: delivery,
            onChanged: (Delivery? value) {
              setState(() {
                delivery = value;
              });
            },
            title: CustomText(
              text: 'Standard Delivery',
              fontSize: 18.0,
            ),
            subtitle: CustomText(
              text: '\nOrder will be delivered between 3 - 5 business days',
              fontSize: 14.0,
            ),
            activeColor: primaryColor,
          ),
          SizedBox(height: 50,),
          RadioListTile<Delivery>(
            value: Delivery.NextDayDelivery,
            groupValue: delivery,
            onChanged: (Delivery? value) {
              setState(() {
                delivery = value;
              });
            },
            title: CustomText(
              text: 'Next Day Delivery',
              fontSize: 18.0,
            ),
            subtitle: CustomText(
              text: '\nPlace your order before 6pm and your items will be delivered the next day',
              fontSize: 14.0,
            ),
            activeColor: primaryColor,
          ),
          SizedBox(height: 50,),
          RadioListTile<Delivery>(
            value: Delivery.NominatedDelivery,
            groupValue: delivery,
            onChanged: (Delivery? value) {
              setState(() {
                delivery = value;
              });
            },
            title: CustomText(
              text: 'Nominated Delivery',
              fontSize: 18.0,
            ),
            subtitle: CustomText(
              text: '\nPick a particular date from the calendar and order will be delivered on selected date',
              fontSize: 14.0,
            ),
            activeColor: primaryColor,
          ),
        ],
      ),
    );
  }
}
