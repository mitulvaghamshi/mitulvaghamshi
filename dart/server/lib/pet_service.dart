import 'package:server/pet_database.dart';
import 'package:sqlite3/sqlite3.dart';

extension PetService on PetDatabase {
  ResultSet get selectAll =>
      stmts[StmtType.query.index].selectWith(const .empty());

  ResultSet selectBy(int id) =>
      stmts[StmtType.select.index].selectWith(.named({':id': id}));

  ResultSet search(String term) =>
      stmts[StmtType.search.index].selectWith(.named({':q': term}));

  ResultSet insert({
    required String animal,
    required String desc,
    required int age,
    required double price,
  }) => stmts[StmtType.insert.index].selectWith(
    .named({':animal': animal, ':desc': desc, ':age': age, ':price': price}),
  );

  ResultSet update({
    required int id,
    required String animal,
    required String desc,
    required int age,
    required double price,
  }) => stmts[StmtType.update.index].selectWith(
    .named({
      ':animal': animal,
      ':desc': desc,
      ':age': age,
      ':price': price,
      ':id': id,
    }),
  );

  ResultSet delete(int id) =>
      stmts[StmtType.delete.index].selectWith(.named({':id': id}));
}
