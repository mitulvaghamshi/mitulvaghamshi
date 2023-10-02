import 'package:apis/contact/contact_screen.dart';
import 'package:flutter/cupertino.dart';

@immutable
class Contact {
  const Contact({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  static String path = 'assets/users.json';

  static Contact Function(Map<String, dynamic> json) factory = Contact.fromJson;

  static Widget Function(Iterable<Contact> items) builder =
      ContactScreen.builder;

  factory Contact.fromJson(final Map<String, dynamic> json) {
    if (json
        case {
          'id': final int id,
          'first_name': final String firstName,
          'last_name': final String lastName,
          'email': final String email,
          'phone': final String phone,
        }) {
      return Contact(
        id: id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
      );
    }
    throw '[Contact]: Invalid JSON data.';
  }
}
