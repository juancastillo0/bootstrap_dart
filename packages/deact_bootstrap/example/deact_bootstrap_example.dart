import 'package:bootstrap_dart/bootstrap/bootstrap_renderer.dart';
import 'package:deact/deact.dart';
import 'package:deact_bootstrap/deact_bootstrap.dart';

void main() {
  DeactBootstrapRenderer.setUp();
  final div = bootstrapRenderer.el('div') as DeactNode;

  print('div $div');
}
