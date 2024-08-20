part of '../fake_world.dart';

enum WarriorType { hobbit, elf, fighter, wizard, human, any }

mixin Warrior {
  static var _warriorNames = _names.iterator;

  /// Get random name for a warrior.
  static String get generateName {
    while (true) {
      if (_warriorNames.moveNext()) return _warriorNames.current;
      _warriorNames = _names.iterator; // Reset iterator and repeat.
    }
  }
}

final _names = String.fromCharCodes(base64Decode(_name64)).split('|');

const _name64 =
    'RmlvcmVsbGF8QW1icm9naW98R2lhY2ludG98RGVtZXRyaW98U2ltb25ldHRlfEJlcm5hcm'
    'R8V2lsbWFyfFdhbGVlZHxBbGJpb258QmVhdHJpY2V8TWVyaW5vfEJyb253ZW58RWRnYXJk'
    'b3xNYXVyaWNpb3xBbHBob25zb3xNYXJpb3xCYXJyZXR0fEFmb25zb3xBcG9zdG9sb3M=';
