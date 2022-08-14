import 'package:bootstrap_dart/bootstrap/bootstrap_renderer.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_bootstrap/jaspr_bootstrap.dart';

void main() {
  JasprBootstrapRenderer.setUp();
  final div = bootstrapRenderer.el('div') as Component;

  print('div $div');
}
