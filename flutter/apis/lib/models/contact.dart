import 'package:apis/api/repo.dart';
import 'package:apis/tabs/contact_screen.dart';
import 'package:flutter/cupertino.dart';

@immutable
mixin Contacts on ContactScreen {
  static Future<Repo<Contact>> get query =>
      Repo.asset('assets/users.json', Contact.fromJson);
}

@immutable
class Contact {
  const Contact({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          'id': int id,
          'first_name': String firstName,
          'last_name': String lastName,
          'email': String email,
          'phone': String phone,
        }) {
      return Contact(
        id: id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
      );
    }
    throw '[Contact]: Invalid JSON data';
  }

  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
}
