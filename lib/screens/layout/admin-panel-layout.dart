import 'package:flutter/material.dart';
import 'package:raki_internet_cafe/screens/admin/admin-panel-screen.dart';

class AdminPanelLayout extends StatelessWidget {
  const AdminPanelLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text("Admin Panel"),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.logout))],
      ),
      body: AdminPanelScreen(),
    );
  }
}
