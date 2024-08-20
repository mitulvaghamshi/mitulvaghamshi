import 'dart:js_interop';

import 'package:web/web.dart' as web;

import 'todo.dart';

void main() {
  final now = DateTime.now();
  web.console.log('Last checkin: ${now.toString()}'.toJS);

  final root = web.document.querySelector('#output') as web.HTMLDivElement;

  todo(root);
}
