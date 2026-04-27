import 'dart:developer';

import 'package:raki_internet_cafe/models/admin-model.dart';
import 'package:raki_internet_cafe/models/cart-item-model.dart';
import 'package:raki_internet_cafe/models/category-model.dart';
import 'package:raki_internet_cafe/models/order-model.dart';
import 'package:raki_internet_cafe/models/product-model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._();
  DBHelper._();

  static Database? _database;

  // FIX: Always check if the database is open before returning it
  Future<Database> get database async {
    if (_database != null && _database!.isOpen) {
      return _database!;
    }
    _database = await _openMyDatabase();
    return _database!;
  }

  static const String _dbName = "raki_internet_cafe.db";
  static const int _dbVersion = 1;

  Future<Database> _openMyDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    // Assign to the static variable so the getter sees it next time
    _database = await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        await createCategoryTable(db);
        await createProductTable(db);
        await createAdminTable(db);
        await createOrderTable(db);
      },
    );
    return _database!;
  }

  Future<void> createCategoryTable(Database db) async {
    await db.execute('''
          CREATE TABLE ${CategoryFillable.table} (
            ${CategoryFillable.id} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${CategoryFillable.name} TEXT NOT NULL,
            ${CategoryFillable.imagePath} TEXT NOT NULL,
            ${CategoryFillable.createdAt} TEXT NOT NULL,
            ${CategoryFillable.updatedAt} TEXT NOT NULL
          )
        ''');
  }

  Future<void> createProductTable(Database db) async {
    await db.execute('''
          CREATE TABLE ${ProductFillable.table} (
            ${ProductFillable.id} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${ProductFillable.name} TEXT NOT NULL,
            ${ProductFillable.catId} INTEGER NOT NULL,
            ${ProductFillable.variantLabel} TEXT NOT NULL,
            ${ProductFillable.price} REAL NOT NULL,
            ${ProductFillable.imagePath} TEXT NOT NULL,
            FOREIGN KEY (${ProductFillable.catId}) REFERENCES ${CategoryFillable.table}(${CategoryFillable.id})
          )
        ''');
  }

  Future<void> createOrderTable(Database db) async {
    await db.execute('''
          CREATE TABLE ${OrderFillable.table} (
            ${OrderFillable.id} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${OrderFillable.orderNumber} INTEGER NOT NULL,
            ${OrderFillable.totalPrice} REAL NOT NULL,
            ${OrderFillable.status} TEXT NOT NULL,
            ${OrderFillable.items} TEXT NOT NULL,
            ${OrderFillable.createdAt} TEXT NOT NULL
          )
        ''');
  }

  Future<void> createAdminTable(Database db) async {
    await db.execute('''
          CREATE TABLE ${AdminFillable.table} (
            ${AdminFillable.id} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${AdminFillable.password} TEXT NOT NULL
          )
        ''');
  }

  Future<void> close() async {
    if (_database != null && _database!.isOpen) {
      await _database!.close();
      _database = null; // CRITICAL: Reset to null so it can be re-opened
    }
  }

  // Update your delete method to reset the variable
  Future<void> deleteDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    await close();
    await databaseFactory.deleteDatabase(path);
    log('🗑️ Database deleted.');
  }
}
