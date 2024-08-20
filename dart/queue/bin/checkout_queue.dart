import 'dart:io';

import 'package:queue/store.dart';

void main(List<String> args) async {
  if (args.isEmpty) throw 'Please provide input file.';
  try {
    final file = File.fromUri(.file(args.first));
    final iter = (await file.readAsLines()).iterator;
    if (iter.moveNext()) {
      Store(config: .fromStr(iter.current))
        ..populateStore(iter)
        ..printQueueInfo()
        ..serveCustomers();
    }
  } on PathExistsException catch (e) {
    throw '[ERROR]: File does not exists: ${e.path}';
  }
}
