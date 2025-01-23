import 'package:flutter/material.dart';
import 'package:foodrecipeapp/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? color;
  final VoidCallback? onTap;
  final Color? colorBorder;
  final Color? textColor;
  final double height;
  final bool isLoading;
  final double? width; // Make width nullable

  const CustomButton(
      {Key? key,
      required this.text,
      this.color = primary,
      required this.onTap,
      this.colorBorder,
      this.textColor,
      this.height = 56,
      this.isLoading = false,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: MaterialButton(
        onPressed: isLoading ? null : onTap,
        color: color,
        height: height,
        minWidth: width ??
            double
                .infinity, // Use provided width if available, else use double.infinity
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 0,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
      ),
    );
  }
}
