import 'dart:io';

import 'package:checkout_queue/store.dart';
import 'package:checkout_queue/store_config.dart';

void main(List<String> args) {
  if (args.isEmpty) throw 'Input data file path cannot be empty.';
  try {
    final entries =
        File.fromUri(Uri.file(args.first)).readAsLinesSync().iterator;
    if (entries.moveNext()) {
      final config = StoreConfig.from(entries.current);
      final store = Store(config: config);

      store.populateStore(entries);
      store.printQueueInfo();
      store.serveCustomers();
    }
  } on PathExistsException {
    print('[ERROR]: File does not exist.');
  }
}
