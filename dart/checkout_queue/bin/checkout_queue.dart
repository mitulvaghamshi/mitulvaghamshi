import 'dart:io';

import 'package:checkout_queue/config.dart';
import 'package:checkout_queue/store.dart';

void main(List<String> args) async {
  if (args.isEmpty) throw 'Please provide input file.';
  try {
    final file = File.fromUri(Uri.file(args.first));
    final iter = (await file.readAsLines()).iterator;
    if (iter.moveNext()) {
      Store(config: Config.fromStr(iter.current))
        ..populateStore(iter)
        ..printQueueInfo()
        ..serveCustomers();
    }
  } on PathExistsException {
    print('[ERROR]: File does not exist.');
  }
}
