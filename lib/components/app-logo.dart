import 'package:flutter/material.dart';

import '../helper/asset-helper.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, required this.scale});
  final double scale;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetHelper.getAssetPath(AssetItems.appIcon),
      scale: scale,
    );
  }
}
