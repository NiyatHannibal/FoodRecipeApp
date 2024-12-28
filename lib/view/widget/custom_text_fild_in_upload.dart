import 'package:flutter/material.dart';
import 'package:foodrecipeapp/constants/colors.dart';

class CustomTextFildInUpload extends StatelessWidget {
  CustomTextFildInUpload(
      {Key? key,
      this.maxLines = 1,
      this.icon,
      required this.hint,
      this.radius = 10})
      : super(key: key);
  int maxLines;
  IconData? icon;
  String hint;
  double radius;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
    );
  }
}
