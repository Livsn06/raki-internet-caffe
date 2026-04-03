import 'package:flutter/material.dart';

class CardTileButton extends StatelessWidget {
  const CardTileButton({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.foregroundColor = Colors.blueGrey,
    this.backgroundColor = Colors.white,
  });
  final Color foregroundColor;
  final Color backgroundColor;
  final String title;
  final IconData icon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: ListTile(
        leading: Icon(icon, color: foregroundColor),
        title: Text(
          title,
          style: TextStyle(color: foregroundColor, fontWeight: FontWeight.bold),
        ),
        onTap: onTap,
      ),
    );
  }
}
