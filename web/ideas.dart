import 'package:universal_html/html.dart';
import 'package:incremental_dom_bindings/incremental_dom_bindings.dart';

void runApp(String elementId, Component component) async {
  final root = querySelector('#$elementId')!;

  patch(root, (_) {
    // open a div element with the attributes id and style
    elementOpen('div', null, [
      'id',
      'testId',
      'style',
      {'color': 'red'}
    ]);

    // add a text inside the div element
    text('Hello World');

    // close the div element
    elementClose('div');
  });

  await Future.delayed(const Duration(seconds: 5));

  patch(root, (_) {
    // open a div element with the attributes id and style
    // elementOpen('div', null, [
    //   'id',
    //   'testId',
    //   'style',
    //   {'color': 'blue'}
    // ]);

    elementOpenStart('div', null, [
      'id',
      'testId',
    ]);

    attr('style', {'color': 'blue'});

    elementOpenEnd();

    // add a text inside the div element
    text('Hello World!');

    // close the div element
    elementClose('div');
  });
  print('ded');

  // final n = component.build();
  // root.append(Element.html(
  //   '<${n.tag} style="${n.style}" class="${n.classes}"></${n.tag}>',
  // ));
}

void patchMobx(Node node, void Function(Object?) description, [Object? data]) {
  final value = StackValue();
  Component.elementStack.add(value);
  patch(
    node,
    (p0) {
      description(p0);
    },
    data,
  );
}

class StackValue {
  StackValue();
}

abstract class Component {
  static final List<StackValue> elementStack = [];

  static void startScope(void Function(StackValue) fn) {}

  void _create() {}

  Elem build();
}

class Elem {
  final String tag;
  final String style;
  final String classes;
  final dynamic children;

  Elem(
    this.tag,
    this.style,
    this.classes, [
    this.children,
  ]);
}

class Button extends Component {
  final Model model;

  Button(this.model);

  @override
  Elem build() {
    return Elem('button', '', '', 'ded');
  }
}

class Model {
  final String data;

  Model(this.data);
}
