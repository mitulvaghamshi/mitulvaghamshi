import 'dart:io';

import 'package:server/api_server.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

void main(List<String> args) async {
  if (args.isEmpty) {
    print('Usage: dart bin/server.dart ./file.sql ./file.db');
    exit(1);
  }

  final app = args.length < 2
      ? APIServer.inMemory(sqlPath: args.first)
      : APIServer.file(args: args);

  app.configureRoutes();
  await app.prepareStatements();

  // Configure a pipeline that logs requests.
  final handler = Pipeline() //
      .addMiddleware(logRequests())
      .addHandler(app.router.call);

  final ip = InternetAddress.loopbackIPv4;
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);

  print('Server listening on port ${server.port}');
}
