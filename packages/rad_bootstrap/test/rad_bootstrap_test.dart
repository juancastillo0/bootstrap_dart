import 'package:bootstrap_dart/bootstrap/bootstrap_renderer.dart';
import 'package:rad/rad.dart';
import 'package:rad_bootstrap/rad_bootstrap.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    RadBootstrapRenderer.setUp();

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {
      expect(bootstrapRenderer.el('div'), isA<Widget>());
    });
  });
}
