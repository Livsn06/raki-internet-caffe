import 'dart:developer';

import 'package:raki_internet_cafe/seeders/category-seeder.dart';

class DatabaseSeeder {
  DatabaseSeeder._();

  static Future<void> seed() async {
    log('Seeding database...');
    await CategorySeeder.seed();
    log('Database seeded.');
  }
}
