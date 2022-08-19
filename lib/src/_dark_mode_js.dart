import 'dart:html' as html;
import 'dart:async';
import 'dart:js' as js;

import '../dark_mode/dark_mode.dart';
import '_dark_mode_interface.dart' as dm;

class DarkMode implements dm.DarkMode {
  DarkMode({
    SavedValue<bool> Function(bool inDarkMode)? inDarkModeValue,
  }) {
    bool previousDarkMode = _obj['inDarkMode'];
    savedValue = inDarkModeValue?.call(previousDarkMode) ??
        SavedValue(
          get: () => previousDarkMode,
          set: (newValue) => previousDarkMode = newValue,
        );
    _observer.observe(
      html.document.querySelector('html')!,
      attributes: true,
      attributeFilter: ['data-bs-color-scheme', 'class'],
    );
  }
  late final SavedValue<bool> savedValue;

  late final _observer = html.MutationObserver((mutations, observer) {
    final newValue = _obj['inDarkMode'] as bool;

    if (savedValue.get() != newValue) {
      savedValue.set(newValue);
      _controller.add(newValue);
    }
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
  bool get inDarkMode => savedValue.get();
  @override
  String getSavedColorScheme() => _obj.callMethod('getSavedColorScheme');
  @override
  String getPreferedColorScheme() => _obj.callMethod('getPreferedColorScheme');
  @override
  String getColorScheme() => _obj.callMethod('getColorScheme');

  @override
  void dispose() async {
    _observer.disconnect();
    savedValue.dispose?.call();
    await _controller.close();
  }

  // readValue
  // eraseValue
}
