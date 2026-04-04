import 'dart:developer';

import 'package:raki_internet_cafe/helper/db-helper.dart';
import 'package:raki_internet_cafe/models/admin-model.dart';
import 'package:sqflite/sqflite.dart';

class AdminRepository {
  Database database;
  AdminRepository({required this.database});

  Future<bool> authorize({required String password}) async {
    final db = await DBHelper.instance.database;
    final result = await db.query(
      AdminFillable.table,
      where: '${AdminFillable.password} = ?',
      whereArgs: [password],
    );
    return result.isNotEmpty;
  }

  Future<bool> updatePassword({required String password}) async {
    final db = await DBHelper.instance.database;
    final result = await db.update(
      AdminFillable.table,
      {AdminFillable.password: password},
      where: '${AdminFillable.id} = ?',
      whereArgs: [1],
    );

    return result > 0; // Return true if at least one row was updated
  }

  Future<void> createAdmin({required String password}) async {
    final db = await DBHelper.instance.database;
    log('Seeding admin...');
    await db.insert(AdminFillable.table, {AdminFillable.password: password});
    log('Admin seeded.');
  }
}
