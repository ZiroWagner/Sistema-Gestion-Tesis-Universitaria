import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Clase que maneja el estado del tema (oscuro o claro)
class ThemeProvider with ChangeNotifier {
  static const String _keyThemeMode = 'theme_mode';

  // El estado predeterminado del tema será claro
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  // Constructor que intenta cargar el tema desde SharedPreferences
  ThemeProvider() {
    _loadTheme();
  }

  // Método para cambiar el tema
  void toggleTheme() async {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }

    // Guardar el cambio en SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyThemeMode, _themeMode == ThemeMode.dark ? 'dark' : 'light');

    notifyListeners(); // Notifica a los widgets que están escuchando el cambio
  }

  // Cargar el tema almacenado desde SharedPreferences
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeMode = prefs.getString(_keyThemeMode) ?? 'light';
    _themeMode = themeMode == 'dark' ? ThemeMode.dark : ThemeMode.light;

    notifyListeners();
  }
}
