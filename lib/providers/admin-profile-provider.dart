import 'package:flutter/material.dart';
import 'package:raki_internet_cafe/helper/db-helper.dart';
import 'package:raki_internet_cafe/repository/admin-repository.dart';

class AdminProfileProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  bool showPassword = false;
  bool isLoading = false;

  void setLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  void resetProvider() {
    password.clear();
    confirmPassword.clear();
    isLoading = false;
    showPassword = false;
    notifyListeners();
  }

  void toggleShowPassword() {
    showPassword = !showPassword;
    notifyListeners();
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    return null;
  }

  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Confirm Password is required";
    } else if (value != password.text) {
      return "Password doesn't match";
    }
    return null;
  }

  Future<bool> updatePassword() async {
    setLoading(true);
    if (!formKey.currentState!.validate()) return false;
    final database = await DBHelper.instance.database;
    final repo = AdminRepository(database: database);
    return await repo.updatePassword(password: password.text);
  }
}
