import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:test/test.dart';

void main() {
  const host = 'http://localhost:8080';
  late Process process;

  setUp(() async {
    process = await Process.start('dart', [
      'run',
      'bin/server.dart',
      'inventory.sql',
    ]);
    // Wait for server to start and print to stdout.
    await process.stdout.first;
  });

  tearDown(() => process.kill());

  test('Root', () async {
    final response = await http.get(Uri.parse(host));
    expect(response.statusCode, 200);
    expect(response.body, '<h2>Welcome to Pet Inventory API v1.0</h2>\n');
  });

  test('404', () async {
    final response = await http.get(Uri.parse('$host/foobar'));
    expect(response.statusCode, 404);
  });

  test('Get record at id: 1', () async {
    final response = await http.get(Uri.parse('$host/api/pets/1'));
    expect(response.statusCode, 200);
    expect(
      response.body,
      '[{"id":1,"animal":"Dog","description":'
      '"Wags tail when happy","age":2,"price":250.0}]',
    );
  });

  test('Insert a record', () async {
    final response = await http.post(
      Uri.parse('$host/api'),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonEncode({
        "animal": "Jaguar",
        "description": "Beware, its dangerous.",
        "age": 12,
        "price": 500000
      }),
    );
    expect(response.statusCode, 200);
    expect(response.body, 'Inserted successfully');
  });

  test('Update record at id: 2', () async {
    final response = await http.patch(
      Uri.parse('$host/api/2'),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonEncode({
        "animal": "Elephant",
        "description": "A giant and heavy creature",
        "age": 250,
        "price": 250000
      }),
    );
    expect(response.statusCode, 200);
    expect(response.body, 'Updated successfully');
  });

  test('Delete record at id: 1', () async {
    final response = await http.delete(Uri.parse('$host/api/1'));
    expect(response.statusCode, 200);
    expect(response.body, 'Deleted successfully');
  });
}
