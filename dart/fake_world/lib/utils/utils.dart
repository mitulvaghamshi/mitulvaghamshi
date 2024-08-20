const _names = [
  'Fiorella',
  'Ambrogio',
  'Giacinto',
  'Demetrio',
  'Simonette',
  'Bernard',
  'Wilmar',
  'Waleed',
  'Albion',
  'Beatrice',
  'Merino',
  'Bronwen',
  'Edgardo',
  'Mauricio',
  'Alphonso',
  'Mario',
  'Barrett',
  'Afonso',
  'Apostolos',
];

enum WarriorType {
  hobbit,
  elf,
  fighter,
  wizard,
  human,
  any;
}

mixin Warrior {
  static var _warriorNames = _names.iterator;

  /// Get random name for a warrior.
  static String get name {
    if (!_warriorNames.moveNext()) _warriorNames = _names.iterator;
    return _warriorNames.current;
  }
}
