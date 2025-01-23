import 'package:flutter/material.dart';
import 'package:foodrecipeapp/constants/colors.dart';

class CustomTextFildInUpload extends StatelessWidget {
  CustomTextFildInUpload({
    Key? key,
    this.maxLines = 1,
    this.icon,
    required this.hint,
    this.radius = 10,
    this.controller,
    this.validator,
  }) : super(key: key);
  final int maxLines;
  final IconData? icon;
  final String hint;
  final double radius;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        icon: icon == null ? null : Icon(icon),
        hintText: hint,
        hintStyle: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(color: SecondaryText),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: outline)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: outline)),
      ),
      validator: validator,
    );
  }
}
