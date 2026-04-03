import 'package:flutter/material.dart';
import 'package:raki_internet_cafe/helper/db-helper.dart';
import 'package:raki_internet_cafe/repository/admin-repository.dart';

class AdminAuthProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  bool showPassword = false;
  bool isLoading = false;

  Future<bool> authorize() async {
    setLoading(true);
    if (!formKey.currentState!.validate()) return false;
    final database = await DBHelper.instance.database;
    final repo = AdminRepository(database: database);
    final isAuthorized = await repo.authorize(password: password.text);
    setLoading(false);
    return isAuthorized;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    return null;
  }

  void toggleShowPassword() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void setLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  void clearPassword() {
    password.clear();
    notifyListeners();
  }

  void resetProvider() {
    password.clear();
    isLoading = false;
    showPassword = false;
    notifyListeners();
  }

  @override
  void dispose() {
    resetProvider();
    super.dispose();
  }
}
