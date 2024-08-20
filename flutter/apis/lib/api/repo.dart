import 'dart:convert';
import 'dart:io';

import 'package:apis/models/inventory.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

typedef JsonCallback<T> = T Function(Map<String, dynamic> json);

final _headers = {HttpHeaders.contentTypeHeader: ContentType.json.value};

@immutable
interface class Repo<T> {
  const Repo({required this.items});

  const Repo.empty() : items = const [];

  final Iterable<T> items;

  static Future<Repo<T>> asset<T>(String path, JsonCallback<T> fromJson) async {
    assert(path.isNotEmpty, '[Repo(asset)]: Invalid asset path');
    final data = await rootBundle.loadString(path);
    final items = List<Map<String, dynamic>>.from(jsonDecode(data));
    return Repo<T>(items: items.map(fromJson));
  }

  static Future<Repo<T>> query<T>(Uri uri, JsonCallback<T> fromJson) async {
    final response = await http.get(uri, headers: _headers);
    if (response.statusCode == 200) {
      final items = List<Map<String, dynamic>>.from(jsonDecode(response.body));
      return Repo<T>(items: items.map(fromJson));
    }
    throw '[Repo(query)]: Invalid json data';
  }

  static Future<bool> insert<T>(Uri uri, Pet pet) async {
    final response = await http.post(uri, headers: _headers, body: pet.toJson);
    return response.statusCode == 200;
  }

  static Future<bool> update<T>(Uri uri, Pet pet) async {
    final response = await http.patch(uri, headers: _headers, body: pet.toJson);
    return response.statusCode == 200;
  }

  static Future<bool> delete<T>(Uri uri) async {
    final response = await http.delete(uri, headers: _headers);
    return response.statusCode == 200;
  }
}
