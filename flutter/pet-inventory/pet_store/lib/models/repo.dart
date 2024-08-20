import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pet_store/models/pet.dart';

typedef FromJson<T> = T Function(Object? json);

final _headers = {
  HttpHeaders.acceptHeader: ContentType.json.value,
  HttpHeaders.contentTypeHeader: ContentType.json.value,
};

const host = String.fromEnvironment('HOST');

@immutable
interface class Repo<T> {
  const Repo({required this.items});

  const Repo.empty() : items = const [];

  final Iterable<T> items;

  static Future<Repo<T>> query<T>(Uri uri, FromJson<T> fromJson) async {
    final res = await http.get(uri, headers: _headers);
    if (res.statusCode != HttpStatus.ok) {
      throw HttpException('[Status]: ${res.statusCode}, ${res.reasonPhrase}');
    }
    if (jsonDecode(res.body) case Iterable<dynamic> items) {
      return Repo<T>(items: items.map(fromJson));
    }
    throw FormatException('[$Repo/query]: Invalid JSON');
  }

  static Future<bool> insert<T>(Uri uri, Pet pet) async {
    final res = await http.post(
      uri,
      headers: _headers,
      body: jsonEncode(pet.toMap),
    );
    return res.statusCode == HttpStatus.ok;
  }

  static Future<bool> update<T>(Uri uri, Pet pet) async {
    final res = await http.patch(
      uri,
      headers: _headers,
      body: jsonEncode(pet.toMap),
    );
    return res.statusCode == HttpStatus.ok;
  }

  static Future<bool> delete<T>(Uri uri) async {
    final res = await http.delete(uri, headers: _headers);
    return res.statusCode == HttpStatus.ok;
  }
}
