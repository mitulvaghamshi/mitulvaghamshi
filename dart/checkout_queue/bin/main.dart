import 'dart:io';

import 'package:checkout_queue/store.dart';

void main(List<String> args) async {
  if (args.isEmpty) {
    stderr.writeAll([
      '[Error]: Missing Checkout Data file.\n',
      r'Usage: $ dart main.dart path-to-data.txt',
    ]);
    exit(1);
  }

  try {
    final file = File.fromUri(.file(args.first));
    final iter = (await file.readAsLines()).iterator;

    if (iter.moveNext()) {
      Store(config: .fromStr(iter.current))
        ..populateStore(iter)
        ..printQueueInfo()
        ..serveCustomers();
    }
  } on PathNotFoundException catch (e) {
    stderr.writeln('[ERROR]: File does not exists: ${e.path}');
    rethrow;
  }
}
