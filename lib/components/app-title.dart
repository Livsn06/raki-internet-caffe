import 'package:flutter/material.dart';
import 'package:raki_internet_cafe/core/ui-colors.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({super.key, required this.fontSize});
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Raki",
            style: TextStyle(
              color: UIColors.secondaryColor,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: " Internet Cafe",
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
