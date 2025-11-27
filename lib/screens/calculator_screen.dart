import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../providers/history_provider.dart';
import '../widgets/display_area.dart';
import '../widgets/button_grid.dart';
import '../widgets/mode_selector.dart';
import 'history_screen.dart';
import 'settings_screen.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: PopupMenuButton<String>(
          icon: const Icon(Icons.menu), 
          tooltip: 'Menu tùy chọn',
          onSelected: (value) {
            if (value == 'history') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryScreen()),
              );
            } else if (value == 'settings') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            // Item 1: History
            const PopupMenuItem<String>(
              value: 'history',
              child: Row(
                children: [
                  Icon(Icons.history, color: Colors.grey),
                  SizedBox(width: 12),
                  Text('history'),
                ],
              ),
            ),
            // Item 2: Settings
            const PopupMenuItem<String>(
              value: 'settings',
              child: Row(
                children: [
                  Icon(Icons.settings, color: Colors.grey),
                  SizedBox(width: 12),
                  Text('setting'),
                ],
              ),
            ),
          ],
        ),

        title: const Text('Nguyễn Văn Tiến'),
        centerTitle: true, 

      ),
      body: SafeArea(
        child: Column(
          children: [
            // Display area - flex 3
            const Expanded(
              flex: 3,
              child: DisplayArea(),
            ),
            const SizedBox(height: 8),

            const ModeSelector(), 

            // Button grid - flex 4
            Expanded(
              flex: 4,
              child: Consumer2<CalculatorProvider, HistoryProvider>(
                builder: (context, calcProvider, historyProvider, _) {
                  return ButtonGrid(
                    mode: calcProvider.mode,
                    onInput: calcProvider.input,
                    onOperator: calcProvider.inputOperator,
                    onCalculate: () => calcProvider.calculate(historyProvider),
                    onClear: calcProvider.clear,
                    onClearEntry: calcProvider.clearEntry,
                    onBackspace: calcProvider.backspace,
                    onPercent: calcProvider.percent,
                    onNegate: calcProvider.negate,
                    onScientific: calcProvider.scientificFunction,
                    onMemoryAdd: calcProvider.memoryAdd,
                    onMemorySubtract: calcProvider.memorySubtract,
                    onMemoryRecall: calcProvider.memoryRecall,
                    onMemoryClear: calcProvider.memoryClear,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}