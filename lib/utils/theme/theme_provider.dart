import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark = true;
  bool get isDark => _isDark;

  SharedPreferences? _prefs;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    _prefs ??= await SharedPreferences.getInstance();
    _isDark = _prefs?.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDark = !_isDark;
    await _prefs?.setBool('isDarkMode', _isDark);
    notifyListeners();
  }

  ThemeMode get themeMode => _isDark ? ThemeMode.dark : ThemeMode.light;
}
