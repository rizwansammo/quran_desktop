import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../models/ayah.dart';

class DBService {
  static Database? _db;

  /// ------------------------------------
  /// OPEN (OR CREATE) LOCAL SQLITE DB
  /// ------------------------------------
  static Future<Database> get database async {
    if (_db != null) return _db!;

    sqfliteFfiInit();

    final dbPath = await databaseFactoryFfi.getDatabasesPath();
    final path = join(dbPath, "quran_local_cache.sqlite");

    _db = await databaseFactoryFfi.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async => await _createTables(db),
      ),
    );

    return _db!;
  }

  /// ------------------------------------
  /// DATABASE SCHEMA
  /// ------------------------------------
  static Future<void> _createTables(Database db) async {
    await db.execute("""
      CREATE TABLE ayat (
        id INTEGER PRIMARY KEY,
        surah INTEGER NOT NULL,
        ayah INTEGER NOT NULL,
        text_uthmani TEXT,
        text_indopak TEXT,
        text_kfgq TEXT
      );
    """);

    await db.execute("""
      CREATE TABLE translations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        surah INTEGER NOT NULL,
        ayah INTEGER NOT NULL,
        source TEXT NOT NULL,
        text TEXT NOT NULL,
        UNIQUE(surah, ayah, source)
      );
    """);

    await db.execute("""
      CREATE TABLE tafsir (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        surah INTEGER NOT NULL,
        ayah INTEGER NOT NULL,
        source TEXT NOT NULL,
        text TEXT NOT NULL,
        UNIQUE(surah, ayah, source)
      );
    """);
  }

  /// ------------------------------------
  /// INSERT / GET AYAH
  /// ------------------------------------
  static Future<void> saveAyah(Ayah ayah) async {
    final db = await database;

    await db.insert(
      "ayat",
      ayah.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<Ayah?> getAyah(int surah, int ayahNumber) async {
    final db = await database;

    final res = await db.query(
      "ayat",
      where: "surah = ? AND ayah = ?",
      whereArgs: [surah, ayahNumber],
    );

    if (res.isEmpty) return null;

    return Ayah.fromMap(res.first);
  }

  /// ------------------------------------
  /// SAVE / GET TRANSLATIONS
  /// ------------------------------------
  static Future<void> saveTranslation(
      int surah, int ayah, String source, String text) async {
    final db = await database;

    await db.insert(
      "translations",
      {
        "surah": surah,
        "ayah": ayah,
        "source": source,
        "text": text,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<String?> getTranslation(
      int surah, int ayah, String source) async {
    final db = await database;

    final res = await db.query(
      "translations",
      where: "surah = ? AND ayah = ? AND source = ?",
      whereArgs: [surah, ayah, source],
    );

    if (res.isEmpty) return null;

    return res.first["text"] as String;
  }

  /// ------------------------------------
  /// SAVE / GET TAFSIR
  /// ------------------------------------
  static Future<void> saveTafsir(
      int surah, int ayah, String source, String text) async {
    final db = await database;

    await db.insert(
      "tafsir",
      {
        "surah": surah,
        "ayah": ayah,
        "source": source,
        "text": text,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<String?> getTafsir(
      int surah, int ayah, String source) async {
    final db = await database;

    final res = await db.query(
      "tafsir",
      where: "surah = ? AND ayah = ? AND source = ?",
      whereArgs: [surah, ayah, source],
    );

    if (res.isEmpty) return null;

    return res.first["text"] as String;
  }
}
