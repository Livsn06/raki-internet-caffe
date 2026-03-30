import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raki_internet_cafe/screens/client/splash-screen.dart';
import 'package:raki_internet_cafe/screens/client/start-screen.dart';

import '../../providers/splash-provider.dart';

class StartLayoutScreen extends StatefulWidget {
  const StartLayoutScreen({super.key});

  @override
  State<StartLayoutScreen> createState() => _StartLayoutScreenState();
}

class _StartLayoutScreenState extends State<StartLayoutScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SplashProvider>().initializeApp(context);
  }

  @override
  Widget build(BuildContext context) {
    final splashProvider = context.watch<SplashProvider>();
    return SafeArea(
      child: Scaffold(
        body: AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastLinearToSlowEaseIn,
          child: splashProvider.isLoading
              ? const SplashScreen()
              : const StartScreen(),
        ),
      ),
    );
  }
}
