import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/imt_calculation.dart';

class DBIMT {
  DBIMT._();

  static final DBIMT db = DBIMT._();

  static Database? _database;

  Future<Database> get database async {  // Changed to lowercase 'd'
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {  // Correct type annotation
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "IMTDatabase.db");
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute("""
      CREATE TABLE ImtCalculations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        weight REAL NOT NULL,
        height REAL NOT NULL,
        imt REAL NOT NULL,
        interpretation TEXT NOT NULL,
        timestamp INTEGER NOT NULL
      );
    """);
  }

    // Add transaction support for batch operations
  Future<void> insertMultipleCalculations(List<ImtCalculation> calculations) async {
    final db = await database;
    await db.transaction((txn) async {
      for (var calculation in calculations) {
        await txn.insert("ImtCalculations", calculation.toMap());
      }
    });
  }

  Future<int> newCalculation(ImtCalculation newImtCalculation) async {
    final db = await database;
    return await db.insert("ImtCalculations", newImtCalculation.toMap());
  }

  Future<List<ImtCalculation>> getAllImtCalculations() async {
    final db = await database;
    var res = await db.query("ImtCalculations", orderBy: "timestamp DESC");
    return res.isNotEmpty
        ? res.map((c) => ImtCalculation.fromMap(c)).toList()
        : [];
  }

  Future<ImtCalculation?> getImtCalculation(int id) async {
    final db = await database;
    var res = await db.query("ImtCalculations", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? ImtCalculation.fromMap(res.first) : null;
  }

  Future<int> deleteImtCalculation(int id) async {
    final db = await database;
    return await db.delete("ImtCalculations", where: "id = ?", whereArgs: [id]);
  }

  Future<int> updateImtCalculation(ImtCalculation newImtCalculation) async {
    final db = await database;
    return await db.update(
      "ImtCalculations",
      newImtCalculation.toMap(),
      where: "id = ?",
      whereArgs: [newImtCalculation.id],
    );
  }
}