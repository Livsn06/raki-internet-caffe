import 'dart:developer';

import 'package:raki_internet_cafe/helper/db-helper.dart';
import 'package:raki_internet_cafe/repository/admin-repository.dart';

class AdminSeeder {
  AdminSeeder._();

  static Future<void> seed() async {
    // Create admin user
    final database = await DBHelper.instance.database;
    final adminRepository = AdminRepository(database: database);
    if (await adminRepository.getAdmin() == null) {
      log('Admin does not exist. Seeding admin...');
      await adminRepository.createAdmin(password: "password123");
    } else {
      log('Admin already exists. Skipping admin seeding.');
    }
  }
}
