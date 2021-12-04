import 'dart:convert';
import 'dart:io';

void main() async {
  final client = HttpClient();
  final req = await client.getUrl(Uri.parse(
    'https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css',
  ));
  final res = await req.close();
  if (res.statusCode != 200) {
    throw Exception(res);
  }
  final body = await utf8.decodeStream(res);
  final List<String> iconNames = [];
  for (final line in body.split('\n').reversed) {
    if (line.isEmpty) {
      if (iconNames.isEmpty) continue;
      break;
    }
    final indexBefore = line.indexOf('::before');
    iconNames.add(line.substring(4, indexBefore));
  }
  final numRegExp = RegExp('[0-9]');
  final _mappedIconNames = iconNames.reversed
      .map((e) => e.replaceAll('-', '_'))
      .map((e) => e.startsWith(numRegExp) ? '_$e' : e);

  final iconsStr = '''
extension BIconExt on BIcon {
  String get nameHtml {
    final _name = toString().split('.').last;
    return _name.startsWith('_')
        ? _name.substring(1).replaceAll('_', '-')
        : _name.replaceAll('_', '-');
  }
}

enum BIcon {
  ${_mappedIconNames.join(',\n  ')},
}
''';

  final file = await File('./web/bootstrap_icons.dart').create();
  await file.writeAsString(_iconComponent + iconsStr);
}

const _iconComponent = r'''
import 'package:deact/deact.dart';

DeactNode icon(
  BIcon icon, {
  String? color,
  String fontSize = '1rem',
  String? ariaLabel,
}) {
  return el(
    'i',
    attributes: {
      'class': 'bi-${icon.nameHtml}',
      'style': 'font-size: $fontSize;${color == null ? '' : ' color: $color;'}',
      'role': "img",
      if (ariaLabel != null) 'aria-label': ariaLabel,
    },
  );
}
''';
