import 'package:flutter/material.dart';

import 'package:ecommerce_app/view/widgets/custom_text.dart';

class CustomTextFormField extends StatelessWidget {
  final String? text;
  final String? hintText;
  final bool obscureText;
  final Function? onSave;
  final Function? onValidate;

  const CustomTextFormField({
    this.text,
    this.hintText,
    this.obscureText = false,
    this.onSave,
    this.onValidate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          text: text,
          fontSize: 14.0,
          color: Colors.grey,
        ),
        TextFormField(
          validator: onValidate as String? Function(String?)?,
          onSaved: onSave as void Function(String?)?,
          textInputAction: TextInputAction.next,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
