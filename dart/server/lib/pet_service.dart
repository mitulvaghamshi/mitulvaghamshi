import 'package:server/pet_statements.dart';
import 'package:sqlite3/sqlite3.dart';

extension PetService on PetStatements {
  ResultSet get selectAll {
    return stmts[StmtType.query.index].selectWith(
      const StatementParameters.empty(),
    );
  }

  ResultSet selectBy(int id) {
    return stmts[StmtType.select.index].selectWith(
      StatementParameters.named({':id': id}),
    );
  }

  ResultSet search(String term) {
    return stmts[StmtType.search.index].selectWith(
      StatementParameters.named({':q': term}),
    );
  }

  ResultSet insert({
    required String animal,
    required String desc,
    required int age,
    required double price,
  }) {
    return stmts[StmtType.insert.index].selectWith(
      StatementParameters.named({
        ':animal': animal,
        ':desc': desc,
        ':age': age,
        ':price': price,
      }),
    );
  }

  ResultSet update({
    required int id,
    required String animal,
    required String desc,
    required int age,
    required double price,
  }) {
    return stmts[StmtType.update.index].selectWith(
      StatementParameters.named({
        ':animal': animal,
        ':desc': desc,
        ':age': age,
        ':price': price,
        ':id': id,
      }),
    );
  }

  ResultSet delete(int id) {
    return stmts[StmtType.delete.index].selectWith(
      StatementParameters.named({':id': id}),
    );
  }
}
