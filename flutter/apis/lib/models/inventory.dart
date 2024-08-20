import 'dart:convert';

import 'package:apis/api/repo.dart';
import 'package:apis/tabs/inventory_screen.dart';
import 'package:flutter/foundation.dart';

const _host = 'localhost:8080';

@immutable
mixin Inventory on InventoryScreen {
  static Future<Repo<Pet>> get query => //
      Repo.query(Uri.http(_host, 'api/pets'), Pet.fromJson);

  static Future<Repo<Pet>> search(String term) => //
      Repo.query(Uri.http(_host, 'api/search/$term'), Pet.fromJson);

  static Future<bool> insert(Pet pet) => //
      Repo.insert(Uri.http(_host, 'api'), pet);

  static Future<bool> update(Pet pet) => //
      Repo.update(Uri.http(_host, 'api/${pet.id}'), pet);

  static Future<bool> delete(Pet pet) => //
      Repo.delete(Uri.http(_host, 'api/${pet.id}'));
}

@immutable
class Pet {
  const Pet({
    required this.id,
    required this.animal,
    required this.desc,
    required this.age,
    required this.price,
  });

  const Pet.empty()
      : this(
          id: -1,
          animal: 'New pet',
          desc: 'Describe some unique characteristics.',
          age: 0,
          price: 0.0,
        );

  factory Pet.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          'id': int id,
          'animal': String animal,
          'description': String desc,
          'age': int age,
          'price': num price,
        }) {
      return Pet(
        id: id,
        animal: animal,
        desc: desc,
        age: age,
        price: price.toDouble(),
      );
    }
    throw '[Pet]: Invalid Json data';
  }

  final int id;
  final String animal;
  final String desc;
  final int age;
  final double price;
}

extension PetExt on Pet {
  Pet copyWith({String? animal, String? desc, int? age, double? price}) {
    return Pet(
      id: id,
      animal: animal ?? this.animal,
      desc: desc ?? this.desc,
      age: age ?? this.age,
      price: price ?? this.price,
    );
  }

  String get toJson => jsonEncode(toMap);

  Map<String, dynamic> get toMap => {
        'id': id,
        'animal': animal,
        'description': desc,
        'age': age,
        'price': price,
      };
}
