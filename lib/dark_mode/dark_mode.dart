/// https://github.com/vinorodrigues/bootstrap-dark-5/blob/main/docs/darkmode.js.md
/// version 1.1.3
export '../src/_dark_mode_interface.dart'
    if (dart.library.html) '../src/_dark_mode_js.dart';

class SavedValue<T> {
  final T Function() get;
  final void Function(T newValue) set;
  final void Function()? dispose;

  const SavedValue({
    required this.get,
    required this.set,
    this.dispose,
  });
}
