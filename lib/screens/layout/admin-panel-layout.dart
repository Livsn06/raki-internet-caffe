import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raki_internet_cafe/providers/admin-auth-provider.dart';
import 'package:raki_internet_cafe/screens/admin/admin-panel-screen.dart';
import 'package:raki_internet_cafe/screens/admin/auth-screen.dart';
import 'package:raki_internet_cafe/utils/warrning-modal.dart';

class AdminPanelLayout extends StatelessWidget {
  const AdminPanelLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AdminAuthProvider>();

    void logout() {
      warningModal(
        context,
        title: "Logout",
        message: "Are you sure you want to logout?",
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.grey,
            child: const Text("No"),
          ),
          MaterialButton(
            onPressed: () {
              authProvider.resetProvider();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const AuthScreen()),
                (route) => false,
              );
            },
            color: Colors.red,
            child: const Text("Yes"),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text("Admin Panel"),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
        ],
      ),
      body: AdminPanelScreen(),
    );
  }
}
