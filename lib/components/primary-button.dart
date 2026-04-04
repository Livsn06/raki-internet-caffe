import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.onTap,
    this.isLoading = false,
    this.loadingLabel = "Loading",
  });
  final Function()? onTap;
  final bool isLoading;
  final String label;
  final String loadingLabel;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      onPressed: isLoading ? null : onTap,
      child: Text(isLoading ? loadingLabel : label),
    );
  }
}
