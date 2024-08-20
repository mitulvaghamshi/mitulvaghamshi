import 'dart:js_interop';

import 'package:web/web.dart' as web;

import 'clock.dart';
// import 'todo.dart';

void main() {
  web.console.log('Last checkin: ${DateTime.now()}'.toJS);

  final root = web.document.querySelector('#output') as web.HTMLDivElement;
  drawClock(root);
  // todo(root);
}
