import 'dart:developer';

import 'package:raki_internet_cafe/seeders/admin-seeder.dart';
import 'package:raki_internet_cafe/seeders/category-seeder.dart';
import 'package:raki_internet_cafe/seeders/product-seeder.dart';

class DatabaseSeeder {
  DatabaseSeeder._();

  static Future<void> seed() async {
    log('Seeding database...');
    await CategorySeeder.seed();
    await ProductSeeder.seed();
    await AdminSeeder.seed();
    log('Database seeded.');
  }
}
