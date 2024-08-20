import 'dart:io';

// Global strings to hold the generated content
final _nameList = <String>[];
final _pubList = ['\n  fonts:\n'];

void main(List<String> args) async {
  if (args.isEmpty) {
    throw ArgumentError('Please specify fonts directory!');
  }
  await _generateFontList(args.first);
  await Future.wait([_checkMain(), _updatePubspec()]);
}

Future<void> _generateFontList(String path) async {
  final assetsDir = Directory(path);
  if (!await assetsDir.exists()) {
    throw PathNotFoundException(
      assetsDir.path,
      const OSError('directory does not exists.'),
    );
  }
  await _visit(assetsDir);
}

Future<void> _checkMain() async {
  final mainFile = File('lib/main.dart');
  if (!await mainFile.exists()) {
    stdout.writeln('$mainFile does not exists.');
    return;
  }

  final content = await mainFile.readAsString();
  if (content.contains(RegExp(r'const\s*fonts\s*=\s*\['))) {
    stderr.writeln("'${mainFile.path}' contains fonts, skipping...");
    return;
  }

  final sink = mainFile.openWrite(mode: .append);
  sink.writeln('const fonts = [${_nameList.join(',')}];');
  await sink.close();

  stdout.writeln("Updated '${mainFile.path}'.");
}

Future<void> _updatePubspec() async {
  final pubspecFile = File('pubspec.yaml');
  if (!await pubspecFile.exists()) {
    stderr.writeln("'${pubspecFile.path}' does not exitsts.");
    return;
  }

  final content = await pubspecFile.readAsString();
  if (content.contains(RegExp(r'fonts:\s*'))) {
    stderr.writeln("'${pubspecFile.path}' contains fonts, skipping...");
    return;
  }

  final sink = pubspecFile.openWrite(mode: .append);
  sink.writeAll(_pubList);
  await sink.close();

  stdout.writeln("Updated '${pubspecFile.path}'.");
}

Future<void> _visit(FileSystemEntity entity) async {
  if (entity is Directory) {
    try {
      final children = await entity.list().toList();
      children.sort((a, b) => a.path.compareTo(b.path));
      await Future.forEach(children, _visit);
    } on FileSystemException catch (e) {
      stderr.writeln('Error listing dir ${entity.path}: $e');
    }
  } else if (entity is File) {
    _process(entity);
  }
}

void _process(File file) {
  final path = file.uri.pathSegments;
  final name = path.last.contains('.')
      ? path.last.substring(0, path.last.lastIndexOf('.'))
      : path.last;
  _nameList.add("'$name'");
  _pubList.add(
    '    - family: $name\n      fonts:\n'
    '      - asset: ${path.join('/')}\n',
  );
}
