import 'package:web/web.dart' as web;

void todo(web.HTMLElement root) {
  for (var item in thingsTodo()) {
    root.appendChild(web.HTMLLIElement()..textContent = item);
  }
}

Iterable<String> thingsTodo() sync* {
  final actions = ['Walk', 'Wash', 'Feed'];
  final pets = ['cats', 'dogs'];

  for (var action in actions) {
    for (var pet in pets) {
      if (pet != 'cats' || action != 'Feed') {
        yield '$action the $pet';
      }
    }
  }
}
