import 'package:flutter/material.dart';
import 'package:raki_internet_cafe/components/card-tile-button.dart';
import 'package:raki_internet_cafe/screens/admin/category/category-screen.dart';
import 'package:raki_internet_cafe/screens/admin/profile/profile-screen.dart';

class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardTileButton(
          title: 'My Account',
          icon: Icons.person,
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          },
        ),
        CardTileButton(
          title: 'Products',
          icon: Icons.sell,
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CategoryScreen()),
            );
          },
        ),
        CardTileButton(
          title: 'Orders',
          icon: Icons.list,
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          onTap: () {},
        ),
      ],
    );
  }
}
