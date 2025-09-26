import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white, // 👈 always white
    cardColor: Colors.white, // 👈 white boxes in light mode
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white, // 👈 still white in dark mode
    cardColor: const Color(0xFF0D1B2A), // 👈 navy blue boxes in dark mode
  );
}

class ThemeToggle extends StatelessWidget {
  final VoidCallback onToggle;
  final ThemeMode themeMode;

  const ThemeToggle({
    super.key,
    required this.onToggle,
    required this.themeMode,
  });

  @override
  Widget build(BuildContext context) {
    final isLight = themeMode == ThemeMode.light;

    return IconButton(
      tooltip: isLight ? 'Switch to dark' : 'Switch to light',
      onPressed: onToggle,
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) =>
            RotationTransition(turns: animation, child: child),
        child: isLight
            ? const Icon(
                Icons.light_mode,
                key: ValueKey('light'),
                color: Colors.white, // ✅ force white
              )
            : const Icon(
                Icons.dark_mode,
                key: ValueKey('dark'),
                color: Colors.white, // ✅ force white
              ),
      ),
    );
  }
}
