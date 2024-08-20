import 'dart:io';

import 'package:sqlite3/sqlite3.dart';

enum _StmtType { create, query, select, search, insert, update, delete }

class MyDatabase {
  MyDatabase._({
    required this.inMemory,
    required String sqlPath,
    required Database? db,
  })  : _sqlPath = sqlPath,
        _db = db,
        _stmt = [];

  factory MyDatabase.inMemory({required String sqlPath}) {
    return MyDatabase._(
      inMemory: true,
      sqlPath: sqlPath,
      db: sqlite3.openInMemory(),
    );
  }

  factory MyDatabase.fromFile({
    required String sqlPath,
    required String dbPath,
  }) {
    return MyDatabase._(
      inMemory: false,
      sqlPath: sqlPath,
      db: sqlite3.open(dbPath),
    );
  }

  final bool inMemory;
  final String _sqlPath;
  final Database? _db;
  final List<PreparedStatement> _stmt;
}

extension Statements on MyDatabase {
  PreparedStatement get create => _stmt[_StmtType.create.index];
  //
  PreparedStatement get query => _stmt[_StmtType.query.index];
  PreparedStatement get select => _stmt[_StmtType.select.index];
  PreparedStatement get search => _stmt[_StmtType.search.index];
  PreparedStatement get insert => _stmt[_StmtType.insert.index];
  PreparedStatement get update => _stmt[_StmtType.update.index];
  PreparedStatement get delete => _stmt[_StmtType.delete.index];
}

extension Utils on MyDatabase {
  Database get database {
    if (_db == null) throw StateError('Database not initialized.');
    return _db;
  }

  Future<void> initialize() async {
    _createTable();
    await _prepareStatements();
    if (inMemory) _fillTestData();
  }

  void dispose() => database.dispose();
}

extension on MyDatabase {
  void _createTable() => database.execute('''
    CREATE TABLE IF NOT EXISTS Inventory (
      animal TEXT, description TEXT, age INTEGER, price REAL
    );''');

  void _fillTestData() => insert
    ..execute(['Dog', 'Wags tail when happy', '2', '250.00'])
    ..execute(['Cat', 'Black colour, friendly with kids', '3', '50.00'])
    ..execute(['Love Bird', 'Blue with some yellow', '2', '100.00']);

  Future<void> _prepareStatements() async {
    if (_stmt.isNotEmpty) return;
    final file = File.fromUri(Uri.file(_sqlPath));
    final sql = await file.readAsString();
    _stmt.addAll(database.prepareMultiple(sql));
  }
}
