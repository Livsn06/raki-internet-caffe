import 'package:flutter/material.dart';
import 'package:raki_internet_cafe/core/ui-colors.dart';

import '../../components/app-logo.dart';
import '../../components/app-title.dart';
import '../../core/routing-controls.dart';
import '../../utils/gap.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        RouteControls.pushReplacement(context, RouteScreens.productScreen),
      },
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [UIColors.secondaryColor, Color(0xFF1B5E20), Colors.black],
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            AppLogo(scale: 2.2),
            vGap(10),
            AppTitle(fontSize: 26),
            vGap(10),
            Text(
              "Where Great Work Meets Great Snacks",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const Spacer(),
            const Text(
              "Tap Anywhere to begin",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            vGap(10),
            const Icon(Icons.touch_app, color: Colors.white, size: 30),
            vGap(50),
          ],
        ),
      ),
    );
  }
}
