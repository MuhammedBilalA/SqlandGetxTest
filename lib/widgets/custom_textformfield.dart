
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.textEditingController,
      required this.textInputType,
      required this.text});

 final TextEditingController textEditingController;
 final TextInputType textInputType;
 final String text;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: textInputType,
      decoration: InputDecoration(border: const OutlineInputBorder(), hintText: 'Enter $text'),
    );
  }
}