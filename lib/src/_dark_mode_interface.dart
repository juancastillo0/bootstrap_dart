import '../dark_mode/dark_mode.dart';

/// https://github.com/vinorodrigues/bootstrap-dark-5/blob/main/docs/darkmode.js.md
/// version 1.1.3
class DarkMode {
  const DarkMode({
    SavedValue<bool> Function(bool inDarkMode)? inDarkModeValue,
  });

  Stream<bool> get inDarkModeChanges => Stream.empty();

  void resetDarkMode() {}
  void toggleDarkMode({bool save = true}) {}
  void setDarkMode({bool toDarkMode = true, bool save = true}) {}

  bool get inDarkMode => false;
  String getSavedColorScheme() => 'light';
  String getPreferedColorScheme() => 'light';
  String getColorScheme() => 'light';

  void dispose() {}

  // readValue
  // eraseValue
}
