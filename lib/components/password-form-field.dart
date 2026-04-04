import 'package:flutter/material.dart';

class PasswordFormField extends StatelessWidget {
  const PasswordFormField({
    super.key,
    required this.controller,
    required this.label,
    this.isShowPassword = false,
    this.isLoading = false,
    this.toggleShowPassword,
    this.validator,
  });
  final TextEditingController controller;
  final String label;
  final bool isShowPassword;
  final bool isLoading;
  final Function()? toggleShowPassword;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: isLoading,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          onPressed: toggleShowPassword,
          icon: Icon(isShowPassword ? Icons.visibility : Icons.visibility_off),
        ),
      ),
      obscureText: !isShowPassword,
      validator: validator,
    );
  }
}
