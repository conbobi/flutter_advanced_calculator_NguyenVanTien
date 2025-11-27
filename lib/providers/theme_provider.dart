import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../services/storage_service.dart';

class ThemeProvider with ChangeNotifier {
  String _themeMode = 'system';
  
  ThemeProvider() {
    _loadTheme();
  }

  String get themeMode => _themeMode;

  ThemeMode get currentThemeMode {
    switch (_themeMode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  ThemeData get currentTheme {
    if (_themeMode == 'light') {
      return AppTheme.lightTheme;
    } else if (_themeMode == 'dark') {
      return AppTheme.darkTheme;
    }
    return AppTheme.darkTheme;
  }

  void setTheme(String mode) {
    _themeMode = mode;
    StorageService.saveTheme(mode);
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    _themeMode = await StorageService.getTheme();
    notifyListeners();
  }
}