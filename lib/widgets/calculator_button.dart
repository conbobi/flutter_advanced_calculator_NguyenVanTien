import 'package:flutter/material.dart';

enum ButtonType {
  number,
  operator,
  function,
  equals,
}

class CalculatorButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final ButtonType type;

  const CalculatorButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = ButtonType.number,
  });

  @override
  State<CalculatorButton> createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getButtonColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    switch (widget.type) {
      case ButtonType.operator:
      case ButtonType.equals:
        return colorScheme.tertiary; 
        
      case ButtonType.function:
        return colorScheme.secondary; 
        
      case ButtonType.number:
        return Theme.of(context).brightness == Brightness.dark 
            ? const Color(0xFF1E1E1E)
            : const Color(0xFFF5F5F5);
    }
  }

  Color _getTextColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    if (isDark) {
    switch (widget.type) {
      case ButtonType.operator:
        return Colors.amber;
      case ButtonType.equals:
        return Colors.black;
      case ButtonType.function:
      case ButtonType.number:
        return Colors.white;
    }
  }

    switch (widget.type) {
      case ButtonType.operator:
      case ButtonType.equals:
        return Colors.white;
      case ButtonType.function:
        return isDark ? Colors.white : Colors.white;
      case ButtonType.number:
        return isDark ? Colors.white : Colors.black87;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Material(
        color: _getButtonColor(context),
        borderRadius: BorderRadius.circular(16),
        elevation: 2,
        child: InkWell(
          onTap: () {
            _controller.forward().then((_) => _controller.reverse());
            widget.onPressed();
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: _getTextColor(context),
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ),
      ),
    );
  }
}