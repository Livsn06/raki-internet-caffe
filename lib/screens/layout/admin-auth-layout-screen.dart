import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raki_internet_cafe/core/routing-controls.dart';
import 'package:raki_internet_cafe/core/ui-colors.dart';
import 'package:raki_internet_cafe/providers/admin-auth-provider.dart';
import 'package:raki_internet_cafe/screens/admin/auth-screen.dart';

class AdminAuthLayoutScreen extends StatelessWidget {
  const AdminAuthLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.read<AdminAuthProvider>().resetProvider();
            RouteControls.pushAndRemoveUntil(
              context,
              RouteScreens.productScreen,
            );
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Admin Panel",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),

        backgroundColor: Colors.black,
      ),

      body: AuthScreen(),
    );
  }
}
