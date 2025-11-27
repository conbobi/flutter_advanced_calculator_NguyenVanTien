import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/calculator_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/history_provider.dart';
import 'screens/calculator_screen.dart';
import 'services/storage_service.dart';
import 'utils/constants.dart';    

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  runApp(const AdvancedCalculatorApp());
}

class AdvancedCalculatorApp extends StatelessWidget {
  const AdvancedCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
        ChangeNotifierProvider(create: (_) => CalculatorProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'Calculator',                     
            theme: AppTheme.lightTheme,              
            darkTheme: AppTheme.darkTheme,           
            themeMode: themeProvider.currentThemeMode,
            home: const CalculatorScreen(),          
          );

        },
      ),
    );
  }
}