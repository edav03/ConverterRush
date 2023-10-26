import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../entities/PagesData/pages_data.dart';

class PagesDataDB {
  static final PagesDataDB instance = PagesDataDB._init();

  static Database? _database;

  PagesDataDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute(
      '''
      CREATE TABLE $tablePages ( 
        ${PageFields.id} $idType, 
        ${PageFields.htmlContent} $textType
        )
      ''',
    );
  }

  Future<PageData> create(PageData pagesData) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tablePages, pagesData.toJson());
    return pagesData.copy(id: id);
  }

  Future<PageData?> getPageData(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tablePages,
      columns: PageFields.values,
      where: '${PageFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return PageData.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<PageData>> getAllPagesData() async {
    final db = await instance.database;

    // final orderBy = '${NoteFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tablePages);

    return result.map((json) => PageData.fromJson(json)).toList();
  }

  Future<int> update(PageData note) async {
    final db = await instance.database;

    return db.update(
      tablePages,
      note.toJson(),
      where: '${PageFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
