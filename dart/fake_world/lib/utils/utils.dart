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

enum WarriorType { hobbit, elf, fighter, wizard, human, any }

mixin Warrior {
  static var _warriorNames = _names.iterator;

  /// Get random name for a warrior.
  static String get name {
    while (true) {
      if (_warriorNames.moveNext()) return _warriorNames.current;
      _warriorNames = _names.iterator; // Reset iterator and repeat.
    }
  }
}
