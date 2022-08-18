const darkMode = DarkMode._();

class DarkMode {
  const DarkMode._();

  Stream<bool> get inDarkModeChanges => Stream.empty();

  void resetDarkMode() {}
  void toggleDarkMode({bool save = true}) {}
  void setDarkMode({bool toDarkMode = true, bool save = true}) {}

  bool get inDarkMode => false;
  String getSavedColorScheme() => 'light';
  String getPreferedColorScheme() => 'light';
  String getColorScheme() => 'light';

  // readValue
  // eraseValue
}
