import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;
  bool _initialized = false;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    print('[ThemeProvider] Constructor called');
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    print('[ThemeProvider] Loading theme preference...');
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeIndex = prefs.getInt('themeMode');
      if (themeIndex != null && themeIndex < ThemeMode.values.length) {
        _themeMode = ThemeMode.values[themeIndex];
        print('[ThemeProvider] Loaded theme from prefs: $_themeMode');
      } else {
        print('[ThemeProvider] No valid theme in prefs, using default: $_themeMode');
      }
    } catch (e) {
      print('[ThemeProvider] Error loading theme preference: $e');
    }
    _initialized = true;
    print('[ThemeProvider] Initialization complete');
    notifyListeners();
  }

  Future<void> setTheme(ThemeMode mode) async {
    print('[ThemeProvider] setTheme called with $mode, initialized: $_initialized');
    print('[ThemeProvider] Current theme before change: $_themeMode');
    
    // Always allow theme changes, even during initialization
    if (_themeMode == mode) {
      print('[ThemeProvider] Theme already set to $mode, no change');
      return;
    }
    
    _themeMode = mode;
    print('[ThemeProvider] Theme changed to $_themeMode');
    
    // Save to preferences
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('themeMode', mode.index);
      print('[ThemeProvider] Theme saved to prefs with index: ${mode.index}');
    } catch (e) {
      print('[ThemeProvider] Error saving theme to prefs: $e');
    }
    
    // Always notify listeners to trigger UI update
    print('[ThemeProvider] Notifying listeners...');
    notifyListeners();
    print('[ThemeProvider] Listeners notified');
  }

  void toggleTheme() {
    print('[ThemeProvider] toggleTheme called');
    if (_themeMode == ThemeMode.dark) {
      setTheme(ThemeMode.light);
    } else if (_themeMode == ThemeMode.light) {
      setTheme(ThemeMode.system);
    } else {
      setTheme(ThemeMode.dark);
    }
  }

  // Helper method to get current theme name
  String getCurrentThemeName() {
    switch (_themeMode) {
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.system:
        return 'System';
    }
  }
}

