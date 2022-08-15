import 'package:bootstrap_dart/bootstrap/bootstrap_renderer.dart';
import 'package:rad/rad.dart';
import 'package:rad_bootstrap/rad_bootstrap.dart';

void main() {
  RadBootstrapRenderer.setUp();
  final div = bootstrapRenderer.el('div') as Widget;
  print('div $div');
}
