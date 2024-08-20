import 'package:flutter/cupertino.dart';

@immutable
class Pet {
  const Pet({
    required this.id,
    required this.name,
    required this.info,
    required this.age,
    required this.price,
  });

  const Pet.empty()
    : id = -1,
      name = 'New pet',
      info = 'Describe some unique characteristics.',
      age = 0,
      price = 0.0;

  factory Pet.fromJson(Object? json) {
    if (json case {
      'id': int id,
      'animal': String name,
      'description': String info,
      'age': int age,
      'price': num price,
    }) {
      return Pet(
        id: id,
        name: name,
        info: info,
        age: age,
        price: price.toDouble(),
      );
    }
    throw FormatException('[$Pet]: Invalid JSON, $json');
  }

  final int id;
  final String name;
  final String info;
  final int age;
  final double price;
}

extension Urils on Pet {
  Pet copyWith({String? name, String? info, int? age, double? price}) => .new(
    id: id,
    name: name ?? this.name,
    info: info ?? this.info,
    age: age ?? this.age,
    price: price ?? this.price,
  );

  Map<String, dynamic> get toMap => {
    'id': id,
    'animal': name,
    'description': info,
    'age': age,
    'price': price,
  };
}
