import 'package:flutter/material.dart';
import 'package:raki_internet_cafe/components/card-tile-button.dart';

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
          onTap: () {},
        ),
        CardTileButton(
          title: 'Products',
          icon: Icons.sell,
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
          onTap: () {},
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
