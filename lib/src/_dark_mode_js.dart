import 'package:universal_web/web.dart' as web;
import 'dart:async';
import 'dart:js_interop' as js;
import 'dart:js_interop_unsafe';

import '../dark_mode/dark_mode.dart';
import '_dark_mode_interface.dart' as dm;

class DarkMode implements dm.DarkMode {
  DarkMode({SavedValue<bool> Function(bool inDarkMode)? inDarkModeValue}) {
    bool previousDarkMode = _obj['inDarkMode']!.isTruthy.toDart;
    savedValue =
        inDarkModeValue?.call(previousDarkMode) ??
        SavedValue(
          get: () => previousDarkMode,
          set: (newValue) => previousDarkMode = newValue,
        );
    _observer.observe(
      web.document.querySelector('html')!,
      web.MutationObserverInit(
        attributes: true,
        attributeFilter: ['data-bs-color-scheme'.toJS, 'class'.toJS].toJS,
      ),
    );
  }
  late final SavedValue<bool> savedValue;

  late final _observer = web.MutationObserver(
    (mutations, observer) {
      final newValue = _obj['inDarkMode']!.isTruthy.toDart;

      if (savedValue.get() != newValue) {
        savedValue.set(newValue);
        _controller.add(newValue);
      }
    }.toJS,
  );
  final _controller = StreamController<bool>.broadcast();
  @override
  Stream<bool> get inDarkModeChanges => _controller.stream;

  js.JSObject get _obj => js.globalContext.getProperty('darkmode'.toJS);

  @override
  void resetDarkMode() => _obj.callMethod('resetDarkMode'.toJS);
  @override
  void toggleDarkMode({bool save = true}) =>
      _obj.callMethod('toggleDarkMode'.toJS, save.toJS);
  @override
  void setDarkMode({bool toDarkMode = true, bool save = true}) =>
      _obj.callMethod('setDarkMode'.toJS, toDarkMode.toJS, save.toJS);

  @override
  bool get inDarkMode => savedValue.get();
  @override
  String getSavedColorScheme() => _obj.callMethod('getSavedColorScheme'.toJS);
  @override
  String getPreferedColorScheme() =>
      _obj.callMethod('getPreferedColorScheme'.toJS);
  @override
  String getColorScheme() => _obj.callMethod('getColorScheme'.toJS);

  @override
  void dispose() async {
    _observer.disconnect();
    savedValue.dispose?.call();
    await _controller.close();
  }

  // readValue
  // eraseValue
}
