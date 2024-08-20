import 'dart:io';

import 'package:sqlite3/sqlite3.dart';

enum StmtType { create, query, select, search, insert, update, delete }

class PetStatements {
  PetStatements({required this.sqlPath});

  factory PetStatements.fromEnv() {
    const sqlPath = String.fromEnvironment('PET_SQL_PATH');
    assert(sqlPath.isNotEmpty, 'Provide SQL file path');
    return PetStatements(sqlPath: sqlPath);
  }

  final String sqlPath;
  final List<PreparedStatement> stmts = [];
}

extension Utils on PetStatements {
  Future<void> prepare(Database database) async {
    if (stmts.isNotEmpty) return;
    final file = File.fromUri(Uri.file(sqlPath));
    final content = await file.readAsString();
    stmts.addAll(database.prepareMultiple(content));
  }
}
