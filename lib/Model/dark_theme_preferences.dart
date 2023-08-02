import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreferences {
  final _box = GetStorage();

  static const _isDarkMode = 'isDarkMode';

  bool getDarkTheme() => _box.read(_isDarkMode) ?? false;

  void setDarkTheme(bool value) => _box.write(_isDarkMode, value);
}
