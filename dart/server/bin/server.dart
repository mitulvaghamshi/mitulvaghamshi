import 'dart:io';

import 'package:server/config.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

void main(List<String> args) async {
  final config = Config.fromArg(args);

  /// Configure a pipeline that logs requests.
  final handler = Pipeline() //
      .addMiddleware(logRequests())
      .addHandler(config.router.call);

  final ip = InternetAddress.loopbackIPv4;
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);

  print('Server listening on port ${server.port}');
}
