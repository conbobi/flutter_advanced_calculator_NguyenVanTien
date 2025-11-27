import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/calculator_provider.dart';
import '../providers/history_provider.dart';
import '../models/calculator_settings.dart';
import '../models/calculator_mode.dart';
import '../services/storage_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Consumer<CalculatorProvider>(
        builder: (context, calcProvider, _) {
          final settings = calcProvider.settings;

          return ListView(
            children: [
              ExpansionTile(
                leading: const Icon(Icons.color_lens),
                title: const Text('Appearance'),
                children: [
                  _buildThemeSelector(context),
                ],
              ),

              ExpansionTile(
                leading: const Icon(Icons.calculate),
                title: const Text('Calculator'),
                children: [
                  _buildDecimalPrecisionSelector(
                      context, settings, calcProvider),
                  _buildAngleModeSelector(
                      context, settings, calcProvider),
                ],
              ),

              ExpansionTile(
                leading: const Icon(Icons.vibration),
                title: const Text('Feedback'),
                children: [
                  _buildSwitchTile(
                    'Haptic Feedback',
                    settings.hapticFeedback,
                    (value) {
                      final newSettings = settings.copyWith(
                        hapticFeedback: value,
                      );
                      calcProvider.updateSettings(newSettings);
                      StorageService.saveSettings(newSettings);
                    },
                  ),
                  _buildSwitchTile(
                    'Sound Effects',
                    settings.soundEffects,
                    (value) {
                      final newSettings = settings.copyWith(
                        soundEffects: value,
                      );
                      calcProvider.updateSettings(newSettings);
                      StorageService.saveSettings(newSettings);
                    },
                  ),
                ],
              ),

              ExpansionTile(
                leading: const Icon(Icons.history),
                title: const Text('History'),
                children: [
                  _buildHistorySizeSelector(
                      context, settings, calcProvider),
                  _buildClearHistoryButton(context),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  // -------------------------------
  // SECTION TITLE
  // -------------------------------

  Widget _buildThemeSelector(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, provider, _) {
        return ListTile(
          title: const Text('Theme'),
          subtitle: Text(_getThemeDisplayName(provider.themeMode)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Select Theme'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildThemeOption(context, 'Light', 'light', provider),
                    _buildThemeOption(context, 'Dark', 'dark', provider),
                    _buildThemeOption(context, 'System', 'system', provider),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildThemeOption(
      BuildContext context,
      String label,
      String value,
      ThemeProvider provider,
      ) {
    return RadioListTile<String>(
      title: Text(label),
      value: value,
      groupValue: provider.themeMode,
      onChanged: (newValue) {
        if (newValue != null) {
          provider.setTheme(newValue);
          Navigator.pop(context);
        }
      },
    );
  }

  String _getThemeDisplayName(String theme) {
    switch (theme) {
      case 'light':
        return 'Light';
      case 'dark':
        return 'Dark';
      default:
        return 'System';
    }
  }

  // -------------------------------
  // DECIMAL PRECISION
  // -------------------------------

  Widget _buildDecimalPrecisionSelector(
      BuildContext context,
      CalculatorSettings settings,
      CalculatorProvider provider,
      ) {
    return ListTile(
      title: const Text('Decimal Precision'),
      subtitle: Text('${settings.decimalPrecision} decimal places'),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Decimal Precision'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(9, (index) {
                final precision = index + 2;
                return RadioListTile<int>(
                  title: Text('$precision decimal places'),
                  value: precision,
                  groupValue: settings.decimalPrecision,
                  onChanged: (value) {
                    if (value != null) {
                      final newSettings = settings.copyWith(
                        decimalPrecision: value,
                      );
                      provider.updateSettings(newSettings);
                      StorageService.saveSettings(newSettings);
                      Navigator.pop(context);
                    }
                  },
                );
              }),
            ),
          ),
        );
      },
    );
  }

  // -------------------------------
  // ANGLE MODE
  // -------------------------------

  Widget _buildAngleModeSelector(
      BuildContext context,
      CalculatorSettings settings,
      CalculatorProvider provider,
      ) {
    return ListTile(
      title: const Text('Angle Mode'),
      subtitle: Text(settings.angleMode.displayName),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Angle Mode'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<AngleMode>(
                  title: const Text('Degrees (DEG)'),
                  value: AngleMode.degrees,
                  groupValue: settings.angleMode,
                  onChanged: (value) {
                    if (value != null) {
                      final newSettings = settings.copyWith(
                        angleMode: value,
                      );
                      provider.updateSettings(newSettings);
                      StorageService.saveSettings(newSettings);
                      Navigator.pop(context);
                    }
                  },
                ),
                RadioListTile<AngleMode>(
                  title: const Text('Radians (RAD)'),
                  value: AngleMode.radians,
                  groupValue: settings.angleMode,
                  onChanged: (value) {
                    if (value != null) {
                      final newSettings = settings.copyWith(
                        angleMode: value,
                      );
                      provider.updateSettings(newSettings);
                      StorageService.saveSettings(newSettings);
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // -------------------------------
  // HISTORY SIZE
  // -------------------------------

  Widget _buildHistorySizeSelector(
      BuildContext context,
      CalculatorSettings settings,
      CalculatorProvider provider,
      ) {
    return ListTile(
      title: const Text('History Size'),
      subtitle: Text('${settings.historySize} calculations'),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('History Size'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [25, 50, 100].map((size) {
                return RadioListTile<int>(
                  title: Text('$size calculations'),
                  value: size,
                  groupValue: settings.historySize,
                  onChanged: (value) {
                    if (value != null) {
                      final newSettings = settings.copyWith(
                        historySize: value,
                      );
                      provider.updateSettings(newSettings);
                      StorageService.saveSettings(newSettings);

                      Provider.of<HistoryProvider>(context, listen: false)
                          .setMaxHistorySize(value);

                      Navigator.pop(context);
                    }
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  // -------------------------------
  // FEEDBACK SWITCH
  // -------------------------------

  Widget _buildSwitchTile(
      String title,
      bool value,
      Function(bool) onChanged,
      ) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }

  // -------------------------------
  // CLEAR HISTORY
  // -------------------------------

  Widget _buildClearHistoryButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Clear All History'),
              content: const Text(
                  'Are you sure you want to clear all calculation history? '
                      'This action cannot be undone.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Provider.of<HistoryProvider>(context, listen: false)
                        .clearHistory();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('History cleared')),
                    );
                  },
                  child: const Text('Clear'),
                ),
              ],
            ),
          );
        },
        child: const Text('Clear All History'),
      ),
    );
  }
}
