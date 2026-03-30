import 'package:flutter/material.dart';

import '../../components/app-logo.dart';
import '../../components/app-title.dart';
import '../../utils/gap.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [AppLogo(scale: 2.4), vGap(10), AppTitle(fontSize: 24)],
      ),
    );
  }
}
