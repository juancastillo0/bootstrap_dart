import 'package:deact/deact.dart';
import 'package:universal_html/html.dart' as html;

class ServerRenderer extends Renderer {
  // List<html.Node>? childrenToAdd;
  final List<MapEntry<html.Node, List<html.Node>>> elementStack = [];
  bool _skip = false;
  final _skipNode = html.Element.tag('server-renderer-skip-node');

  @override
  html.Element elementClose(String tagname) {
    final lastE = elementStack.last.key as html.Element;
    final isValid =
        elementStack.isNotEmpty && lastE.tagName.toLowerCase() == tagname;
    if (!isValid) {
      throw Exception('$tagname ${lastE.tagName} $elementStack');
    }

    _executeDiff();
    return lastE;
  }

  @override
  html.Element elementOpen(
    String tagname, [
    String? key,
    List<Object>? staticPropertyValuePairs,
    List<Object>? propertyValuePairs,
  ]) {
    final elem = html.Element.tag(tagname);

    String? attr;
    for (final prop in (staticPropertyValuePairs ?? [])
        .followedBy((propertyValuePairs ?? []))) {
      if (attr == null) {
        attr = prop as String;
      } else {
        if (prop is! Function) {
          elem.setAttribute(attr, prop.toString());
        }
        attr = null;
      }
    }
    elementStack.last.value.add(elem);
    elementStack.add(MapEntry(elem, []));
    // childrenToAdd!.add(elem);
    return elem;
  }

  @override
  void patch(
    html.Node node,
    void Function(Object? p1) description, [
    Object? data,
  ]) {
    // final prev = childrenToAdd;
    // childrenToAdd ??= [];
    final addNew = elementStack.isEmpty || elementStack.last.key != node;
    if (addNew) {
      elementStack.add(MapEntry(node, []));
      description(data);
      _executeDiff();
    } else {
      description(data);
    }
    // print('$node $childrenToAdd');
    // childrenToAdd = prev;
  }

  void _executeDiff() {
    final entry = elementStack.removeLast();
    if (_skip) {
      _skip = false;
      return;
    }
    final items = entry.key.childNodes.toList();
    for (final element in items) {
      element.remove();
    }
    int i = -1;
    entry.value.map((e) {
      i++;
      return e == _skipNode ? items[i] : e;
    }).forEach(entry.key.append);
  }

  @override
  void skip() {
    _skip = true;
  }

  @override
  void skipNode() {
    elementStack.last.value.add(_skipNode);
  }

  @override
  html.Text text(String value, {List<String Function(Object p1)>? formatters}) {
    final t = html.Text(value);
    elementStack.last.value.add(t);
    return t;
  }
}
