import 'package:bootstrap_dart/bootstrap/bootstrap_renderer.dart';
import 'package:deact/deact.dart';
import 'package:deact_bootstrap/deact_bootstrap.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    DeactBootstrapRenderer.setUp();

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {
      expect(bootstrapRenderer.el('div'), isA<DeactNode>());
    });
  });
}
