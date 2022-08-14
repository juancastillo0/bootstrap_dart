import 'package:bootstrap_dart/bootstrap/bootstrap_renderer.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_bootstrap/jaspr_bootstrap.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    JasprBootstrapRenderer.setUp();

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {
      expect(bootstrapRenderer.el('div'), isA<Component>());
    });
  });
}
