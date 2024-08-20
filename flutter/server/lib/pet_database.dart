import 'dart:io';

import 'package:sqlite3/sqlite3.dart';

enum StmtType { create, query, select, search, insert, update, delete }

class PetDatabase {
  const PetDatabase({
    required this.inMemory,
    required this.sqlPath,
    required this.stmts,
    required this.database,
  });

  factory PetDatabase.open({required String dbPath, required String sqlPath}) {
    return PetDatabase(
      inMemory: dbPath.isEmpty,
      sqlPath: sqlPath,
      stmts: [],
      database: dbPath.isEmpty ? sqlite3.openInMemory() : sqlite3.open(dbPath),
    );
  }

  final bool inMemory;
  final String sqlPath;
  final List<PreparedStatement> stmts;
  final Database database;
}

extension Utils on PetDatabase {
  void createTable() {
    if (!inMemory) return;
    database.execute('''
      CREATE TABLE IF NOT EXISTS Inventory (
        animal TEXT, description TEXT, age INTEGER, price REAL
      );
    ''');
  }

  void fillTestData() {
    if (!inMemory) return;
    stmts[StmtType.insert.index]
      ..execute(['Dog', 'Wags tail when happy', '2', '250.00'])
      ..execute(['Cat', 'Black colour, friendly with kids', '3', '50.00'])
      ..execute(['Love Bird', 'Blue with some yellow', '2', '100.00']);
  }

  Future<void> prepareStatements() async {
    if (stmts.isNotEmpty) return;
    final file = File.fromUri(.file(sqlPath));
    final content = await file.readAsString();
    stmts.addAll(database.prepareMultiple(content));
  }

  void close() => database.close();
}
