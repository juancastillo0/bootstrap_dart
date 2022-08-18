import 'dart:html' as html;
import 'dart:async';
import 'dart:js' as js;

import '_dark_mode_interface.dart' as dm;

final darkMode = DarkMode._();

class DarkMode implements dm.DarkMode {
  DarkMode._() {
    _observer.observe(
      html.document.querySelector('html')!,
      attributes: true,
      attributeFilter: ['data-bs-color-scheme'],
    );
  }

  late final _observer = html.MutationObserver((mutations, observer) {
    _controller.add(inDarkMode);
  });
  final _controller = StreamController<bool>.broadcast();
  @override
  Stream<bool> get inDarkModeChanges => _controller.stream;

  js.JsObject get _obj => js.context['darkmode'];

  @override
  void resetDarkMode() => _obj.callMethod('resetDarkMode');
  @override
  void toggleDarkMode({bool save = true}) =>
      _obj.callMethod('toggleDarkMode', [save]);
  @override
  void setDarkMode({bool toDarkMode = true, bool save = true}) =>
      _obj.callMethod('setDarkMode', [toDarkMode, save]);

  @override
  bool get inDarkMode => _obj['inDarkMode'];
  @override
  String getSavedColorScheme() => _obj.callMethod('getSavedColorScheme');
  @override
  String getPreferedColorScheme() => _obj.callMethod('getPreferedColorScheme');
  @override
  String getColorScheme() => _obj.callMethod('getColorScheme');

  // readValue
  // eraseValue
}
