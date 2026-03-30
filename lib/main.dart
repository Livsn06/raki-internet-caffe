import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raki_internet_cafe/helper/db-helper.dart';
import 'package:raki_internet_cafe/providers/initialize-provider.dart';
import 'package:raki_internet_cafe/screens/layout/start-layout-screen.dart';

import 'seeders/database-seeder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.instance.deleteDatabase();
  await DatabaseSeeder.seed();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderInitializer.providers,
      child: const MaterialApp(home: StartLayoutScreen()),
    );
  }
}
