import 'package:flutter/material.dart';

import 'package:ecommerce_app/constance.dart';
import 'package:ecommerce_app/view/widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  final  text;
  final Color color;
  final Color textColor;
  final Function? onPressed;

  const CustomButton({
    this.text,
    this.onPressed,
    this.textColor = Colors.white,
    this.color = primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed as void Function()?,
      color: color,
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      padding:const EdgeInsets.all(18),
      child: CustomText(
        text: text,
        alignment: Alignment.center,
        color: textColor,
      ),
    );
  }
}
