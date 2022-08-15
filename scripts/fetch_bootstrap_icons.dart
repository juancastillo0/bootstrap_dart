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
      .map((e) => e.startsWith(numRegExp) ? '\$$e' : e);

  final iconsStr = '''
extension BIconExt on BIcon {
  /// The html name of the icon to be used as a css class
  String get nameHtml {
    String _name = name;
    _name = _name.startsWith('\\\$')
        ? _name.substring(1).replaceAll('_', '-')
        : _name.replaceAll('_', '-');

    return 'bi-\$_name';
  }
}

/// The list of Bootstrap icons in bootstrap-icons@1.7.2.
///
/// https://icons.getbootstrap.com/
enum BIcon {
  ${_mappedIconNames.join(',\n  ')},
}
''';

  final file = await File('./lib/bootstrap/icons.dart').create();
  await file.writeAsString(_iconComponent + iconsStr);
}

const _iconComponent = r'''
// ignore_for_file: constant_identifier_names

import '../src/prelude.dart';

/// Return an "i" html element with the bootstrap [icon]
///
/// https://icons.getbootstrap.com/
DeactNode icon(
  BIcon icon, {
  String? color,
  String? fontSize,
  String? ariaLabel,
  String? style,
  Map<String, Object>? attributes,
}) {
  return el(
    'i',
    attributes: {
      'class': icon.nameHtml,
      'style': '${fontSize == null ? '' : 'font-size: $fontSize;'}'
          '${color == null ? '' : ' color: $color;'}${style ?? ''}',
      'role': "img",
      if (ariaLabel != null) 'aria-label': ariaLabel,
      if (attributes != null) ...attributes,
    },
  );
}

''';
