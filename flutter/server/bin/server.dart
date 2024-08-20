import 'dart:io';

import 'package:server/config.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_static/shelf_static.dart';

Future<void> main() async {
  final config = Config.fromEnv();
  await config.init();

  final staticHandler = createStaticHandler(
    'web',
    defaultDocument: 'index.html',
  );

  // Configure a pipeline that logs requests.
  final handler = const Pipeline().addMiddleware(logRequests()).addHandler((
    request,
  ) async {
    if (request.url.path.isEmpty) return staticHandler(request);
    if (request.url.path == 'favicon.ico') return staticHandler(request);
    if (request.url.path.startsWith('api')) return config.apiHandler(request);
    if (await File('web/${request.url.path}').exists()) {
      return staticHandler(request);
    }
    return .notFound('<h1>404 Not Found!</h1>\n');
  });

  final ip = InternetAddress.loopbackIPv4;
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);

  print('Server listening on port ${server.port}...');
}
