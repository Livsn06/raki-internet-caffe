import 'package:raki_internet_cafe/helper/db-helper.dart';
import 'package:raki_internet_cafe/repository/admin-repository.dart';

class AdminSeeder {
  AdminSeeder._();

  static Future<void> seed() async {
    // Create admin user
    final database = await DBHelper.instance.database;
    final adminRepository = AdminRepository(database: database);
    await adminRepository.createAdmin(password: "password123");
  }
}
